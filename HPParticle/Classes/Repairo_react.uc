//================================================================================
// Repairo_react.
//================================================================================

class Repairo_react extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=200.00,Rand=0.00)

    SourceWidth=(Base=40.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    AngularSpreadWidth=(Base=10.00,Rand=0.00)

    AngularSpreadHeight=(Base=10.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=100.00,Rand=20.00)

    Lifetime=(Base=1.75,Rand=0.00)

    ColorEnd=(Base=(R=30,G=30,B=30,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeEndScale=(Base=5.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=0.00,Y=0.00,Z=20.00)

    Damping=1.50

    Gravity=(X=0.00,Y=100.00,Z=-10.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_3'

    LastUpdateLocation=(X=-384.55,Y=201.87,Z=16.44)

    LastEmitLocation=(X=-384.55,Y=201.87,Z=16.44)

    LastUpdateRotation=(Pitch=4960,Yaw=-16336,Roll=0)

    EmissionResidue=0.24

    Age=915.67

    Tag=ParticleFX

    Location=(X=-384.55,Y=201.87,Z=16.44)

    Rotation=(Pitch=4960,Yaw=-16336,Roll=0)

    OldLocation=(X=-346.21,Y=443.26,Z=16.44)
}
