//================================================================================
// PixieGroundDust.
//================================================================================

class PixieGroundDust extends PixieParticles;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceWidth=(Base=15.00,Rand=0.00)

    SourceHeight=(Base=15.00,Rand=0.00)

    AngularSpreadWidth=(Base=60.00,Rand=20.00)

    AngularSpreadHeight=(Base=60.00,Rand=20.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=10.00)

    Lifetime=(Base=6.50,Rand=1.50)

    ColorStart=(Base=(R=253,G=152,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=202,B=40,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    DripTime=(Base=0.50,Rand=0.25)

    Attraction=(X=4.00,Y=4.00,Z=0.00)

    Damping=0.50

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)
}
