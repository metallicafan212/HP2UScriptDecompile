//================================================================================
// StatusGroup.
//================================================================================

class StatusGroup extends Actor
	Abstract; 

enum EMenuProps 
{
	Menu_Always,
	Menu_IfEverHadAny,
	Menu_IfCurrentlyHaveAny,
	Menu_Never
};

enum EEffectType 
{
	ET_Fade,
	ET_Fly,
	ET_Permanent,
	ET_Menu
};

// Omega: Alignment type
var enum EAlignmentType
{
	AT_None,
	AT_Left,
	AT_Right,
	AT_Center,
	AT_Arbitrary
} AlignmentType;

// Omega: Used for AT_Arbitrary, intended 0-1 percentage to multiply against Canvas.SizeX
var float ScreenPctToAlignTo;

var StatusGroup sgNext;
var StatusItem siList;
var StatusManager smParent;
var float fCurrEffectInTime;
var float fCurrEffectOutTime;
var EEffectType CurrEffectType;
var bool bDisplayJustFirstItem;
var bool bDisplayHorizontally;
var int nSpaceBetweenIcons;
var float fTotalEffectInTime;
var float fTotalHoldTime;
var float fTotalEffectOutTime;
var EEffectType GameEffectType;
var bool bDisplayOnMenu;
var EMenuProps MenuProps;
var bool bNormallyRenderInCutScene;
var bool bCurrRenderInCutScene;

// Omega: Our Harry and HUD vars
var harry PlayerHarry;
var BaseHud HUD;

const FLY_TO_HUD_CAM_DIST= 150;
const BASE_RESOLUTION_X= 640.0;

// Omega: Our 4:3 const height for our coords
// Internal grid is *kind of* 640x480, but using float math we can get more 
// accurate results for higher resolutions before casting back down to an int
const BASE_RESOLUTION_Y = 480.0;

// Omega: Set up the 4:3 height transform on Y, and the X transform for our user configured HUD 4:3-ness
// Note that this is defined in many of KW's classes unnecessarily, and removed in the widescreen mod from those files
// IF YOU MADE YOUR OWN GROUPS, MAKE SURE YOU FORWARD THESE CHANGES!!!
function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	// DivingDeep39: GetGroupFinalXY_2(bMenuMode,Canvas.SizeX,Canvas.SizeY,nIconWidth,nIconHeight,nOutX,nOutY);
	
	// Omega: Pass in transformed Y scale (4:3 ratio)
	GetGroupFinalXY_2(bMenuMode,Canvas.SizeX,(Canvas.SizeY / GetHScale(Canvas)),nIconWidth,nIconHeight,nOutX,nOutY);
}

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	Log("Error:  Derived StatusGroup objects should override GetGroupFinalXY_2");
	nOutX = 0;
	nOutY = 0;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	Log("Error:  Derived StatusGroup objects should override GetGroupFlyOriginXY");
	nOutX = 0;
	nOutY = 0;
}

function SetEffectTypeToPermanent()
{
	CurrEffectType = ET_Permanent;
	SetTimer(0.0,False);
	GotoState('Hold');
}

function SetEffectTypeToNormal()
{
	CurrEffectType = GameEffectType;
	GotoState('Idle');
}

function SetCutSceneRenderModeToNormal()
{
	bCurrRenderInCutScene = bNormallyRenderInCutScene;
}

function SetCutSceneRenderMode (bool bRenderInCutScenes)
{
	bCurrRenderInCutScene = bRenderInCutScenes;
}

function StatusItem GetStatusItem (Class<StatusItem> classItem)
{
	local StatusItem siLoop;

	if ( siList == None )
	{
		siList = Spawn(classItem);
		siList.sgParent = self;
		return siList;
	}
	
	// Metallicafan212:	This is obiously a loop
	for(siLoop = siList; siLoop != None; siLoop = siLoop.siNext)
	{
		if ( siLoop.Class == classItem )
		{
			return siLoop;
		}
		if ( siLoop.siNext == None )
		{
			siLoop.siNext = Spawn(classItem);
			siLoop.siNext.sgParent = self;
			return siLoop.siNext;
		}
	}

	Log("Error: StatusGroup::GetStatusItem- should not get to here");
	return None;
}

