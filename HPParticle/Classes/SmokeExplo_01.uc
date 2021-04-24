//================================================================================
// SmokeExplo_01.
//================================================================================

class SmokeExplo_01 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=800.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    SourceDepth=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=125.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=11,G=9,B=57,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaStart=(Base=0.35,Rand=0.00)

    SizeWidth=(Base=15.00,Rand=0.00)

    SizeLength=(Base=15.00,Rand=0.00)

    SizeEndScale=(Base=10.00,Rand=0.00)

    SpinRate=(Base=-1.00,Rand=1.00)

    Attraction=(X=-0.10,Y=-0.10,Z=-0.10)

    Damping=3.00

    GravityModifier=0.20

    ParticlesMax=80

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke4'

    LastUpdateLocation=(X=224.00,Y=0.00,Z=32.00)

    LastEmitLocation=(X=224.00,Y=0.00,Z=32.00)

    LastUpdateRotation=(Pitch=16336,Yaw=0,Roll=0)

    EmissionResidue=0.21

    Age=3280.40

    ParticlesEmitted=60

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=224.00,Y=0.00,Z=32.00)

    Rotation=(Pitch=16336,Yaw=0,Roll=0)

    OldLocation=(X=224.00,Y=0.00,Z=32.00)

    bSelected=True
}
