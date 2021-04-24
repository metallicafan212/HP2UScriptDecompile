//================================================================================
// SleepFX.
//================================================================================

class SleepFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=0.30,Rand=0.10)

    SourceWidth=(Base=4.00,Rand=0.00)

    SourceHeight=(Base=4.00,Rand=0.00)

    AngularSpreadWidth=(Base=30.00,Rand=0.00)

    AngularSpreadHeight=(Base=30.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=0.00)

    Lifetime=(Base=3.50,Rand=1.50)

    ColorStart=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=0.00)

    SizeLength=(Base=2.00,Rand=0.00)

    SizeEndScale=(Base=8.00,Rand=0.00)

    AlphaDelay=1.25

    ColorDelay=0.70

    Chaos=6.00

    ChaosDelay=1.00

    Damping=2.00

    Gravity=(X=0.00,Y=0.00,Z=35.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Z'

    Tag=SleepFX
}
