//================================================================================
// WizCard_Explo.
//================================================================================

class WizCard_Explo extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=130,B=4,A=0),Rand=(R=255,G=255,B=255,A=0))

    SizeEndScale=(Base=3.00,Rand=0.00)

    Damping=3.50

    GravityModifier=0.20

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

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
