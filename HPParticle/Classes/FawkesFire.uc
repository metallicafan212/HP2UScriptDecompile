//================================================================================
// FawkesFire.
//================================================================================

class FawkesFire extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    SourceDepth=(Base=25.00,Rand=0.00)

    AngularSpreadWidth=(Base=25.00,Rand=0.00)

    AngularSpreadHeight=(Base=15.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=25.00,Rand=0.00)

    Lifetime=(Base=1.50,Rand=5.00)

    SizeWidth=(Base=3.00,Rand=2.00)

    SizeLength=(Base=3.00,Rand=2.00)

    SpinRate=(Base=-8.00,Rand=8.00)

    Chaos=2.00

    GravityModifier=0.05

    Textures=Texture'HPParticle.hp_fx.Particles.White_Feather'
}
