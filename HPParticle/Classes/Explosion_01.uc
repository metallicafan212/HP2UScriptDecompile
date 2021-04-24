//================================================================================
// Explosion_01.
//================================================================================

class Explosion_01 extends ParticleFX;

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

    Speed=(Base=200.00,Rand=100.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=255,G=255,B=255,A=0))

    SizeWidth=(Base=1.00,Rand=6.00)

    SizeLength=(Base=1.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=10.00)

    Chaos=1.00

    Attraction=(X=-0.01,Y=-0.01,Z=-0.01)

    Damping=18.00

    GravityModifier=-0.05

    ParticlesMax=80

    Textures(0)=Texture'HPParticle.hp_fx.Spells.Les_fire_01'

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
