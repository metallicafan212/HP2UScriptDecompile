//================================================================================
// WizCardSpin.
//================================================================================

class WizCardSpin extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=80.00)

    SourceWidth=(Base=20.00,Rand=50.00)

    SourceHeight=(Base=20.00,Rand=50.00)

    SourceDepth=(Base=20.00,Rand=50.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=0.00,Rand=100.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=0,G=0,B=255,A=0),Rand=(R=255,G=255,B=255,A=0))

    ColorEnd=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=4.00)

    SizeLength=(Base=2.00,Rand=4.00)

    SizeEndScale=(Base=0.00,Rand=6.00)

    Chaos=1.00

    Attraction=(X=5.00,Y=5.00,Z=0.00)

    Damping=2.00

    Distribution=DIST_OwnerMesh

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'
}
