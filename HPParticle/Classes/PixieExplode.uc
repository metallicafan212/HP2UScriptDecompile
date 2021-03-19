//================================================================================
// PixieExplode.
//================================================================================

class PixieExplode extends PixieParticles;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=3000.00,Rand=0.00)

    SourceWidth=(Base=5.00,Rand=0.00)

    SourceHeight=(Base=15.00,Rand=0.00)

    SourceDepth=(Base=5.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=500.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=0,G=128,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=128,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=20.00,Rand=15.00)

    SizeLength=(Base=20.00,Rand=15.00)

    SpinRate=(Base=-5.00,Rand=5.00)

    DripTime=(Base=0.10,Rand=0.10)

    Elasticity=0.50

    Damping=4.00

    GravityModifier=0.75

    ParticlesMax=200

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Location=(X=0.00,Y=0.00,Z=100.00)

    Rotation=(Pitch=16408,Yaw=0,Roll=0)
}
