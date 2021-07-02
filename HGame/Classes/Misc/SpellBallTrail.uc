//================================================================================
// SpellBallTrail.
//================================================================================

class SpellBallTrail extends HProp;

defaultproperties
{
    LifeSpan=4.00

    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skSheetTestMesh'

    DrawScale=0.10

    bUnlit=True

    MultiSkins(0)=FireTexture'HPParticle.hp_fx.Particles.LessonTrail'

    CollisionRadius=10.00

    CollisionHeight=5.00

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False
}
