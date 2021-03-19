//================================================================================
// SwordBladeFX.
//================================================================================

class SwordBladeFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=0.00)

    SourceWidth=(Base=6.00,Rand=0.00)

    SourceHeight=(Base=6.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=15.00,Rand=10.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=254,G=27,B=1,A=0),Rand=(R=254,G=186,B=5,A=0))

    ColorEnd=(Base=(R=247,G=255,B=77,A=0),Rand=(R=254,G=159,B=18,A=0))

    SizeWidth=(Base=2.00,Rand=6.00)

    SizeLength=(Base=2.00,Rand=6.00)

    bSystemRelative=True

    Attraction=(X=20.00,Y=20.00,Z=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'
}
