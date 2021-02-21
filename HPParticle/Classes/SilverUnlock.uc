//================================================================================
// SilverUnlock.
//================================================================================

class SilverUnlock extends WizardPickups;

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=10.00)

    AngularSpreadHeight=(Base=45.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=100.00)

    Lifetime=(Base=3.00,Rand=2.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=2.00)

    SizeLength=(Base=3.00,Rand=2.00)

    SizeEndScale=(Base=4.00,Rand=0.00)

    SpinRate=(Base=-2.00,Rand=2.00)

    Chaos=10.00

    Attraction=(X=0.25,Y=0.25,Z=0.00)

    Damping=2.00

    GravityModifier=0.05

    ParticlesMax=150

    Textures=Texture'HPParticle.hp_fx.Particles.Key3'

    Age=643.23

    ParticlesEmitted=50

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=0.00,Y=0.00,Z=32.00)

    OldLocation=(X=0.00,Y=0.00,Z=32.00)

    CollisionRadius=75.00

    CollisionHeight=35.00

    RotationRate=(Pitch=16464,Yaw=0,Roll=0)
}
