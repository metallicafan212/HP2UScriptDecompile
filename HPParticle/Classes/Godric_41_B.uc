//================================================================================
// Godric_41_B.
//================================================================================

class Godric_41_B extends WizardCardFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=300.00,Rand=100.00)

    SourceWidth=(Base=10.00,Rand=10.00)

    SourceHeight=(Base=10.00,Rand=10.00)

    SourceDepth=(Base=5.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=150.00,Rand=0.00)

    Lifetime=(Base=2.50,Rand=0.50)

    ColorStart=(Base=(R=244,G=253,B=85,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=255,G=26,B=31,A=0),Rand=(R=127,G=127,B=127,A=0))

    AlphaStart=(Base=0.00,Rand=0.00)

    AlphaEnd=(Base=1.00,Rand=0.00)

    SizeWidth=(Base=40.00,Rand=10.00)

    SizeLength=(Base=40.00,Rand=10.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    AlphaGrowPeriod=0.40

    SizeGrowPeriod=1.00

    Attraction=(X=1.00,Y=1.00,Z=1.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_5_BW'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
