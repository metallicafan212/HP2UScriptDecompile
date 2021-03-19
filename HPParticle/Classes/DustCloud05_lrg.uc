//================================================================================
// DustCloud05_lrg.
//================================================================================

class DustCloud05_lrg extends Dustclouds;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=128.00,Rand=0.00)

    SourceHeight=(Base=128.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=0.00)

    AngularSpreadHeight=(Base=45.00,Rand=0.00)

    Speed=(Base=120.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=3.00)

    ColorStart=(Base=(R=139,G=118,B=99,A=0),Rand=(R=139,G=134,B=90,A=0))

    ColorEnd=(Base=(R=141,G=121,B=114,A=0),Rand=(R=154,G=123,B=92,A=0))

    SizeWidth=(Base=64.00,Rand=24.00)

    SizeLength=(Base=64.00,Rand=24.00)

    SizeEndScale=(Base=2.00,Rand=1.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    Chaos=1.00

    Damping=1.25

    ParticlesMax=25

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