function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
	local StatusItem siLoop;
	local int nCurrX;
	local int nCurrY;
	local bool bFirstIconInList;
	local Color colorSave;
	local float fScaleFactor;
	local bool bIncrementPosition;
	
	// DivingDeep39: Omega:
	local float fScaledScreen;
	local float fCanvasX;
	
	// Omega: Check the validitiitieaiwidoawdhy of the hud 
	if(HUD == None)
	{
		HUD = BaseHud(PlayerHarry.MyHud);
	}
	
	// Omega: Scale the screen by our 4:3-ness ratio using a lerp
	fScaledScreen = lerp(HUD.HUD4By3ScalePercent, Canvas.SizeX, Canvas.SizeX * GetHScale(Canvas));
	fCanvasX = Canvas.SizeX;

	nCurrX = 0;
	nCurrY = 0;
	bFirstIconInList = True;
	fScaleFactor = GetScaleFactor(Canvas.SizeX);
	if ( bMenuMode )
	{
		return;
	}
	if (  !bMenuMode &&  !bCurrRenderInCutScene && bFullCutMode )
	{
		return;
	}
	HandleMenuModeSwitching(bMenuMode);
	colorSave = Canvas.DrawColor;
	Canvas.DrawColor = GetDrawColor();
	
	// Metallicafan212:	Again, this is a loop
	for(siLoop = siList; siLoop != none; siLoop = siLoop.siNext)
	{
		if ( bMenuMode ||  !bMenuMode && (siLoop.bMenuModeOnly == False) )
		{
			if ( bFirstIconInList == True )
			{
				GetGroupCurrXY(bMenuMode, Canvas,siLoop.GetHudIconUSize(), siLoop.GetHudIconVSize(), nCurrX, nCurrY);
				
				// Omega: Align the element based on our settings (Default no alignment)
				AlignElement(Canvas, nCurrX);
				nCurrX = (nCurrX * fScaledScreen/fCanvasX) + (0.5 * (fCanvasX - fScaledScreen));
				
				bFirstIconInList = False;
			}
			if ( (siLoop.nCount > 0) || (siLoop.nCount == 0) && (siLoop.bDisplayWhenCountZero == True) )
			{
				siLoop.DrawItem(Canvas, nCurrX, nCurrY, fScaleFactor);
				bIncrementPosition = True;
			} 
			else 
			{
				bIncrementPosition = siLoop.bIncrementPosWhenCountZero;
			}
			if ( bIncrementPosition )
			{
				if ( bDisplayHorizontally )
				{
					// Omega: Take vertical scale into account to correct the horizontal offset to our aspect ratio. Check silver keys as example
					//nCurrX += fScaleFactor * (siLoop.GetHudIconUSize() + nSpaceBetweenIcons);
					nCurrX += (fScaleFactor * (siLoop.GetHudIconUSize() + nSpaceBetweenIcons)) * GetHScale(Canvas);
				}
				else
				{
					nCurrY += fScaleFactor * (siLoop.GetHudIconVSize() + nSpaceBetweenIcons);
				}
			}
			
			// Metallicafan212:	From the proto
			if (bDisplayJustFirstItem)
            {
				//the log bit got removed between proto and retail(probably because it spams the log) -AdamJD
                //log("displayjustfirst");
			    break;
            }
			
		}
	}
	
	Canvas.DrawColor = colorSave;
}

function HandleMenuModeSwitching (bool bMenuMode)
{
	if ( bMenuMode )
	{
		CurrEffectType = ET_Menu;
		if (!IsInState('Hold'))
		{
			GotoState('Hold');
		}
	} 
	else if ( CurrEffectType == ET_Menu )
	{
		CurrEffectType = GameEffectType;
		if (  !IsInState('Idle') && (CurrEffectType != ET_Permanent) )
		{
			GotoState('Idle');
		}
	}
}

