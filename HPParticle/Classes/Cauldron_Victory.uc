//================================================================================
// Cauldron_Victory.
//================================================================================

class Cauldron_Victory extends CauldronFX;

defaultproperties
{
    ParticlesPerSec=(Base=15.00,Rand=20.00)

    SourceWidth=(Base=50.00,Rand=0.00)

    SourceHeight=(Base=50.00,Rand=0.00)

    Speed=(Base=8.00,Rand=35.00)

    Lifetime=(Base=2.00,Rand=8.00)

    ColorStart=(Base=(R=230,G=239,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=5.00,Rand=20.00)

    SizeLength=(Base=5.00,Rand=20.00)

    SizeEndScale=(Base=-5.00,Rand=15.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Attraction=(X=5.00,Y=5.00,Z=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke2'
}
