//================================================================================
// Incend_hit.
//================================================================================

class Incend_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=500.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=41,G=4,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=5.00)

    SizeLength=(Base=15.00,Rand=5.00)

    SizeEndScale=(Base=0.00,Rand=4.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    Chaos=1.00

    Attraction=(X=-5.00,Y=-5.00,Z=0.00)

    Damping=10.00

    GravityModifier=-0.50

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Spells.Les_BlueSmoke'

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
