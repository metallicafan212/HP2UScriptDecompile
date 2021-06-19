//================================================================================
// BroomShadow.
//================================================================================

class BroomShadow extends ActorShadow;

//texture import (BroomShadowT) -AdamJD 
#exec Texture Import File=Textures\BroomShadowT.png Name=BroomShadowT COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 //KW didn't add this to a group 

defaultproperties
{
    ShadowSizeFactor=0.90

    bOriented=True

    Texture=Texture'BroomShadowT'
}
