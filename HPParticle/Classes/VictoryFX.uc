//================================================================================
// VictoryFX.
//================================================================================

class VictoryFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=20.00,Rand=0.00)

    SourceHeight=(Base=20.00,Rand=0.00)

    SourceDepth=(Base=20.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=20.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=254,G=176,B=16,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=254,G=87,B=7,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeEndScale=(Base=-1.00,Rand=2.00)

    SpinRate=(Base=-4.00,Rand=4.00)

    Chaos=10.00

    Damping=8.00

    ParticlesMax=400

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_BW'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
