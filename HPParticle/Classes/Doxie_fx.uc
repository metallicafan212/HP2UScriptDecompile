//================================================================================
// Doxie_fx.
//================================================================================

class Doxie_fx extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    SourceDepth=(Base=20.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=10.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=89,G=131,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=72,G=63,B=194,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=2.00)

    SizeLength=(Base=6.00,Rand=2.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Chaos=5.00

    ChaosDelay=0.50

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_5'

    Rotation=(Pitch=-16352,Yaw=0,Roll=0)

    DesiredRotation=(Pitch=-16352,Yaw=0,Roll=0)
}
