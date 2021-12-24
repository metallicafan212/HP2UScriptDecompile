//================================================================================
// HudItemManager.
//================================================================================

class HudItemManager extends Actor;

const BASE_RESOLUTION_X= 640.0;

function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
}

function float GetScaleFactor (Canvas Canvas)
{
	return Canvas.SizeX / BASE_RESOLUTION_X;
}

defaultproperties
{
    // DrawType=0
	DrawType=DT_None
}