function GetItemPosition (Class<StatusItem> classItem, bool bMenuMode, out int nOutX, out int nOutY, optional int nCanvasSizeX, optional int nCanvasSizeY)
{
	local StatusItem si;
	local StatusItem siLoop;
	local bool bFirstInList;
	local float fScaleFactor;

	nOutX = 0;
	nOutY = 0;
	if ( nCanvasSizeX == 0 )
	{
		nCanvasSizeX = smParent.nCanvasSizeX;
	}
	if ( nCanvasSizeY == 0 )
	{
		nCanvasSizeY = smParent.nCanvasSizeY;
	}
	
	bFirstInList = True;
	fScaleFactor = GetScaleFactor(nCanvasSizeX);
	si = GetStatusItem(classItem);
	
	if ( si == None )
	{
		Log("Error:  Could not get StatusItem " $ string(classItem));
	}
	
	// Metallicafan212:	Loop loops loops
	for(siLoop = siList; siLoop != none; siLoop = siLoop.siNext)
	{
		if ( bFirstInList == True )
		{
			GetGroupCurrXY_2(bMenuMode,nCanvasSizeX,nCanvasSizeY,siLoop.GetHudIconUSize(),siLoop.GetHudIconVSize(),nOutX,nOutY);
			bFirstInList = False;
		}
		if ( siLoop.Class == si.Class )
		{
			break;
		}
		if ( bDisplayHorizontally )
		{
			nOutX += fScaleFactor * (siLoop.GetHudIconUSize() + nSpaceBetweenIcons);
		}
		else
		{
			nOutY += fScaleFactor * (siLoop.GetHudIconVSize() + nSpaceBetweenIcons);
		}
		
		// Metallicafan212:	From the proto
		if (bDisplayJustFirstItem)
		    break;
	}
}

function Vector GetItemLocation (Class<StatusItem> classItem, bool bMenuMode, optional bool bUpperLeft)
{
	local int nHudX;
	local int nHudY;
	local int nCanvasHalfX;
	local int nCanvasHalfY;
	local float fXVal;
	local float fYVal;
	local Vector vectReturn;
	local float fCameraPitch;
	local StatusItem si;

	GetItemPosition(classItem,bMenuMode,nHudX,nHudY);
	if (  !bUpperLeft )
	{
		si = GetStatusItem(classItem);
		nHudX += (si.GetHudIconUSize() / 4);
		nHudY += (si.GetHudIconVSize() / 4);
	}
	nCanvasHalfX = smParent.nCanvasSizeX / 2;
	nCanvasHalfY = smParent.nCanvasSizeY / 2;
	if ( nHudX >= nCanvasHalfX )
	{
		// fXVal = float(nHudX - nCanvasHalfX) / float(nCanvasHalfX);
		fXVal = (nHudX - nCanvasHalfX) / float(nCanvasHalfX); //removed wrong float casts -AdamJD
	} 
	else 
	{
		// fXVal =  -1.0 - float(nHudX) / float(nCanvasHalfX);
		fXVal =  -(1 - (nHudX / float(nCanvasHalfX))); //removed wrong float casts -AdamJD
	}
	if ( nHudY <= nCanvasHalfY )
	{
		// fYVal = 1.0 - float(nHudY) / float(nCanvasHalfY);
		fYVal = 1 - (nHudY / float(nCanvasHalfY)); //removed wrong float casts -AdamJD
	} 
	else 
	{
		// fYVal =  -1 - float((nHudY - nCanvasHalfY)) / float(nCanvasHalfY);
		fYVal =  -(1 - ((nHudY - nCanvasHalfY) / float(nCanvasHalfY))); //removed wrong float casts -AdamJD
	}
	fCameraPitch = Normalize(smParent.PlayerHarry.Cam.Rotation).Pitch;
	if ( fCameraPitch > 32768 )
	{
		// fYVal = fYVal - 1.0 - fCameraPitch / 65536;
		fYVal = fYVal - (1 - (fCameraPitch / 65536)); //added BODMAS -AdamJD
	} 
	else 
	{
		// fYVal = fYVal + fCameraPitch / 65536;
		fYVal = fYVal + (fCameraPitch / 65536); //added BODMAS -AdamJD
	}
	vectReturn.X = fXVal;
	vectReturn.Y = fYVal;
	vectReturn.Z = FLY_TO_HUD_CAM_DIST;
	vectReturn = smParent.PlayerHarry.CameraToWorld(vectReturn);
	return vectReturn;
}

function Color GetDrawColor()
{
	local Color colorReturn;
	local int nFadeValue;

	nFadeValue 		= GetFadeValue();
	colorReturn.R 	= nFadeValue;
	colorReturn.G 	= nFadeValue;
	colorReturn.B 	= nFadeValue;
	return colorReturn;
}

function GetGroupCurrXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
{
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nX, nY);
}

function GetGroupCurrXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, nCanvasSizeX, nCanvasSizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}

function int GetFadeValue()
{
	return 255;
}

