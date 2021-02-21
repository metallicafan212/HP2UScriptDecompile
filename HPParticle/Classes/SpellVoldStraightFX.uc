//================================================================================
// SpellVoldStraightFX.
//================================================================================

class SpellVoldStraightFX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=180.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    Speed=(Base=100.00,Rand=0.00)

    ColorStart=(Base=(R=0,G=255,B=0,A=0),Rand=(R=255,G=255,B=255,A=0))

    ColorEnd=(Base=(R=128,G=0,B=0,A=0),Rand=(R=0,G=64,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=20.00)

    SizeLength=(Base=4.00,Rand=20.00)

    SizeEndScale=(Base=0.00,Rand=7.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    Chaos=1.00

    Attraction=(X=-1.00,Y=-1.00,Z=-1.00)

    Damping=1.50

    GravityModifier=-0.10

    Textures=Texture'HPParticle.hp_fx.Spells.Les_VoldSpell'
}
