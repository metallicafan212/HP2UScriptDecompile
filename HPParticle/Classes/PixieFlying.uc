//================================================================================
// PixieFlying.
//================================================================================

class PixieFlying extends PixieParticles;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=5.00,Rand=0.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=0.75,Rand=0.50)

    ColorStart=(Base=(R=0,G=128,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=128,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=2.00)

    SizeLength=(Base=6.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    GravityModifier=0.05

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)
}