function bool IncrementCount (Class<StatusItem> classItem, int nNum)
{
	local StatusItem siUpdate;

	siUpdate = GetStatusItem(classItem);
	if ( siUpdate != None )
	{
		siUpdate.IncrementCount(nNum);
		
		// DivingDeep39: OnCountIncremented();
		// Omega: Added to facilitate child classes that need to know what was updated
		OnCountIncremented(siUpdate);
		
		return True;
	}
	return False;
}

function bool IncrementCountPotential (Class<StatusItem> classItem, int nNum)
{
	local StatusItem siUpdate;

	siUpdate = GetStatusItem(classItem);
	if ( siUpdate != None )
	{
		siUpdate.IncrementCountPotential(nNum);
		
		// DivingDeep39: OnCountIncremented();
		// Omega: Added to facilitate child classes that need to know what was updated
		OnCountIncremented(siUpdate);
		
		return True;
	}
	return False;
}

// DivingDeep39:
/*function OnCountIncremented()
{
}*/

// Omega: Added param to facilitate child classes that need to know what was updated
function OnCountIncremented(StatusItem Item)
{

}

function float GetTimeRatio (float fCurrTime, float fTotalTime)
{
	if ( fTotalTime < fCurrTime )
	{
		return 1.0;
	} 
	else 
	{
		return (fTotalTime - fCurrTime) / fTotalTime;
	}
}

function int CalcFadeValue (bool bIn, float fCurrTime, float fTotalTime)
{
	local float fFadeRatio;
	local int nFadeValue;

	fFadeRatio = GetTimeRatio(fCurrTime,fTotalTime);
	if (bIn)
	{
		nFadeValue = 127 + (128 * fFadeRatio);
		if ( Clamp(nFadeValue, 127, 255) != nFadeValue )
		{
			Log("Error:  Error in fade value calculation");
			nFadeValue = Clamp(nFadeValue, 127, 255);
		}
	}
	else 
	{
		nFadeValue = 255 - (128 * fFadeRatio);
		if ( Clamp(nFadeValue, 127, 255) != nFadeValue )
		{
			Log("Error:  Fade value should never be under 127");
			nFadeValue = Clamp(nFadeValue, 127, 255);
		}
	}
	return nFadeValue;
}

function CalcFlyXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, bool bFlyIn, float fCurrTime, float fTotalTime, out int nX, out int nY)
{
	local float fFlyRatio;
	local int nFinalX;
	local int nFinalY;
	local int nOriginFlyX;
	local int nOriginFlyY;
	local int nOffsetX;
	local int nOffsetY;
	local bool bFlyOriginFromTop;
	local bool bFlyOriginFromLeft;

	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	GetGroupFlyOriginXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nOriginFlyX, nOriginFlyY);
	fFlyRatio 				= GetTimeRatio(fCurrTime, fTotalTime);
	bFlyOriginFromTop 		= nFinalY > nOriginFlyY;
	bFlyOriginFromLeft 		= nFinalX > nOriginFlyX;
	if ( bFlyOriginFromTop )
	{
		nOffsetY = (nFinalY - nOriginFlyY) * fFlyRatio;
		if ( bFlyIn )
		{
			nY = nOriginFlyY + nOffsetY;
		} 
		else 
		{
			nY = nFinalY - nOffsetY;
		}
	} 
	else 
	{
		nOffsetY = (nOriginFlyY - nFinalY) * fFlyRatio;
		if ( bFlyIn )
		{
			nY = nOriginFlyY - nOffsetY;
		} 
		else 
		{
			nY = nFinalY + nOffsetY;
		}
	}
	if ( bFlyOriginFromLeft )
	{
		nOffsetX = (nFinalX - nOriginFlyX) * fFlyRatio;
		if ( bFlyIn )
		{
			nX = nOriginFlyX + nOffsetX;
		} 
		else 
		{
			nX = nFinalX - nOffsetX;
		}
	} 
	else 
	{
		nOffsetX = (nOriginFlyX - nFinalX) * fFlyRatio;
		if ( bFlyIn )
		{
			nX = nOriginFlyX - nOffsetX;
		} 
		else 
		{
			nX = nFinalX + nOffsetX;
		}
  }
}

