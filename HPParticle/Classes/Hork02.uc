//================================================================================
// Hork02.
//================================================================================

class Hork02 extends HorklumpsFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=10.00,Rand=4.00)

    SourceHeight=(Base=10.00,Rand=4.00)

    SourceDepth=(Base=10.00,Rand=4.00)

    AngularSpreadWidth=(Base=75.00,Rand=30.00)

    AngularSpreadHeight=(Base=75.00,Rand=30.00)

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=2.00,Rand=4.00)

    ColorStart=(Base=(R=176,G=89,B=240,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=97,G=52,B=103,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=4.00)

    SizeLength=(Base=6.00,Rand=4.00)

    SizeEndScale=(Base=0.01,Rand=10.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Chaos=2.00

    ChaosDelay=1.00

    Damping=2.00

    GravityModifier=-0.05

    ParticlesMax=80

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
