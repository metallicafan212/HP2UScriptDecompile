//================================================================================
// QuestionFX.
//================================================================================

class QuestionFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=200.00,Rand=50.00)

    SourceWidth=(Base=64.00,Rand=0.00)

    SourceHeight=(Base=64.00,Rand=0.00)

    SourceDepth=(Base=25.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=40.00,Rand=20.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=20,G=252,B=20,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=44,G=58,B=188,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=16.00,Rand=4.00)

    SizeLength=(Base=16.00,Rand=4.00)

    SizeEndScale=(Base=-1.00,Rand=1.00)

    SpinRate=(Base=-8.00,Rand=8.00)

    DripTime=(Base=0.25,Rand=0.00)

    SizeGrowPeriod=0.75

    Damping=0.25

    ParticlesMax=300

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=-16840,Yaw=7776,Roll=0)

    bRotateToDesired=True
}
