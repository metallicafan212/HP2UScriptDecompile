//================================================================================
// Spawn_flash_2.
//================================================================================

class Spawn_flash_2 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=0.00)

    Speed=(Base=20.00,Rand=30.00)

    Lifetime=(Base=0.50,Rand=0.00)

    ColorStart=(Base=(R=252,G=142,B=22,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=247,G=255,B=142,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=120.00,Rand=50.00)

    SizeLength=(Base=120.00,Rand=50.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    SizeDelay=2.00

    Chaos=3.00

    ChaosDelay=0.50

    ParticlesAlive=5

    ParticlesMax=5

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'

    CollisionRadius=40.00

    CollisionHeight=40.00
}
