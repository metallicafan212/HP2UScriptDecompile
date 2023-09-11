//================================================================================
// HudItemManager.
//================================================================================

class HudItemManager extends Actor;

const BASE_RESOLUTION_X = 640.0;
const BASE_RESOLUTION_Y = 480.0;

// Omega: Alignment type
// Holdover from StatusGroup's new code but can be used for new HUD items anyway, so I'll leave it coded in
// And maintain it. However, the existing implementations with the hardcoded offsets won't be using this new
// system. This is for future coders of a HudItemManager subclass
// This also means that this class now holds a lot of math functions for scaling your rendered items on the 
// Canvas without having it move about when it's in other ratios than 4:3
var enum EAlignmentType
{
	AT_None,
	AT_Left,
	AT_Right,
	AT_Center,
	AT_Arbitrary
} AlignmentType;

// Omega: Set up PlayerHarry and HUD references
var Harry PlayerHarry;
var BaseHud HUD;
var float ScreenPctToAlignTo;

function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
	CheckHUDReferences();
}

// Omega: These classes really aren't set up to do stuff from the parent because they assumed this
// would be entirely boilerplate. Considering I need these references, I'm going to have to add this
// function because I'll need it a lot
function CheckHUDReferences()
{
	if(PlayerHarry == None || HUD == None)
	{
		PlayerHarry = Harry(Level.playerHarryActor);
		HUD = BaseHud(PlayerHarry.MyHud);
	}
}

// Omega: Math functions start here:
function float GetScaleFactor (Canvas Canvas)
{
	return Canvas.SizeX / BASE_RESOLUTION_X;
}

// Omega: Y Scale:
function float GetScaleFactorY (int nCanvasSizeY)
{
	local float fScale;

	fScale = nCanvasSizeY / BASE_RESOLUTION_Y;
	return fScale;
}

// Omega: Ratio of widths
function float GetHScale(Canvas Canvas)
{
	return (4.0 / 3.0) / (float(Canvas.SizeX) / float(Canvas.SizeY));
}

// Omega: Canvas-less version. Casts to float immediately due to the parameters being floats
function float floatGetHScale(float x, float y)
{
	return (4.0 / 3.0) / (x / y);
}

// Omega: Adjusted scale depending on your HUD4By3ScalePercent value, to help provide correct locations
// On scaled element groups
function float GetHAdjustedScale(Canvas Canvas)
{
	local float hScale;
	hScale = GetHScale(Canvas);
	// Omega: Return a corrected ratio for the hScale depending on our 4:3-ness
	return lerp(HUD.HUD4By3ScalePercent, hScale, 1.0);
}

// Omega: Adjust Canvas X coordinates for the 4:3-ness
function float GetHAdjustedX(Canvas Canvas)
{
	return lerp(HUD.HUD4By3ScalePercent, Canvas.SizeX, Canvas.SizeX * GetHScale(Canvas));
}

// Omega: Apply the HUD scale
function int ApplyHUDScale(Canvas Canvas, int nOutX)
{
	local float fScaledScreen;
	local float fCanvasX;
	local float tempX;

	fScaledScreen 	= GetHAdjustedX(Canvas);
	fCanvasX 		= Canvas.SizeX;
	tempX 			= nOutX;

	// Get the 4:3 ratio, scale it, add half of what was lost in width back on to recenter it
	tempX = (tempX * fScaledScreen / fCanvasX) + (0.5 * (fCanvasX - fScaledScreen));
	return tempX;
}

// Omega: Main alignment functionality, passes off to other functions
function AlignElement(Canvas Canvas, out int nOutX)
{
	Switch(AlignmentType)
	{
		Case AT_None:
			return;
		Case AT_Left:
			AlignXToLeft(Canvas, nOutX);
			return;
		Case AT_Right:
			AlignXToRight(Canvas, nOutX);
			return;
		Case AT_Center:
			AlignXToCenter(Canvas, nOutX);
			return;
		Case AT_Arbitrary:
			AlignXArbitrary(Canvas, nOutX);
			return;
		default:
			return;
	}
}

// Omega: Align ourselves to the right side of the screen
function AlignXToRight(Canvas Canvas, out int nOutX)
{
	//cm("AlignToRight: CanvasSizeX: " $Canvas.SizeX$ " GetHAdjustedScale: " $GetHAdjustedScale(Canvas)$ " Canvas: " $Canvas$ " nOutX: " $nOutX);
	nOutX = Canvas.SizeX - ((Canvas.SizeX - nOutX) * GetHAdjustedScale(Canvas));
}

// Omega: Much simpler for the left:
function AlignXToLeft(Canvas Canvas, out int nOutX)
{
	nOutX = nOutX * GetHAdjustedScale(Canvas);
}

function AlignXToCenter(Canvas Canvas, out int nOutX)
{
	//nOutX = (Canvas.SizeX * 0.5) - (((Canvas.SizeX * 0.5) - nOutX) * GetHAdjustedScale(Canvas));
	nOutX = (Canvas.SizeX * 0.5) - (((Canvas.SizeX * 0.5) - nOutX) * GetHScale(Canvas));
}

function AlignXArbitrary(Canvas Canvas, out int nOutX)
{
	nOutX = (Canvas.SizeX * ScreenPctToAlignTo) - (((Canvas.SizeX * ScreenPctToAlignTo) - nOutX) * GetHAdjustedScale(Canvas));
}

// Omega: Canvas-less versions. I don't think much use can come of these since the functions intentionally get lied to...
function float NoCanvasGetHAdjustedScale(int nCanvasSizeX, int nCanvasSizeY)
{
	local float hScale;
	hScale = floatGetHScale(nCanvasSizeX, nCanvasSizeY);
	// Omega: Return a corrected ratio for the hScale depending on our 4:3-ness
	return lerp(HUD.HUD4By3ScalePercent, hScale, 1.0);
}

function NoCanvasAlignXToRight(int nCanvasSizeX, int nCanvasSizeY, out int nOutX)
{
	nOutX = nCanvasSizeX - ((nCanvasSizeX - nOutX) * NoCanvasGetHAdjustedScale(nCanvasSizeX, nCanvasSizeY));
}

function NoCanvasAlignXToLeft(int nCanvasSizeX, int nCanvasSizeY, out int nOutX)
{
	nOutX = nOutX * NoCanvasGetHAdjustedScale(nCanvasSizeX, nCanvasSizeY);
}

// Omega: Used to determine horizontal offsets so they match their relative 4:3 offset
function float GetCanvasHHudScale(Canvas Canvas)
{
	local float fScaledWidth;
	// Omega: Safety first!
	if(HUD == None)
	{
		HUD = BaseHud(PlayerHarry.MyHud);
	}

	fScaledWidth = lerp(HUD.HUD4By3ScalePercent, Canvas.SizeX, Canvas.SizeX * GetHScale(Canvas));
	return (4.0 / 3.0) / (fScaledWidth / float(Canvas.SizeY));
}

function float floatGetHHUDScale(float x, float y)
{
	local float fScaledWidth;
	// Omega: Safety first!
	if(HUD == None)
	{
		HUD = BaseHud(PlayerHarry.MyHud);
	}

	fScaledWidth = lerp(HUD.HUD4By3ScalePercent, x, x * floatGetHScale(x,y));
	return (4.0 / 3.0) / (fScaledWidth / y);
}

defaultproperties
{
    // DrawType=0
	DrawType=DT_None
}
