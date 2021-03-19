//================================================================================
// Godric_41_A.
//================================================================================

class Godric_41_A extends WizardCardFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=0.00)

    SourceWidth=(Base=7.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=135.00,Rand=0.00)

    AngularSpreadHeight=(Base=135.00,Rand=0.00)

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=255,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=20.00,Rand=0.00)

    SizeEndScale=(Base=0.00,Rand=3.00)

    SizeDelay=0.30

    Attraction=(X=20.00,Y=20.00,Z=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_2'

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
