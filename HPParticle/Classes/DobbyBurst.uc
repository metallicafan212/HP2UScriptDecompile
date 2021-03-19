//================================================================================
// DobbyBurst.
//================================================================================

class DobbyBurst extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=32.00,Rand=5.00)

    SourceHeight=(Base=32.00,Rand=5.00)

    SourceDepth=(Base=40.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=-2.00,Rand=4.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=226,B=111,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=241,G=164,B=3,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=2.00)

    SizeLength=(Base=3.00,Rand=2.00)

    SizeEndScale=(Base=4.00,Rand=6.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=2.00

    Attraction=(X=40.00,Y=40.00,Z=0.00)

    Damping=0.50

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=16280,Yaw=0,Roll=0)
}
