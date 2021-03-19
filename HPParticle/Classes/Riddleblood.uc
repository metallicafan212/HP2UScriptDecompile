//================================================================================
// Riddleblood.
//================================================================================

class Riddleblood extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=0.00)

    SourceWidth=(Base=5.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=0.00)

    Lifetime=(Base=4.00,Rand=0.00)

    ColorStart=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=8.00,Rand=4.00)

    SizeLength=(Base=8.00,Rand=4.00)

    Elasticity=0.10

    Damping=4.00

    GravityModifier=0.50

    ParticlesMax=80

    Textures=FireTexture'HPParticle.hp_fx.Particles.RiddleInk'

    Style=STY_Masked
}
