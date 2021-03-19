//================================================================================
// FluffyZ.
//================================================================================

class FluffyZ extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1.00,Rand=0.00)

    SourceWidth=(Base=10.00,Rand=10.00)

    SourceHeight=(Base=30.00,Rand=30.00)

    SourceDepth=(Base=10.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=2.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=6.00)

    SizeLength=(Base=6.00,Rand=6.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    Chaos=1.00

    GravityModifier=-0.05

    Textures=Texture'HPParticle.hp_fx.Particles.Z'

    LastUpdateLocation=(X=5.12,Y=4.56,Z=36.10)

    LastEmitLocation=(X=5.12,Y=4.56,Z=36.10)

    EmissionResidue=0.94

    Age=20.12

    ParticlesEmitted=2012

    bDynamicLight=True

    Tag=Wing_fly

    Location=(X=5.12,Y=4.56,Z=36.10)

    Rotation=(Pitch=0,Yaw=0,Roll=0)

    OldLocation=(X=5.12,Y=-1.44,Z=36.10)

    bSelected=True
}
