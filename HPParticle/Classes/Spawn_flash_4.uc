//================================================================================
// Spawn_flash_4.
//================================================================================

class Spawn_flash_4 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    Speed=(Base=20.00,Rand=30.00)

    Lifetime=(Base=0.50,Rand=0.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=89,G=60,B=210,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=75.00,Rand=0.00)

    SizeLength=(Base=75.00,Rand=0.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    ParticlesAlive=3

    ParticlesMax=3

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'

    CollisionRadius=40.00

    CollisionHeight=40.00
}
