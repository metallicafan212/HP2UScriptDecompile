//================================================================================
// StatusGroupJellybeans.
//================================================================================

class StatusGroupJellybeans extends StatusGroup;

// DivingDeep39: Omega:
/*function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, Canvas.SizeX, Canvas.SizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}*/

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(nCanvasSizeX);
	nOutX 			= fScaleFactor * 4;
	nOutY 			= fScaleFactor * 70;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
{
	local int nFinalX;
	local int nFinalY;
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(Canvas.SizeX);
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	nX 				= nFinalX;
	nY 				=  -(fScaleFactor * nIconHeight);
}

defaultproperties
{
    fTotalEffectInTime=0.30

    fTotalHoldTime=3.00

    fTotalEffectOutTime=0.30
	
	// DivingDeep39: Omega:
	AlignmentType=AT_Left
}