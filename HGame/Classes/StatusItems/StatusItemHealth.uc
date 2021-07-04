//================================================================================
// StatusItemHealth.
//================================================================================

class StatusItemHealth extends StatusItem;

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

event PreBeginPlay ()
{
	local string strHealthBorder;
	local string strHealthGreenInside;
	local string strHealthRedInside;
	local string strHealthOrangeInside;
	local string strHealthBlack;

	Super.PreBeginPlay();
	strHealthBorder = "HP2_Menu.Icons.HP2HealthBorder";
	strHealthBlack = "HP2_Menu.Icons.HP2HealthBlack";
	strHealthOrangeInside = "HP2_Menu.Icons.HP2HealthOrangeInside";
	textureHealthBorder = Texture(DynamicLoadObject(strHealthBorder,Class'Texture'));
	textureHealthBlack = Texture(DynamicLoadObject(strHealthBlack,Class'Texture'));
	textureHealthOrangeInside = Texture(DynamicLoadObject(strHealthOrangeInside,Class'Texture'));
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

function Color GetHealthDrawColor ()
{
	local Color colorReturn;

	colorReturn.R = 255;
	colorReturn.G = 255;
	colorReturn.B = 255;
	return colorReturn;
}

function Color GetChangeInHealthDrawColor ()
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
	
	// Metallicafan212:	Scale by the height as well
	fScaleFactor *= GetHScale(Canvas);

	
	nX = 5 * fScaleFactor;
	nY = 5 * fScaleFactor;
	fSegmentHeight = 0.0;
	fSegmentStartAt = 0.0;
	nTotalOffsets = 1 + 11;
	nNumHealthIcons = nCurrCountPotential / nUnitsPerIcon;
	if ( nCurrCountPotential % nUnitsPerIcon > 0 )
	{
		++nNumHealthIcons;
	}
	nRemainingCount = nCount;
	byStyleSave = Canvas.Style;
	colorSave = Canvas.DrawColor;
	
	// Metallicafan212:	This is a for loop
	for(i = 0; i < nNumHealthIcons; i++)
	{
		nY = 4 * fScaleFactor;
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
		Canvas.DrawColor.R = 255;
		Canvas.DrawColor.G = 255;
		Canvas.DrawColor.B = 255;
		Canvas.Style = 3;
		Canvas.SetPos(nX, nY);
		Canvas.DrawIcon(textureHealthBlack,fScaleFactor);
		Canvas.Style = byStyleSave;
		Canvas.SetPos(nX, nY);
		Canvas.DrawIcon(textureHealthBorder,fScaleFactor);
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
			fSegmentHeight = fFillRatio * (textureHudIcon.VSize - nTotalOffsets);
			fSegmentStartAt = textureHudIcon.VSize - 11 - fSegmentHeight;
			fSegmentHeight += 11;
			Canvas.SetPos(nX, nY + fSegmentStartAt * fScaleFactor);
			Canvas.DrawTile(textureHealthOrangeInside, textureHudIcon.USize * fScaleFactor, fSegmentHeight * fScaleFactor, 0.0, fSegmentStartAt, textureHudIcon.USize, fSegmentHeight);
		}
		nX += nActualIconW * fScaleFactor;
	}
	Canvas.DrawColor = colorSave;
}

auto state NormalDisplay
{
	function BeginState ()
	{
		nCurrChange = 0;
	}
}

state HoldChange
{
	function Timer ()
	{
		GotoState('FadeChangeOut');
	}
  
	function Color GetHealthDrawColor ()
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
  
	function Color GetChangeInHealthDrawColor ()
	{
		local Color colorReturn;
  
		colorReturn.R = 255;
		colorReturn.G = 255;
		colorReturn.B = 255;
		return colorReturn;
	}
  
	function float GetHoldChangeTime ()
	{
		local float fHoldTime;
  
		fHoldTime = (Abs(nCurrChange) - 1) * 0.055 + 0.2;
		if ( fHoldTime > 5.0 )
		{
			fHoldTime = 5.0;
		}
		return fHoldTime;
	}
  
	function BeginState ()
	{
		SetTimer(GetHoldChangeTime(),False);
	}
  
}

state FadeChangeOut
{
	ignores  GetChangeInHealthDrawColor, GetHealthDrawColor;
  
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
  
	function float GetFadeChangeTime ()
	{
		local float fChangeTime;
  
		fChangeTime = (Abs(nCurrChange) - 1) * 0.026 + 0.2;
		if ( fChangeTime > 5.0 )
		{
			fChangeTime = 5.0;
		}
		return fChangeTime;
	}
  
	function BeginState ()
	{
		fCurrFadeTime = 0.0;
		fTotalFadeTime = GetFadeChangeTime();
	}
  
}

defaultproperties
{
    nUnitsPerIcon=100

    nMaxIcons=6

    strHudIcon="HP2_Menu.Icons.HP2HealthEmpty"

    bDisplayCount=True

    bDisplayMaxCount=True

    nCount=100

    nMaxCount=600

    nCurrCountPotential=100

    nActualIconW=21

    nActualIconH=64

    strToolTipId="InGameMenu_0022"

}