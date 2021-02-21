//================================================================================
// PixieHit.
//================================================================================

class PixieHit extends PixieParticles;

defaultproperties
{
    ParticlesPerSec=(Base=750.00,Rand=0.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=300.00,Rand=0.00)

    Lifetime=(Base=0.70,Rand=0.00)

    ColorStart=(Base=(R=202,G=203,B=247,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=128,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=0.20,Rand=0.00)

    SizeWidth=(Base=10.00,Rand=5.00)

    SizeLength=(Base=10.00,Rand=5.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Attraction=(X=17.00,Y=17.00,Z=17.00)

    ParticlesMax=200

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)

    CollisionRadius=25.00

    CollisionHeight=25.00
}
