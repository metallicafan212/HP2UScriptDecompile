//================================================================================
// Skurge_react.
//================================================================================

class Skurge_react extends AllSpellCast_FX;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  SetRotation(DesiredRotation);
}

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=64.00,Rand=25.00)

    SourceHeight=(Base=64.00,Rand=25.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=40.00)

    Lifetime=(Base=2.00,Rand=3.00)

    ColorStart=(Base=(R=94,G=225,B=97,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=28,G=49,B=19,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=15.00)

    SizeLength=(Base=15.00,Rand=15.00)

    SizeEndScale=(Base=-4.00,Rand=8.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=2.00

    Damping=0.50

    GravityModifier=0.05

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=16352,Yaw=0,Roll=0)

    bFixedRotationDir=True

    bRotateToDesired=True
}
