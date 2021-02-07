//================================================================================
// Cauldron_Neutral.
//================================================================================

class Cauldron_Neutral extends CauldronFX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=10.00)

    SourceWidth=(Base=30.00,Rand=0.00)

    SourceHeight=(Base=30.00,Rand=0.00)

    AngularSpreadWidth=(Base=20.00,Rand=15.00)

    AngularSpreadHeight=(Base=20.00,Rand=15.00)

    bSteadyState=True

    Speed=(Base=2.00,Rand=20.00)

    Lifetime=(Base=4.00,Rand=2.00)

    ColorStart=(Base=(R=166,G=162,B=247,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=40,G=47,B=159,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=5.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=8.00

    ChaosDelay=2.00

    Damping=0.25

    GravityModifier=0.01

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke3'

    AmbientSound=Sound'HPSounds.Exec_demo_level_SFX.cauldron_bubbling'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)

    SoundRadius=16

    SoundVolume=224

    SoundPitch=90
}
