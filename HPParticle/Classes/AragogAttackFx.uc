//================================================================================
// AragogAttackFx.
//================================================================================

class AragogAttackFx extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=5.00)

    SourceWidth=(Base=15.00,Rand=5.00)

    SourceHeight=(Base=15.00,Rand=5.00)

    SourceDepth=(Base=15.00,Rand=5.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=5.00)

    Lifetime=(Base=0.50,Rand=0.10)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=128,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=10.00)

    SizeLength=(Base=15.00,Rand=10.00)

    SizeEndScale=(Base=3.00,Rand=0.00)

    SpinRate=(Base=-4.00,Rand=4.00)

    bSystemRelative=True

    Attraction=(X=20.00,Y=20.00,Z=20.00)

    Textures=Texture'HPParticle.particle_fx.noisy5_pfx'

    Rotation=(Pitch=16384,Yaw=0,Roll=0)
}
