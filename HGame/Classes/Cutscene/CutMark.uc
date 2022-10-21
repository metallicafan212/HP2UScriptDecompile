//================================================================================
// CutMark.
//================================================================================

//class CutMark extends NavigationPoint;
class CutMark extends Keypoint; //extends from Keypoint to keep it compatible with the new engine -AdamJD

//texture import -AdamJD
#exec Texture Import File=Textures\Icons\CutMarkIcon.PNG	GROUP=Icons	Name=CutMarkIcon COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

defaultproperties
{
    Texture=Texture'HGame.Icons.CutMarkIcon'

    DrawScale=0.50

}
