//================================================================================
// Paracelsus_15_A.
//================================================================================

class Paracelsus_15_A extends WizardCardFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=100.00,Rand=0.00)

    SourceWidth=(Base=10.00,Rand=5.00)

    SourceHeight=(Base=10.00,Rand=5.00)

    SourceDepth=(Base=10.00,Rand=5.00)

    AngularSpreadWidth=(Base=25.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    Speed=(Base=40.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=13,G=0,B=249,A=0))

    SizeWidth=(Base=2.00,Rand=5.00)

    SizeLength=(Base=2.00,Rand=5.00)

    SizeEndScale=(Base=0.00,Rand=3.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    SizeDelay=0.30

    Chaos=1.00

    Damping=1.00

    GravityModifier=0.20

    ParticlesMax=300

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    LastUpdateLocation=(X=-0.28,Y=224.00,Z=-16.60)

    LastEmitLocation=(X=-0.28,Y=224.00,Z=-16.60)

    LastUpdateRotation=(Pitch=16504,Yaw=0,Roll=0)

    EmissionResidue=0.24

    Age=1615.91

    ParticlesEmitted=129563

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=-0.28,Y=224.00,Z=-16.60)

    Rotation=(Pitch=-16352,Yaw=0,Roll=0)

    DesiredRotation=(Pitch=-16352,Yaw=0,Roll=0)
}
