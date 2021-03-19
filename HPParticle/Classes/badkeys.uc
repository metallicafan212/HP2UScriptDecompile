//================================================================================
// badkeys.
//================================================================================

class badkeys extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=0.00,Rand=5.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=75.00,Rand=125.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=128,G=0,B=128,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=255,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=1.00,Rand=0.00)

    SizeWidth=(Base=50.00,Rand=0.00)

    SizeLength=(Base=50.00,Rand=0.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-1.00,Rand=1.00)

    Chaos=1.00

    Attraction=(X=3.00,Y=3.00,Z=3.00)

    Damping=1.00

    Textures=Texture'HPParticle.hp_fx.General.AngryKeys_A00'
}
