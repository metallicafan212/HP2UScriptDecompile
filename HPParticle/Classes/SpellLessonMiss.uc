//================================================================================
// SpellLessonMiss.
//================================================================================

class SpellLessonMiss extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=300.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    Speed=(Base=200.00,Rand=100.00)

    Lifetime=(Base=0.50,Rand=0.10)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=4.00)

    SizeLength=(Base=12.00,Rand=4.00)

    SizeEndScale=(Base=1.00,Rand=1.00)

    SpinRate=(Base=-2.00,Rand=2.00)

    AlphaDelay=1.00

    Chaos=10.00

    Damping=25.00

    GravityModifier=0.30

    ParticlesMax=25

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    CollisionRadius=10.00

    CollisionHeight=10.00

    bRotateToDesired=True
}
