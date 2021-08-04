//================================================================================
// EctoplasmaBIG.
//================================================================================

class EctoplasmaBIG extends Ectoplasma;

function float GetDefaultDrawScale()
{
  return Default.DrawScale;
}

defaultproperties
{
    fGrowTime=5.00

    ShrinkSound=Sound'HPSounds.Ch2Skurge.ecto_BIG_hit'

    fxParticlesPerSecond=65.00

    fxHitClass=Class'HPParticle.Skurge_hit2'

    AnimSequence=Idle

    AmbientSound=Sound'HPSounds.Ch2Skurge.ecto_BIG_idle'

    Mesh=SkeletalMesh'HPModels.skEctoplasmaBIGMesh'

    AmbientGlow=65

    CollisionRadius=95.00

}
