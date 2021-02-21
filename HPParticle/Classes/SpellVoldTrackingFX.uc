//================================================================================
// SpellVoldTrackingFX.
//================================================================================

class SpellVoldTrackingFX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=120.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=20.00)

    ColorStart=(Base=(R=255,G=0,B=255,A=0),Rand=(R=255,G=0,B=255,A=0))

    ColorEnd=(Base=(R=255,G=0,B=0,A=0),Rand=(R=0,G=0,B=255,A=0))

    SizeWidth=(Base=1.00,Rand=10.00)

    SizeLength=(Base=1.00,Rand=10.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    Chaos=1.00

    Attraction=(X=10.00,Y=10.00,Z=10.00)

    Damping=1.00

    GravityModifier=-0.10

    Textures=Texture'HPParticle.hp_fx.Spells.Les_VoldSpell'

    LastUpdateLocation=(X=-383.86,Y=-178.58,Z=65.73)

    LastEmitLocation=(X=-383.86,Y=-178.58,Z=65.73)

    LastUpdateRotation=(Pitch=16144,Yaw=-16336,Roll=0)

    EmissionResidue=0.81

    Age=13676.87

    Tag=ParticleFX

    Location=(X=-383.86,Y=-178.58,Z=65.73)

    Rotation=(Pitch=16144,Yaw=-16336,Roll=0)

    OldLocation=(X=1.13,Y=115.53,Z=68.57)
}
