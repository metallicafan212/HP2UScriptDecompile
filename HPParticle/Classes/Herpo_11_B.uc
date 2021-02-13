//================================================================================
// Herpo_11_B.
//================================================================================

class Herpo_11_B extends WizardCardFX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=5.00)

    SourceWidth=(Base=200.00,Rand=10.00)

    SourceHeight=(Base=10.00,Rand=10.00)

    SourceDepth=(Base=5.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=10.00,Rand=2.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=0,G=128,B=0,A=0),Rand=(R=127,G=127,B=127,A=0))

    SizeWidth=(Base=50.00,Rand=20.00)

    SizeLength=(Base=50.00,Rand=20.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    SizeGrowPeriod=0.25

    Damping=5.00

    GravityModifier=0.50

    Textures=Texture'HPParticle.hp_fx.Particles.blob32'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
