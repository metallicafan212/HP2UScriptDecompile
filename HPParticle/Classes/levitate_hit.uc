//================================================================================
// levitate_hit.
//================================================================================

class levitate_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=0.00)

    Speed=(Base=20.00,Rand=30.00)

    Lifetime=(Base=0.50,Rand=0.00)

    ColorStart=(Base=(R=149,G=166,B=244,A=0),Rand=(R=28,G=19,B=196,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=120.00,Rand=50.00)

    SizeLength=(Base=120.00,Rand=50.00)

    SpinRate=(Base=2.00,Rand=0.00)

    SizeDelay=2.00

    Chaos=3.00

    ChaosDelay=0.50

    ParticlesAlive=5

    ParticlesMax=5

    Textures=FireTexture'HPParticle.hp_fx.Particles.spin'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
