//================================================================================
// Repairo_wand.
//================================================================================

class Repairo_wand extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=200.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    AngularSpreadWidth=(Base=10.00,Rand=2.00)

    AngularSpreadHeight=(Base=10.00,Rand=2.00)

    bSteadyState=True

    ColorEnd=(Base=(R=30,G=30,B=30,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=0.00)

    SizeLength=(Base=3.00,Rand=0.00)

    SizeEndScale=(Base=5.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=-50.00,Y=0.00,Z=-50.00)

    Damping=1.50

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_3'

    LastUpdateLocation=(X=-387.00,Y=-383.68,Z=68.57)

    LastEmitLocation=(X=-387.00,Y=-383.68,Z=68.57)

    LastUpdateRotation=(Pitch=0,Yaw=-16336,Roll=0)

    EmissionResidue=0.18

    Age=14217.86

    Tag=ParticleFX

    Location=(X=-387.00,Y=-383.68,Z=68.57)

    Rotation=(Pitch=0,Yaw=-16336,Roll=0)

    OldLocation=(X=-32.00,Y=64.00,Z=96.00)
}
