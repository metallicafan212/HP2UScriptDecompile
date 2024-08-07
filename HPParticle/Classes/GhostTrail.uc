//================================================================================
// GhostTrail.
//================================================================================

class GhostTrail extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=60.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=30.00)

    SourceHeight=(Base=0.00,Rand=100.00)

    SourceDepth=(Base=0.00,Rand=30.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=1.00,Rand=1.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaStart=(Base=0.50,Rand=0.00)

    SizeWidth=(Base=3.00,Rand=10.00)

    SizeLength=(Base=3.00,Rand=10.00)

    SizeEndScale=(Base=0.00,Rand=5.00)

    SpinRate=(Base=0.50,Rand=0.00)

    Chaos=1.00

    ChaosDelay=0.50

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'
}
