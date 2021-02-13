//================================================================================
// Fireworks4.
//================================================================================

class Fireworks4 extends Fireworks;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=125.00,Rand=0.00)

    Lifetime=(Base=4.00,Rand=1.00)

    ColorStart=(Base=(R=73,G=240,B=49,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=255,B=153,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=4.00)

    SizeLength=(Base=12.00,Rand=4.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Chaos=10.00

    ChaosDelay=1.00

    Damping=3.00

    GravityModifier=0.05

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'

    Rotation=(Pitch=16528,Yaw=0,Roll=0)
}
