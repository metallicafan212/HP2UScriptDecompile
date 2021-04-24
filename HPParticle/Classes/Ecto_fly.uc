//================================================================================
// Ecto_fly.
//================================================================================

class Ecto_fly extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=2.00)

    SourceHeight=(Base=1.00,Rand=2.00)

    SourceDepth=(Base=0.00,Rand=2.00)

    bSteadyState=True

    Speed=(Base=15.00,Rand=15.00)

    Lifetime=(Base=2.00,Rand=2.00)

    ColorStart=(Base=(R=104,G=167,B=78,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=66,G=167,B=37,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=15.00)

    SizeLength=(Base=6.00,Rand=15.00)

    SizeEndScale=(Base=-1.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    DripTime=(Base=0.50,Rand=0.00)

    Chaos=2.00

    Elasticity=0.10

    Damping=0.50

    GravityModifier=0.10

    Textures(0)=Texture'HPParticle.hp_fx.Particles.blob32'
}
