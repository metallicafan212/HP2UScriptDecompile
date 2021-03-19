//================================================================================
// SnailTrailFX.
//================================================================================

class SnailTrailFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=40.00,Rand=0.00)

    SourceWidth=(Base=15.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    AngularSpreadWidth=(Base=30.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=3.00,Rand=0.00)

    ColorStart=(Base=(R=255,G=100,B=6,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=0.00)

    SizeLength=(Base=6.00,Rand=0.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=0.50,Rand=10.00)

    AlphaDelay=6.00

    GravityModifier=0.00

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    CollisionRadius=400.00

    bRotateToDesired=True
}
