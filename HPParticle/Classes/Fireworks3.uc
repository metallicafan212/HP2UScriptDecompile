//================================================================================
// Fireworks3.
//================================================================================

class Fireworks3 extends Fireworks;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=125.00,Rand=0.00)

    ColorStart=(Base=(R=254,G=150,B=35,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=238,G=216,B=17,A=0),Rand=(R=0,G=0,B=0,A=0))

    SpinRate=(Base=-3.00,Rand=6.00)

    Damping=4.00

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'

    Rotation=(Pitch=16528,Yaw=0,Roll=0)
}
