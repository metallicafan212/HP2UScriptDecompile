//================================================================================
// Petri_wand.
//================================================================================

class Petri_wand extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=0.00)

    Lifetime=(Base=5.00,Rand=2.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=30,G=30,B=30,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=1.00)

    SizeLength=(Base=8.00,Rand=2.00)

    SizeEndScale=(Base=3.00,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=35.00,Y=35.00,Z=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_5'

    LastUpdateLocation=(X=-388.53,Y=-383.68,Z=60.94)

    LastEmitLocation=(X=-388.53,Y=-383.68,Z=60.94)

    LastUpdateRotation=(Pitch=16528,Yaw=-16336,Roll=0)

    EmissionResidue=0.15

    Age=20429.72

    bDynamicLight=True

    Tag=ParticleFX

    Location=(X=-388.53,Y=-383.68,Z=60.94)

    Rotation=(Pitch=16528,Yaw=-16336,Roll=0)

    OldLocation=(X=-32.00,Y=64.00,Z=96.00)
}
