//================================================================================
// Cauldron_Blue.
//================================================================================

class Cauldron_Blue extends CauldronFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=15.00,Rand=20.00)

    SourceWidth=(Base=50.00,Rand=0.00)

    SourceHeight=(Base=50.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=8.00,Rand=35.00)

    Lifetime=(Base=2.00,Rand=8.00)

    ColorStart=(Base=(R=12,G=0,B=225,A=0),Rand=(R=156,G=111,B=213,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=15.00)

    SizeLength=(Base=12.00,Rand=15.00)

    SizeEndScale=(Base=-1.00,Rand=5.00)

    SpinRate=(Base=0.50,Rand=0.00)

    SizeDelay=1.00

    Chaos=1.00

    ChaosDelay=0.50

    GravityModifier=0.01

    Gravity=(X=-2.00,Y=-2.00,Z=0.00)

    Textures=FireTexture'HPParticle.hp_fx.Particles.spin'

    AmbientSound=Sound'HPSounds.Exec_demo_level_SFX.cauldron_bubbling'

    SoundRadius=18

    SoundVolume=224

    SoundPitch=90
}
