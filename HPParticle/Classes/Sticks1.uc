//================================================================================
// Sticks1.
//================================================================================

class Sticks1 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=40.00)

    Lifetime=(Base=1.50,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=1.00,Rand=0.00)

    SizeWidth=(Base=12.00,Rand=6.00)

    SizeLength=(Base=12.00,Rand=6.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Elasticity=0.10

    Damping=3.20

    GravityModifier=0.50

    ParticlesMax=8

    Textures(0)=Texture'HPParticle.hp_fx.Particles.twig1'

    Style=STY_Masked
}
