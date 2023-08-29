//================================================================================
// StatusItemHealth.
//================================================================================

class StatusItemHealth extends StatusItem;

// Metallicafan212:	Import the textures
#exec Texture Import File=Textures\Health\HP2HealthBorder.png Name=HP2HealthBorder Group=Health COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Health\HP2HealthOrangeInside.png Name=HP2HealthOrangeInside Group=Health COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914

var Texture textureHealthBorder;
var Texture textureHealthOrangeInside;
var Texture textureHealthBlack;
var int nCurrChange;
var float fTotalFadeTime;
var float fCurrFadeTime;
var int nUnitsPerIcon;
var int nMaxIcons;
const CHANGE_PERPOINT_FADE= 0.026;
const CHANGE_BASE_FADE= 0.2;
const CHANGE_PERPOINT_HOLD= 0.055;
const CHANGE_BASE_HOLD= 0.2;
const nSPACE_BETWEEN_ROWS= 4;
const nHEALTH_Y= 4;
const nHEALTH_X= 4;
const BOTTOM_OFFSET= 11;
const TOP_OFFSET= 1;

event PreBeginPlay()
{
	local string strHealthBorder;
	local string strHealthGreenInside;
	local string strHealthRedInside;
	local string strHealthOrangeInside;
	local string strHealthBlack;

	Super.PreBeginPlay();
	strHealthBorder 			= "HGame.Health.HP2HealthBorder";
	strHealthBlack 				= "HP2_Menu.Icons.HP2HealthBlack";
	strHealthOrangeInside 		= "HGame.Health.HP2HealthOrangeInside";
	textureHealthBorder 		= Texture(DynamicLoadObject(strHealthBorder,Class'Texture'));
	textureHealthBlack 			= Texture(DynamicLoadObject(strHealthBlack,Class'Texture'));
	textureHealthOrangeInside 	= Texture(DynamicLoadObject(strHealthOrangeInside,Class'Texture'));
}

function IncrementCount (int nNum)
{
	Super.IncrementCount(nNum);
	nCurrChange = nNum;
	GotoState('HoldChange');
}

function IncrementCountPotential (int nNum)
{
	Super.IncrementCountPotential(nNum);
	if ( nNum > 0 )
	{
		nCount = nCurrCountPotential;
	}
}

function Color GetHealthDrawColor()
{
	local Color colorReturn;

	colorReturn.R = 255;
	colorReturn.G = 255;
	colorReturn.B = 255;
	return colorReturn;
}

function Color GetChangeInHealthDrawColor()
{
	local Color colorReturn;

	colorReturn.R = 0;
	colorReturn.G = 0;
	colorReturn.B = 0;
	return colorReturn;
}

function DrawItem (Canvas Canvas, int nCurrX, int nCurrY, float fScaleFactor)
{
	local int nX;
	local int nY;
	local float fSegmentHeight;
	local float fSegmentStartAt;
	local int nTotalOffsets;
	local Texture textureEmpty;
	local Color colorSave;
	local byte byStyleSave;
	local int I;
	local int nNumHealthIcons;
	local int nRemainingCount;
	local float fFillRatio;
	local float fCurrBarBeforeEffect;
	local float fCurrBarAfterEffect;
	local float UScale;
	local float VScale;
	local bool bSavedNoSmooth;
	
	bSavedNoSmooth = Canvas.bNoSmooth;
	
	if(bSmoothIcons)
		Canvas.bNoSmooth = false;
	
	// Metallicafan212:	Scale by the height as well
	fScaleFactor *= GetHScale(Canvas);

	// Omega: Add the nCurrX and nCurrY vars
	nX = 5 * fScaleFactor + nCurrX;
	nY = 5 * fScaleFactor + nCurrY;

	sgParent.AlignElement(Canvas, nX);
	
	fSegmentHeight = 0.0;
	fSegmentStartAt = 0.0;
	nTotalOffsets = TOP_OFFSET + BOTTOM_OFFSET;
	nNumHealthIcons = nCurrCountPotential / nUnitsPerIcon;
	if ( nCurrCountPotential % nUnitsPerIcon > 0 )
	{
		++nNumHealthIcons;
	}
	nRemainingCount = nCount;
	byStyleSave = Canvas.Style;
	colorSave = Canvas.DrawColor;
	
	// Metallicafan212:	This is a for loop
	for(I = 0; I < nNumHealthIcons; I++)
	{
		nY = nHEALTH_Y * fScaleFactor;

		if ( nRemainingCount >= nUnitsPerIcon )
		{
			fFillRatio = 1.0;
		} 
		else 
		{
			fFillRatio = (float(nRemainingCount) / float(nUnitsPerIcon));
		}
		nRemainingCount -= nUnitsPerIcon;
		if ( nRemainingCount < 0 )
		{
			nRemainingCount = 0;
		}
		
		// Metallicafan212: Health first
		Canvas.Style = byStyleSave;
		Canvas.SetPos(nX, nY);
		
		if (  !IsInState('NormalDisplay') )
		{
			fCurrBarAfterEffect = (float(nCount) / float(nUnitsPerIcon));
			if ( (fCurrBarAfterEffect >= I) && (fCurrBarAfterEffect <= I + 1) )
			{
				Canvas.DrawColor = GetHealthDrawColor();
			}
		}
		if ( fFillRatio > 0 )
		{		
			// Metallicafan212:	For moving it down
			UScale = XScale / textureHealthOrangeInside.USize;
			VScale = YScale / textureHealthOrangeInside.VSize;
		
			fSegmentHeight 		= fFillRatio * ((textureHudIcon.VSize * VScale) - nTotalOffsets);
			fSegmentStartAt 	= (textureHudIcon.VSize * VScale) - 11 - fSegmentHeight;
			fSegmentHeight 	   += 11;
			
			Canvas.SetPos(nX, nY + fSegmentStartAt * fScaleFactor);			
			
			Canvas.DrawTile(textureHealthOrangeInside, textureHealthOrangeInside.USize * fScaleFactor * UScale, fSegmentHeight * fScaleFactor, 0.0, fSegmentStartAt / VScale, textureHudIcon.USize, fSegmentHeight / VScale);
		}
		
		// Metallicafan212:	Same here, scale it
		UScale = XScale / textureHealthBorder.USize;
		VScale = YScale / textureHealthBorder.VSize;
		
		// Metallicafan212:	Move it back over
		Canvas.SetPos(nX, nY);
		
		// Metallicafan212:	Reset the draw color
		Canvas.DrawColor.R = 255;
		Canvas.DrawColor.G = 255;
		Canvas.DrawColor.B = 255;
		Canvas.DrawTile(textureHealthBorder, textureHealthBorder.USize * fScaleFactor * UScale, textureHealthBorder.VSize * fScaleFactor * VScale, 0, 0, textureHealthBorder.USize, textureHealthBorder.VSize );
		
		// Metallicafan212:	Next icon
		nX += nActualIconW * fScaleFactor;
	}
	Canvas.DrawColor = colorSave;
	
	Canvas.bNoSmooth = bSavedNoSmooth;
}

