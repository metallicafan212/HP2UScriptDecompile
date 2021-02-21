//================================================================================
// SB_FlyingLeaves.
//================================================================================

class SB_FlyingLeaves extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=15.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=25.00,Rand=25.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=8.00)

    SizeLength=(Base=4.00,Rand=8.00)

    SizeEndScale=(Base=0.00,Rand=3.00)

    SpinRate=(Base=-8.00,Rand=8.00)

    Chaos=1.00

    Attraction=(X=-0.05,Y=-0.05,Z=-0.05)

    Damping=1.00

    ParticlesMax=20

    Textures=Texture'HPParticle.hp_fx.General.SPIKYBUSH_leaf'
}
