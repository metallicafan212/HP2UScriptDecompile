//================================================================================
// Fordtrail.
//================================================================================

class Fordtrail extends FlyingFord;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=15.00,Rand=5.00)

    SourceWidth=(Base=100.00,Rand=0.00)

    SourceHeight=(Base=60.00,Rand=0.00)

    SourceDepth=(Base=60.00,Rand=0.00)

    Speed=(Base=10.00,Rand=15.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=128,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=60.00,Rand=4.00)

    SizeLength=(Base=30.00,Rand=4.00)

    SizeEndScale=(Base=0.00,Rand=1.00)

    Chaos=0.75

    ChaosDelay=1.00

    Damping=0.75

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'
}
