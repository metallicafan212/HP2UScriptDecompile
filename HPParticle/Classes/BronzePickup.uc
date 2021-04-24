//================================================================================
// BronzePickup.
//================================================================================

class BronzePickup extends WizardPickups;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=45.00)

    AngularSpreadHeight=(Base=45.00,Rand=45.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=50.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=128,G=64,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=64,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=2.00)

    SizeLength=(Base=3.00,Rand=2.00)

    SizeEndScale=(Base=4.00,Rand=0.00)

    SpinRate=(Base=-8.00,Rand=8.00)

    Chaos=20.00

    ChaosDelay=0.25

    Attraction=(X=0.25,Y=0.25,Z=0.00)

    Damping=3.00

    GravityModifier=0.20

    ParticlesMax=150

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Reward_Bronze'

    Age=643.23

    ParticlesEmitted=50

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=0.00,Y=0.00,Z=32.00)

    OldLocation=(X=0.00,Y=0.00,Z=32.00)

    CollisionRadius=75.00

    CollisionHeight=35.00
}
