//================================================================================
// Fireworks6.
//================================================================================

class Fireworks6 extends Fireworks;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=100.00,Rand=50.00)

    ColorStart=(Base=(R=222,G=34,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=252,G=3,B=60,A=0),Rand=(R=0,G=0,B=0,A=0))

    SpinRate=(Base=-3.00,Rand=6.00)

    Damping=4.00

    ParticlesMax=80

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'

    Rotation=(Pitch=16528,Yaw=0,Roll=0)
}
