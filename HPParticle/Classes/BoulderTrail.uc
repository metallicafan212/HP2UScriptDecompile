//================================================================================
// BoulderTrail.
//================================================================================

class BoulderTrail extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=20.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    SourceDepth=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=1.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=8.00)

    SizeLength=(Base=6.00,Rand=8.00)

    SizeEndScale=(Base=3.00,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    Chaos=1.00

    Distribution=DIST_OwnerMesh

    GravityModifier=0.03

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke5'
}
