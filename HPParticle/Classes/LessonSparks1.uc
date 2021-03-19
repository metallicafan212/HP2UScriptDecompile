//================================================================================
// LessonSparks1.
//================================================================================

class LessonSparks1 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=10.00)

    SourceWidth=(Base=5.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=30.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.50)

    ColorStart=(Base=(R=252,G=242,B=65,A=0),Rand=(R=255,G=191,B=0,A=0))

    ColorEnd=(Base=(R=203,G=39,B=55,A=0),Rand=(R=255,G=77,B=77,A=0))

    SizeWidth=(Base=8.00,Rand=6.00)

    SizeLength=(Base=8.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Damping=1.00

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
