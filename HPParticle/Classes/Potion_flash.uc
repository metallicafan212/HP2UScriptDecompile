//================================================================================
// Potion_flash.
//================================================================================

class Potion_flash extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=300.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=2.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=9,B=15,A=0),Rand=(R=255,G=255,B=255,A=0))

    SizeWidth=(Base=8.00,Rand=4.00)

    SizeLength=(Base=8.00,Rand=4.00)

    SizeEndScale=(Base=4.00,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    Attraction=(X=1.50,Y=1.50,Z=1.50)

    Damping=11.00

    GravityModifier=-0.10

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_5_BW'

    LastUpdateLocation=(X=0.00,Y=0.00,Z=-50.73)

    LastEmitLocation=(X=0.00,Y=0.00,Z=-50.73)

    LastUpdateRotation=(Pitch=16480,Yaw=0,Roll=0)

    Age=1260.92

    ParticlesEmitted=80

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=0.00,Y=0.00,Z=-50.73)

    Rotation=(Pitch=16480,Yaw=0,Roll=0)

    OldLocation=(X=0.00,Y=0.00,Z=32.00)

    bSelected=True
}
