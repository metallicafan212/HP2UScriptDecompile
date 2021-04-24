//================================================================================
// Diffindo_WebFx.
//================================================================================

class Diffindo_WebFx extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=17.00,Rand=4.00)

    SourceWidth=(Base=40.00,Rand=0.00)

    SourceHeight=(Base=40.00,Rand=0.00)

    SourceDepth=(Base=200.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=-15.00,Rand=15.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=255,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=0,B=128,A=0),Rand=(R=255,G=145,B=53,A=0))

    SizeWidth=(Base=25.00,Rand=5.00)

    SizeLength=(Base=25.00,Rand=5.00)

    SizeEndScale=(Base=0.00,Rand=1.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    DripTime=(Base=0.50,Rand=0.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
