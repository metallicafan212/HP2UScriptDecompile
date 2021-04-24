//================================================================================
// Hork01.
//================================================================================

class Hork01 extends HorklumpsFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=10.00,Rand=4.00)

    SourceHeight=(Base=10.00,Rand=4.00)

    SourceDepth=(Base=10.00,Rand=4.00)

    AngularSpreadWidth=(Base=75.00,Rand=30.00)

    AngularSpreadHeight=(Base=75.00,Rand=30.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=1.50,Rand=3.00)

    ColorStart=(Base=(R=192,G=60,B=200,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=97,G=52,B=103,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=4.00)

    SizeLength=(Base=6.00,Rand=4.00)

    SizeEndScale=(Base=0.01,Rand=10.00)

    SpinRate=(Base=-1.50,Rand=3.00)

    Chaos=2.00

    ChaosDelay=1.00

    Damping=2.00

    GravityModifier=-0.05

    ParticlesMax=25

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
