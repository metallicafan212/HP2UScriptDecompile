//================================================================================
// Fireworks5.
//================================================================================

class Fireworks5 extends Fireworks;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=100.00,Rand=50.00)

    ColorStart=(Base=(R=211,G=78,B=112,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=185,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=12.00)

    SizeLength=(Base=6.00,Rand=12.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Damping=4.00

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'

    Rotation=(Pitch=16528,Yaw=0,Roll=0)
}
