//================================================================================
// Levitate_hold.
//================================================================================

class Levitate_hold extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=100.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=25.00,Rand=0.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    SizeEndScale=(Base=4.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Chaos=1.00

    Damping=3.00

    GravityModifier=-0.06

    ParticlesAlive=80

    Textures=Texture'HPParticle.hp_fx.Particles.Feather'

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
