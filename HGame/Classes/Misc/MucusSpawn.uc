//================================================================================
// MucusSpawn.
//================================================================================

class MucusSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn=Class'FlobberwormMucus'

    Snds=(Opening=None,Closing=None,Spawning=Sound'HPSounds.hub1_sfx.vase_breaking')

    Limits=(Max=1,Min=1)

    BaseParticles=Class'HPParticle.GlassJarBreak'

    bDestroable=True

    Mesh=SkeletalMesh'HProps.skJarFlobberwormMucusMesh'

    DrawScale=1.20

    AmbientGlow=75

    MultiSkins=WetTexture'HPParticle.hp_fx.Particles.FlobberM'

    CollisionRadius=10.00

    CollisionHeight=18.00

    // CollideType=1
	CollideType=CT_OrientedCylinder
}
