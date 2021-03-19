//================================================================================
// WebDustAragog.
//================================================================================

class WebDustAragog extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=900.00,Rand=100.00)

    SourceHeight=(Base=100.00,Rand=50.00)

    SourceDepth=(Base=900.00,Rand=100.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=4.00,Rand=2.00)

    ColorStart=(Base=(R=126,G=126,B=131,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=30.00,Rand=20.00)

    SizeLength=(Base=30.00,Rand=20.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=4.00

    GravityModifier=0.20

    ParticlesMax=200

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke1'
}
