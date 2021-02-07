//================================================================================
// Crabfireball.
//================================================================================

class Crabfireball extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=15.00,Rand=5.00)

    SourceWidth=(Base=15.00,Rand=5.00)

    SourceHeight=(Base=15.00,Rand=5.00)

    SourceDepth=(Base=15.00,Rand=5.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=25.00)

    Lifetime=(Base=2.00,Rand=1.00)

    SizeWidth=(Base=8.00,Rand=24.00)

    SizeLength=(Base=8.00,Rand=24.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    bSystemRelative=True

    Attraction=(X=10.00,Y=10.00,Z=10.00)

    Textures=Texture'HPParticle.particle_fx.PotFire07'

    Rotation=(Pitch=16384,Yaw=0,Roll=0)
}
