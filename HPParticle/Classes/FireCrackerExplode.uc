//================================================================================
// FireCrackerExplode.
//================================================================================

class FireCrackerExplode extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=4.00,Rand=0.00)

    SourceWidth=(Base=4.00,Rand=0.00)

    SourceHeight=(Base=4.00,Rand=0.00)

    SourceDepth=(Base=4.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=5.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=253,G=45,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=8.00)

    SizeLength=(Base=6.00,Rand=8.00)

    SizeEndScale=(Base=2.00,Rand=4.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    GravityModifier=0.00

    ParticlesMax=20

    Textures=Texture'HPParticle.hp_fx.Particles.Key1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
