//================================================================================
// GlassJarBreak.
//================================================================================

class GlassJarBreak extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=300.00,Rand=0.00)

    SourceWidth=(Base=15.00,Rand=0.00)

    SourceHeight=(Base=15.00,Rand=0.00)

    SourceDepth=(Base=30.00,Rand=0.00)

    AngularSpreadWidth=(Base=65.00,Rand=0.00)

    AngularSpreadHeight=(Base=65.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=60.00,Rand=10.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=192,G=192,B=192,A=0),Rand=(R=255,G=255,B=255,A=0))

    AlphaStart=(Base=0.50,Rand=0.00)

    AlphaEnd=(Base=0.50,Rand=0.00)

    SizeWidth=(Base=1.00,Rand=1.00)

    SizeLength=(Base=1.00,Rand=1.00)

    SizeEndScale=(Base=0.00,Rand=10.00)

    SpinRate=(Base=20.00,Rand=-5.00)

    Attraction=(X=-0.01,Y=-0.01,Z=-0.01)

    GravityModifier=0.10

    Gravity=(X=0.00,Y=0.00,Z=-50.00)

    ParticlesMax=20

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Glass'

    LastUpdateLocation=(X=0.00,Y=0.00,Z=32.00)

    LastEmitLocation=(X=0.00,Y=0.00,Z=32.00)

    LastUpdateRotation=(Pitch=16400,Yaw=0,Roll=0)

    Age=643.23

    ParticlesEmitted=50

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=0.00,Y=0.00,Z=32.00)

    Rotation=(Pitch=16400,Yaw=0,Roll=0)

    OldLocation=(X=0.00,Y=0.00,Z=32.00)
}
