//================================================================================
// Albus_101_B.
//================================================================================

class Albus_101_B extends WizardCardFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=10.00,Rand=2.00)

    SourceWidth=(Base=200.00,Rand=10.00)

    SourceHeight=(Base=5.00,Rand=5.00)

    SourceDepth=(Base=10.00,Rand=10.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=15.00,Rand=2.00)

    ColorStart=(Base=(R=0,G=0,B=0,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=127,G=127,B=127,A=0))

    SizeWidth=(Base=50.00,Rand=5.00)

    SizeLength=(Base=50.00,Rand=5.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    AlphaDelay=0.30

    Chaos=10.00

    Damping=5.00

    GravityModifier=-0.40

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
