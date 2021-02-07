//================================================================================
// Fire01.
//================================================================================

class Fire01 extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=10.00)

    SourceWidth=(Base=24.00,Rand=0.00)

    SourceHeight=(Base=24.00,Rand=0.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    AngularSpreadWidth=(Base=40.00,Rand=0.00)

    AngularSpreadHeight=(Base=40.00,Rand=0.00)

    Speed=(Base=25.00,Rand=0.00)

    Lifetime=(Base=0.90,Rand=0.50)

    SizeWidth=(Base=24.00,Rand=0.00)

    SizeLength=(Base=24.00,Rand=0.00)

    SizeEndScale=(Base=1.75,Rand=0.80)

    SpinRate=(Base=8.00,Rand=16.00)

    Gravity=(X=0.00,Y=0.00,Z=50.00)

    Textures=Texture'HPParticle.particle_fx.PotFire08'

    AmbientSound=Sound'HPSounds.General.torch01'

    SoundRadius=16

    SoundVolume=96
}
