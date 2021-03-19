//================================================================================
// DustCloud02_small.
//================================================================================

class DustCloud02_small extends Dustclouds;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=32.00,Rand=0.00)

    SourceHeight=(Base=32.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=0.00)

    AngularSpreadHeight=(Base=45.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=156,G=139,B=124,A=0),Rand=(R=176,G=138,B=87,A=0))

    ColorEnd=(Base=(R=141,G=121,B=114,A=0),Rand=(R=168,G=139,B=81,A=0))

    SizeWidth=(Base=8.00,Rand=6.00)

    SizeLength=(Base=8.00,Rand=6.00)

    SizeEndScale=(Base=2.00,Rand=1.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=1.00

    Damping=0.50

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
