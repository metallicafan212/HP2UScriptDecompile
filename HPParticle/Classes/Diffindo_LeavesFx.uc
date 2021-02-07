//================================================================================
// Diffindo_LeavesFx.
//================================================================================

class Diffindo_LeavesFx extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=128.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    SourceDepth=(Base=128.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Lifetime=(Base=4.00,Rand=2.00)

    ColorStart=(Base=(R=216,G=255,B=168,A=0),Rand=(R=19,G=249,B=0,A=0))

    ColorEnd=(Base=(R=209,G=253,B=2,A=0),Rand=(R=196,G=255,B=15,A=0))

    AlphaEnd=(Base=1.00,Rand=0.00)

    SizeWidth=(Base=12.00,Rand=6.00)

    SizeLength=(Base=12.00,Rand=6.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=3.00

    Damping=1.00

    GravityModifier=0.01

    ParticlesMax=32

    Textures=Texture'HPParticle.hp_fx.Particles.leaf'

    Rotation=(Pitch=49472,Yaw=0,Roll=0)

    Style=STY_Masked
}
