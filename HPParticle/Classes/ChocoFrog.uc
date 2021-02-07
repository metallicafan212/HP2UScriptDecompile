//================================================================================
// ChocoFrog.
//================================================================================

class ChocoFrog extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=10.00,Rand=15.00)

    SourceWidth=(Base=20.00,Rand=10.00)

    SourceHeight=(Base=20.00,Rand=10.00)

    SourceDepth=(Base=10.00,Rand=20.00)

    AngularSpreadWidth=(Base=10.00,Rand=20.00)

    AngularSpreadHeight=(Base=10.00,Rand=20.00)

    Speed=(Base=5.00,Rand=20.00)

    Lifetime=(Base=7.00,Rand=0.00)

    ColorStart=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=172,G=130,B=0,A=0),Rand=(R=253,G=88,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=10.00)

    SizeLength=(Base=1.00,Rand=10.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=0.20,Rand=2.00)

    SizeDelay=2.00

    Chaos=1.00

    ChaosDelay=0.50

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_1'

    Rotation=(Pitch=-16352,Yaw=0,Roll=0)

    DesiredRotation=(Pitch=-16352,Yaw=0,Roll=0)
}
