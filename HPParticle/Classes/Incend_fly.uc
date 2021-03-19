//================================================================================
// Incend_fly.
//================================================================================

class Incend_fly extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    Speed=(Base=25.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=30,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=6.00)

    SizeLength=(Base=3.00,Rand=6.00)

    SizeEndScale=(Base=5.00,Rand=8.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    Attraction=(X=5.00,Y=5.00,Z=5.00)

    Textures=Texture'HPParticle.hp_fx.Spells.Les_BlueSmoke'

    LastUpdateLocation=(X=0.00,Y=20.00,Z=32.00)

    LastEmitLocation=(X=0.00,Y=20.00,Z=32.00)

    EmissionResidue=0.07

    Age=434.01

    ParticlesEmitted=88822

    Tag=Flip_fly

    Location=(X=0.00,Y=20.00,Z=32.00)

    Rotation=(Pitch=0,Yaw=0,Roll=0)
}
