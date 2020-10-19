//================================================================================
// SnakeBeam.
//================================================================================

class SnakeBeam extends HProp;

defaultproperties
{
    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skSnakeBeamMesh'

    AmbientGlow=200

    MultiSkins=WetTexture'HPParticle.hp_fx.General.SnakeEyesWet'

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False
}
