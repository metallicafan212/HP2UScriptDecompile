//================================================================================
// BoomslangFX.
//================================================================================

class BoomslangFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=300.00,Rand=10.00)

    SourceWidth=(Base=5.00,Rand=5.00)

    SourceHeight=(Base=25.00,Rand=5.00)

    SourceDepth=(Base=60.00,Rand=2.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=192,G=192,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=128,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=3.00)

    SizeLength=(Base=1.00,Rand=3.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    SizeGrowPeriod=0.20

    Chaos=0.50

    Damping=0.50

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    CollisionRadius=30.00

    CollisionHeight=30.00
}
