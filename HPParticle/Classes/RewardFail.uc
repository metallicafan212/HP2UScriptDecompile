//================================================================================
// RewardFail.
//================================================================================

class RewardFail extends Reward01;

defaultproperties
{
    ParticlesPerSec=(Base=100.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=100.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=134,G=134,B=134,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=20.00)

    SizeLength=(Base=1.00,Rand=20.00)

    Chaos=1.00

    Attraction=(X=-5.00,Y=-5.00,Z=-5.00)

    Damping=6.00

    GravityModifier=0.30

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_5_BW'

}
