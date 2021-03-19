//================================================================================
// DustCloud04_med.
//================================================================================

class DustCloud04_med extends Dustclouds;

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

    ColorStart=(Base=(R=148,G=106,B=82,A=0),Rand=(R=143,G=131,B=92,A=0))

    ColorEnd=(Base=(R=141,G=121,B=114,A=0),Rand=(R=147,G=118,B=79,A=0))

    SizeWidth=(Base=32.00,Rand=16.00)

    SizeLength=(Base=32.00,Rand=16.00)

    SizeEndScale=(Base=2.00,Rand=1.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=1.00

    Damping=0.75

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'
}
