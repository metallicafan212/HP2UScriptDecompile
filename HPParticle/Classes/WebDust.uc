//================================================================================
// WebDust.
//================================================================================

class WebDust extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=24.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    SourceDepth=(Base=24.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=126,G=126,B=131,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=16.00,Rand=10.00)

    SizeLength=(Base=16.00,Rand=10.00)

    SizeEndScale=(Base=3.00,Rand=1.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=2.00

    Damping=2.00

    ParticlesMax=32

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke1'
}