function float GetScaleFactor (int nCanvasSizeX)
{
	local float fScale;

	fScale = nCanvasSizeX / BASE_RESOLUTION_X;
	return fScale;
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

// Omega: Set up the HUD reference
event PreBeginPlay()
{
	CurrEffectType = GameEffectType;
	
	// DivingDeep39: Omega:
	PlayerHarry = Harry(Level.playerHarryActor);
}

// DivingDeep39: Omega
event PostBeginPlay()
{
	Super.PostBeginPlay();
	// Omega: This fails on immediately spawned groups
	HUD = BaseHud(PlayerHarry.MyHud);
}

auto state Idle
{
	//DivingDeep39: function OnCountIncremented()
	function OnCountIncremented(StatusItem SI)
	{
		if ( (CurrEffectType == ET_Permanent) || (CurrEffectType == ET_Menu) )
		{
			GotoState('Hold');
		} 
		else 
		{
			GotoState('EffectIn');
		}
	}
  
	function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		if ( bDisplayOnMenu )
		{
			HandleMenuModeSwitching(bMenuMode);
		}
	}
  
	function BeginState()
	{
		if ( (CurrEffectType == ET_Permanent) || (CurrEffectType == ET_Menu) )
		{
			GotoState('Hold');
		}
	}
  
}

state EffectIn
{
	event Tick (float fDeltaTime)
	{
		if ( fCurrEffectInTime > 0.0 )
		{
			fCurrEffectInTime -= fDeltaTime;
			if ( fCurrEffectInTime < 0.0 )
			{
				fCurrEffectInTime = 0.0;
			}
		} 
		else 
		{
			GotoState('Hold');
		}
	}
  
	function int GetFadeValue()
	{
		local float fFadeRatio;
		local int nFadeValue;
		local int nFadeStart;
  
		if ( CurrEffectType == ET_Fade )
		{
			return CalcFadeValue(True, fCurrEffectInTime, fTotalEffectInTime);
		} 
		else 
		{
			return 255;
		}
  }
  
	function GetGroupCurrXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
	{
		if ( CurrEffectType == ET_Fly )
		{
			CalcFlyXY(bMenuMode, Canvas, nIconWidth, nIconHeight, True, fCurrEffectInTime, fTotalEffectInTime, nX, nY);
		} 
		else 
		{
			GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nX, nY);
		}
	}
  
	function BeginState()
	{
		fCurrEffectInTime = fTotalEffectInTime;
	}
  
}

state Hold
{
	event Timer()
	{
		SetTimer(0.0,False);
		GotoState('EffectOut');
	}
  
	// DivingDeep39: OnCountIncremented()
	function OnCountIncremented(StatusItem SI)
	{
		if ( (CurrEffectType != ET_Permanent) || (CurrEffectType == ET_Menu) )
		{
			SetTimer(0.0,False);
			SetTimer(fTotalHoldTime,False);
		}
	}
  
	function BeginState()
	{
		if ( (CurrEffectType != ET_Permanent) || (CurrEffectType == ET_Menu) )
		{
			SetTimer(fTotalHoldTime,False);
		}
	}
  
}

state EffectOut
{
	event Tick (float fDeltaTime)
	{
		if ( fCurrEffectOutTime > 0.0 )
		{
			fCurrEffectOutTime -= fDeltaTime;
			if ( fCurrEffectOutTime < 0.0 )
			{
				fCurrEffectOutTime = 0.0;
			}
		} 
		else 
		{
			GotoState('Idle');
		}
	}
  
	// DivingDeep39: function OnCountIncremented()
	function OnCountIncremented(StatusItem SI)
	{
		if ( (CurrEffectType != ET_Permanent) || (CurrEffectType == ET_Menu) )
		{
			GotoState('Hold');
		}
	}
  
	function int GetFadeValue()
	{
		local float fFadeRatio;
		local int nFadeValue;
		local int nFadeStart;
  
		if ( CurrEffectType == ET_Fade )
		{
			return CalcFadeValue(False, fCurrEffectOutTime, fTotalEffectOutTime);
		} 
		else 
		{
			return 255;
		}
	}
  
	function GetGroupCurrXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
	{
		if ( CurrEffectType == ET_Fly )
		{
			CalcFlyXY(bMenuMode, Canvas, nIconWidth, nIconHeight, False, fCurrEffectOutTime, fTotalEffectOutTime, nX, nY);
		} 
		else 
		{
			GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nX, nY);
		}
	}		
  
	function BeginState()
	{
		fCurrEffectOutTime = fTotalEffectOutTime;
	}
  
}

defaultproperties
{
    bDisplayHorizontally=True

    nSpaceBetweenIcons=4

    bHidden=True

    // DrawType=0
	DrawType=DT_None 
	
	// Omega: Vars to change for specific groups
	ScreenPctToAlignTo=0
	AlignmentType=AT_None
}
