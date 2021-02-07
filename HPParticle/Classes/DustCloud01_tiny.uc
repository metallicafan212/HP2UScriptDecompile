//================================================================================
// DustCloud01_tiny.
//================================================================================

class DustCloud01_tiny extends Dustclouds;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=16.00,Rand=0.00)

    SourceHeight=(Base=16.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=0.00)

    AngularSpreadHeight=(Base=45.00,Rand=0.00)

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=142,G=112,B=87,A=0),Rand=(R=176,G=138,B=87,A=0))

    ColorEnd=(Base=(R=141,G=121,B=114,A=0),Rand=(R=168,G=139,B=81,A=0))

    SizeWidth=(Base=8.00,Rand=6.00)

    SizeLength=(Base=8.00,Rand=6.00)

    SizeEndScale=(Base=2.00,Rand=1.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=1.00

    Damping=0.50

    ParticlesMax=20

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
