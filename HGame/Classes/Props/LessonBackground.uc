//================================================================================
// LessonBackground.
//================================================================================

class LessonBackground extends HProp;

defaultproperties
{
    Rotation=(Pitch=0,Yaw=0,Roll=-16320)

    // Style=2
	Style=STY_Masked

    Mesh=SkeletalMesh'HProps.skSheetTestMesh'

    AmbientGlow=0

    Opacity=0.50

    MultiSkins=WetTexture'HPParticle.hp_fx.General.LessonBackWet'

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False
}
