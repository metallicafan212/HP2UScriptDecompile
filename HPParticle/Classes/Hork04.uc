//================================================================================
// Hork04.
//================================================================================

class Hork04 extends HorklumpsFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=10.00,Rand=4.00)

    SourceHeight=(Base=10.00,Rand=4.00)

    SourceDepth=(Base=10.00,Rand=4.00)

    AngularSpreadWidth=(Base=20.00,Rand=40.00)

    AngularSpreadHeight=(Base=20.00,Rand=40.00)

    Speed=(Base=100.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=255,G=255,B=255,A=0))

    ColorEnd=(Base=(R=255,G=255,B=255,A=0),Rand=(R=255,G=255,B=255,A=0))

    SizeWidth=(Base=2.00,Rand=10.00)

    SizeLength=(Base=2.00,Rand=10.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-4.00,Rand=4.00)

    SizeDelay=0.60

    Chaos=3.00

    Elasticity=0.10

    Damping=1.00

    GravityModifier=0.50

    ParticlesMax=20

    Textures(0)=Texture'HPParticle.hp_fx.Particles.HorkaChunk'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)

    Style=STY_Masked

    AmbientGlow=255
}
