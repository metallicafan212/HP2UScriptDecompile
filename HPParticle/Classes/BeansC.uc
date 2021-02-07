//================================================================================
// BeansC.
//================================================================================

class BeansC extends WizardCardFX;

defaultproperties
{
    ParticlesPerSec=(Base=0.50,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=64.00,Rand=20.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SpinRate=(Base=4.00,Rand=4.00)

    GravityModifier=0.25

    ParticlesMax=3

    Textures=Texture'HPParticle.hp_fx.Particles.BeanFX'

    Rotation=(Pitch=16528,Yaw=0,Roll=0)

    Style=STY_Masked
}
