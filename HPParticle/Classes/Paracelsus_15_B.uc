//================================================================================
// Paracelsus_15_B.
//================================================================================

class Paracelsus_15_B extends WizardCardFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=10.00)

    SourceWidth=(Base=40.00,Rand=10.00)

    SourceHeight=(Base=10.00,Rand=10.00)

    SourceDepth=(Base=5.00,Rand=10.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=2.50,Rand=1.50)

    ColorStart=(Base=(R=255,G=0,B=0,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=255,G=255,B=0,A=0),Rand=(R=127,G=127,B=127,A=0))

    SizeWidth=(Base=10.00,Rand=5.00)

    SizeLength=(Base=10.00,Rand=5.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    AlphaDelay=0.50

    SizeDelay=1.50

    AlphaGrowPeriod=0.50

    Chaos=2.00

    Damping=5.00

    GravityModifier=-0.20

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke5'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
