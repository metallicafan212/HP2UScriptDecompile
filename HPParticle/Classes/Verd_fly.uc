//================================================================================
// Verd_fly.
//================================================================================

class Verd_fly extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    AngularSpreadWidth=(Base=10.00,Rand=0.00)

    AngularSpreadHeight=(Base=10.00,Rand=0.00)

    Speed=(Base=20.00,Rand=30.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=54,G=44,B=245,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=20.00,Rand=20.00)

    SizeLength=(Base=20.00,Rand=20.00)

    SizeEndScale=(Base=-0.50,Rand=0.00)

    SpinRate=(Base=2.00,Rand=0.00)

    bVelocityRelative=True

    Chaos=3.00

    GravityModifier=-0.01

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_8'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
