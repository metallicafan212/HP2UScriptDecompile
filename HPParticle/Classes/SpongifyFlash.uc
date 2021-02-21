//================================================================================
// SpongifyFlash.
//================================================================================

class SpongifyFlash extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=96.00,Rand=0.00)

    SourceHeight=(Base=96.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=0.00)

    Lifetime=(Base=0.50,Rand=0.25)

    ColorStart=(Base=(R=120,G=34,B=206,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=133,G=18,B=194,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=16.00,Rand=16.00)

    SizeLength=(Base=16.00,Rand=16.00)

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16320,Yaw=0,Roll=0)
}
