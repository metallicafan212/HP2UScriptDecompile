//================================================================================
// StatusGroupPolyIngr.
//================================================================================

class StatusGroupPolyIngr extends StatusGroup;

/*function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, Canvas.SizeX, Canvas.SizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}*/

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(nCanvasSizeX);
	nOutX 		= nCanvasSizeX - (fScaleFactor * nIconWidth) - (fScaleFactor * 4);
	nOutY 		= fScaleFactor * 166;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local int nFinalX;
	local int nFinalY;
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(Canvas.SizeX);
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	nOutX 			= nFinalX;
	nOutY 			= -(nIconHeight * fScaleFactor);
}

defaultproperties
{
	//some of the default props weren't decompiled right -AdamJD
	
    bDisplayHorizontally=False
	
	// GameEffectType=2 
    GameEffectType=ET_Permanent 

	// MenuProps=2
    MenuProps=Menu_IfCurrentlyHaveAny
	
	AlignmentType=AT_Right
}
