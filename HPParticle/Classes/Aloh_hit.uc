//================================================================================
// Aloh_hit.
//================================================================================

class Aloh_hit extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=64.00,Rand=0.00)

    SourceDepth=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=3.00)

    ColorStart=(Base=(R=253,G=152,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=202,B=40,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=8.00,Rand=12.00)

    SizeLength=(Base=8.00,Rand=12.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    ParticlesMax=60

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Physics=PHYS_Rotating

    bFixedRotationDir=True

    RotationRate=(Pitch=50000,Yaw=0,Roll=0)
}
