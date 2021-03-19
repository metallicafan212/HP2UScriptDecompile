//================================================================================
// DustCloud03_med.
//================================================================================

class DustCloud03_med extends Dustclouds;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=128.00,Rand=0.00)

    SourceHeight=(Base=128.00,Rand=0.00)

    SourceDepth=(Base=128.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=0.00)

    AngularSpreadHeight=(Base=45.00,Rand=0.00)

    Speed=(Base=80.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=3.00)

    ColorStart=(Base=(R=146,G=115,B=95,A=0),Rand=(R=157,G=121,B=94,A=0))

    ColorEnd=(Base=(R=141,G=121,B=114,A=0),Rand=(R=159,G=119,B=89,A=0))

    SizeWidth=(Base=32.00,Rand=16.00)

    SizeLength=(Base=32.00,Rand=16.00)

    SizeEndScale=(Base=-1.00,Rand=3.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=1.00

    Damping=0.75

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'
}
