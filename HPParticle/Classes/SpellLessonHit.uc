//================================================================================
// SpellLessonHit.
//================================================================================

class SpellLessonHit extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Speed=(Base=300.00,Rand=100.00)

    Lifetime=(Base=0.60,Rand=0.10)

    ColorStart=(Base=(R=0,G=128,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=10.00,Rand=4.00)

    SizeLength=(Base=10.00,Rand=4.00)

    SizeEndScale=(Base=-1.00,Rand=2.00)

    SpinRate=(Base=-12.00,Rand=12.00)

    AlphaDelay=1.00

    ColorDelay=0.40

    Chaos=10.00

    Damping=30.00

    GravityModifier=0.30

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