auto state NormalDisplay
{
	function BeginState()
	{
		nCurrChange = 0;
	}
}

state HoldChange
{
	function Timer()
	{
		GotoState('FadeChangeOut');
	}
  
	function Color GetHealthDrawColor()
	{
		local Color colorReturn;
  
		if ( nCurrChange < 0 )
		{
			colorReturn.R = 255;
			colorReturn.G = 0;
		} 
		else 
		{
			colorReturn.R = 0;
			colorReturn.G = 255;
		}
		colorReturn.B = 0;
		return colorReturn;
	}
  
	function Color GetChangeInHealthDrawColor()
	{
		local Color colorReturn;
  
		colorReturn.R = 255;
		colorReturn.G = 255;
		colorReturn.B = 255;
		return colorReturn;
	}
  
	function float GetHoldChangeTime()
	{
		local float fHoldTime;
  
		fHoldTime = ((Abs(nCurrChange) - 1) * CHANGE_PERPOINT_HOLD) + CHANGE_BASE_HOLD;
		if ( fHoldTime > 5.0 )
		{
			fHoldTime = 5.0;
		}
		return fHoldTime;
	}
  
	function BeginState()
	{
		SetTimer(GetHoldChangeTime(),False);
	}
  
}

state FadeChangeOut
{
	//UTPT added this for some reason -AdamJD
	// ignores  GetChangeInHealthDrawColor, GetHealthDrawColor;
  
	event Tick (float fDelta)
	{
		local float fBlueGreen;
  
		if ( fCurrFadeTime <= fTotalFadeTime )
		{
			fCurrFadeTime += fDelta;
			if ( fCurrFadeTime >= fTotalFadeTime )
			{
				fCurrFadeTime = fTotalFadeTime;
				GotoState('NormalDisplay');
			}
		}
	}
	
	//UTPT didn't add this for some reason -AdamJD
	function Color GetHealthDrawColor()
	{
		local Color colorReturn;
		local float fFade;

		fFade = 255 * (fCurrFadeTime / fTotalFadeTime);
		if ( nCurrChange <= 0 )
		{
			colorReturn.R = 255;
			colorReturn.G = fFade;
			colorReturn.B = fFade;
		}
		else
		{
			colorReturn.R = fFade;
			colorReturn.G = 255;
			colorReturn.B = fFade;
		}
		return colorReturn;
	}
	
	//UTPT didn't add this for some reason -AdamJD
	function Color GetChangeInHealthDrawColor()
	{
		local Color colorReturn;
		local float fColor;

		fColor = 255 - (255 * (fCurrFadeTime / fTotalFadeTime));
		colorReturn.R = fColor;
		colorReturn.G = fColor;
		colorReturn.B = fColor;
		return colorReturn;
	}
  
	function float GetFadeChangeTime()
	{
		local float fChangeTime;
  
		fChangeTime = ((Abs(nCurrChange) - 1) * CHANGE_PERPOINT_FADE) + CHANGE_BASE_FADE;
		if ( fChangeTime > 5.0 )
		{
			fChangeTime = 5.0;
		}
		return fChangeTime;
	}
  
	function BeginState()
	{
		fCurrFadeTime = 0.0;
		fTotalFadeTime = GetFadeChangeTime();
	}
  
}

defaultproperties
{
    nUnitsPerIcon=100

    nMaxIcons=6

    strHudIcon="HGame.Health.HP2HealthBorder"

    bDisplayCount=True

    bDisplayMaxCount=True

    nCount=100

    nMaxCount=600

    nCurrCountPotential=100

    nActualIconW=21

    nActualIconH=64

    strToolTipId="InGameMenu_0022"
	
	bSmoothIcons=1

}