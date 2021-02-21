//================================================================================
// SkurgeSpell_hit.
//================================================================================

class SkurgeSpell_hit extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=0.00)

    Lifetime=(Base=1.20,Rand=0.00)

    ColorStart=(Base=(R=34,G=67,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=113,G=6,B=164,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=20.00,Rand=10.00)

    SizeLength=(Base=20.00,Rand=10.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-2.00,Rand=3.00)

    bSystemRelative=True

    Damping=7.00

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'
}
