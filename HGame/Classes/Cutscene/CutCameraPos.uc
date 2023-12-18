//================================================================================
// CutCameraPos.
//================================================================================

//class CutCameraPos extends NavigationPoint;
class CutCameraPos extends Keypoint; //extends from Keypoint to keep it compatible with the new engine -AdamJD

//texture import -AdamJD
#exec Texture Import File=Textures\Icons\CutCamIcon.PNG		GROUP=Icons	Name=CutCamIcon COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

defaultproperties
{
    Texture=Texture'HGame.Icons.CutCamIcon'

    DrawScale=0.50
	bDisplayFOVCone=true
}
