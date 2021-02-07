//================================================================================
// Aloh_Fly.
//================================================================================

class Aloh_Fly extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=10.00)

    SourceWidth=(Base=5.00,Rand=2.00)

    SourceHeight=(Base=5.00,Rand=2.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=0.00)

    ColorStart=(Base=(R=253,G=152,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=202,B=40,A=0),Rand=(R=0,G=0,B=0,A=0))

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=5.00

    ChaosDelay=0.25

    Textures=Texture'HPParticle.hp_fx.Particles.Key3'

    Physics=PHYS_Rotating

    bFixedRotationDir=True

    RotationRate=(Pitch=0,Yaw=500000,Roll=0)
}
