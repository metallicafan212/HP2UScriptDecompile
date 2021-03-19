//================================================================================
// BronzeStamina.
//================================================================================

class BronzeStamina extends WizardPickups;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=35.00,Rand=10.00)

    AngularSpreadHeight=(Base=35.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=250.00,Rand=100.00)

    Lifetime=(Base=4.00,Rand=2.00)

    ColorStart=(Base=(R=192,G=192,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=192,G=192,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=5.00,Rand=3.00)

    SizeLength=(Base=5.00,Rand=3.00)

    SizeEndScale=(Base=4.00,Rand=0.00)

    Attraction=(X=-0.30,Y=-0.30,Z=-0.50)

    Damping=3.00

    GravityModifier=0.20

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Particles.healthmeter'

    Age=643.23

    ParticlesEmitted=50

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=0.00,Y=0.00,Z=32.00)

    OldLocation=(X=0.00,Y=0.00,Z=32.00)

    CollisionRadius=75.00

    CollisionHeight=35.00
}
