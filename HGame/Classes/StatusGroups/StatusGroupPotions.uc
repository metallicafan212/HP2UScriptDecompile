//================================================================================
// StatusGroupPotions.
//================================================================================

class StatusGroupPotions extends StatusGroup;

/*function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, Canvas.SizeX, Canvas.SizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}*/

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local float fScaleFactor;
	local int nObjectiveTop;
	local int nCutBorderHeight;

	fScaleFactor 	= GetScaleFactor(nCanvasSizeX);
	nOutX 			= nCanvasSizeX - (nIconWidth * fScaleFactor) - (fScaleFactor * 4);
	if ( bMenuMode && smParent.PlayerHarry.HaveObjectiveText() )
	{
		nObjectiveTop 	= HPConsole(smParent.PlayerHarry.Player.Console).menuBook.InGamePage.GetObjectiveAreaTop(nCanvasSizeX, nCanvasSizeY);
		nOutY 			= nObjectiveTop - (nIconHeight * fScaleFactor) - (5 * fScaleFactor);
	}
	else 
	{
		nCutBorderHeight 	= HPHud(smParent.PlayerHarry.myHUD).managerCutScene.GetMaxBorderHeightFromCanvasHeight(nCanvasSizeY);
		nOutY 				= nCanvasSizeY - (nIconHeight * fScaleFactor) - nCutBorderHeight;
	}
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local int nFinalX;
	local int nFinalY;
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(Canvas.SizeX);
	GetGroupFinalXY(bMenuMode,Canvas,nIconWidth,nIconHeight,nFinalX,nFinalY);
	nOutX 			= nFinalX;
	nOutY 			= Canvas.SizeY + (nIconHeight * fScaleFactor);
}

defaultproperties
{
    fTotalEffectInTime=0.50

    fTotalHoldTime=3.00

    fTotalEffectOutTime=0.20

    MenuProps=Menu_IfEverHadAny
	
	AlignmentType=AT_Right
}