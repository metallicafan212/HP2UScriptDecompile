//================================================================================
// Fireworks7.
//================================================================================

class Fireworks7 extends Fireworks;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=125.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=217,B=34,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=254,G=115,B=1,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=4.00)

    SizeLength=(Base=6.00,Rand=4.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Chaos=10.00

    ChaosDelay=1.00

    Damping=6.00

    GravityModifier=0.50

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'

    Rotation=(Pitch=16528,Yaw=0,Roll=0)
}
