//================================================================================
// Flip_hit.
//================================================================================

class Flip_hit extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=600.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=250,G=140,B=20,A=0),Rand=(R=133,G=133,B=133,A=0))

    ColorEnd=(Base=(R=200,G=28,B=28,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=30.00,Rand=10.00)

    SizeLength=(Base=30.00,Rand=10.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    bSystemRelative=True

    Damping=7.00

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'
}
