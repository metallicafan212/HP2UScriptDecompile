//================================================================================
// Bicorn.
//================================================================================

class Bicorn extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=10.00)

    SourceWidth=(Base=30.00,Rand=5.00)

    SourceHeight=(Base=30.00,Rand=5.00)

    SourceDepth=(Base=20.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=5.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=78,G=65,B=241,A=0),Rand=(R=117,G=0,B=247,A=0))

    ColorEnd=(Base=(R=100,G=175,B=67,A=0),Rand=(R=55,G=247,B=34,A=0))

    SizeWidth=(Base=2.00,Rand=2.00)

    SizeLength=(Base=6.00,Rand=12.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Chaos=2.00

    Attraction=(X=5.00,Y=5.00,Z=0.00)

    Damping=0.50

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'
}
