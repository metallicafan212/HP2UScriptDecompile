//================================================================================
// firecracker.
//================================================================================

class firecracker extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Speed=(Base=300.00,Rand=100.00)

    Lifetime=(Base=1.25,Rand=0.50)

    ColorStart=(Base=(R=29,G=17,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=128,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=10.00)

    SizeLength=(Base=3.00,Rand=10.00)

    SizeEndScale=(Base=-1.00,Rand=2.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    AlphaDelay=1.00

    ColorDelay=0.40

    Chaos=10.00

    Damping=6.00

    GravityModifier=0.00

    Gravity=(X=0.00,Y=0.00,Z=-60.00)

    ParticlesMax=25

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_BW'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
