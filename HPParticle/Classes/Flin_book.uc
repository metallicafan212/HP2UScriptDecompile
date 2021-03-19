//================================================================================
// Flin_book.
//================================================================================

class Flin_book extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=10.00,Rand=15.00)

    SourceWidth=(Base=20.00,Rand=10.00)

    SourceHeight=(Base=20.00,Rand=10.00)

    SourceDepth=(Base=20.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=3.00)

    ColorStart=(Base=(R=254,G=134,B=69,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=243,G=37,B=227,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaStart=(Base=0.00,Rand=1.00)

    SizeWidth=(Base=5.00,Rand=30.00)

    SizeLength=(Base=5.00,Rand=30.00)

    SizeEndScale=(Base=-1.00,Rand=3.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Chaos=5.00

    ChaosDelay=0.50

    Damping=1.00

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
