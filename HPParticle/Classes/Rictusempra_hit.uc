//================================================================================
// Rictusempra_hit.
//================================================================================

class Rictusempra_hit extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=50000.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=500.00,Rand=0.00)

    ColorStart=(Base=(R=198,G=55,B=66,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=247,G=86,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=32.00,Rand=0.00)

    SizeLength=(Base=32.00,Rand=0.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=1.00,Rand=2.00)

    bSystemRelative=True

    SizeDelay=0.25

    Damping=8.00

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Physics=PHYS_Rotating

    bFixedRotationDir=True

    RotationRate=(Pitch=-40000,Yaw=0,Roll=0)
}
