//================================================================================
// WizCardGiveFX.
//================================================================================

class WizCardGiveFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=80.00)

    SourceWidth=(Base=0.00,Rand=50.00)

    SourceHeight=(Base=0.00,Rand=50.00)

    SourceDepth=(Base=0.00,Rand=50.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=0.00,Rand=30.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=128,B=64,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=255,G=0,B=0,A=0),Rand=(R=0,G=0,B=255,A=0))

    SizeWidth=(Base=1.00,Rand=3.00)

    SizeLength=(Base=1.00,Rand=3.00)

    SizeEndScale=(Base=0.00,Rand=3.00)

    Chaos=1.00

    Attraction=(X=0.00,Y=0.00,Z=10.00)

    Distribution=DIST_OwnerMesh

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'
}
