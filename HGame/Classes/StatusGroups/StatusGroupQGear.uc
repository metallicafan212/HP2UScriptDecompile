//================================================================================
// StatusGroupQGear.
//================================================================================

class StatusGroupQGear extends StatusGroup;

function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, Canvas.SizeX, Canvas.SizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(nCanvasSizeX);
	nOutY 			= fScaleFactor * 140;
	nOutX 			= fScaleFactor * 4;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local int nFinalX;
	local int nFinalY;
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(Canvas.SizeX);
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	nOutX 			= nFinalX;
	nOutY 			= Canvas.SizeY + (nIconHeight * fScaleFactor);
	
}

defaultproperties
{
    bDisplayHorizontally=False

    fTotalEffectInTime=0.50

    fTotalHoldTime=3.00

    fTotalEffectOutTime=0.20

    MenuProps=Menu_IfCurrentlyHaveAny

}