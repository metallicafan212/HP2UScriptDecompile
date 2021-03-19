//================================================================================
// LumosPlatform.
//================================================================================

class LumosPlatform extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=5.00)

    SourceWidth=(Base=96.00,Rand=0.00)

    SourceHeight=(Base=16.00,Rand=0.00)

    SourceDepth=(Base=96.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=250,G=206,B=1,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=185,G=151,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.25,Rand=0.00)

    SizeLength=(Base=1.25,Rand=0.00)

    SizeEndScale=(Base=60.00,Rand=10.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=1.00

    Textures=Texture'HPParticle.hp_fx.General.CandleF'

    CollisionHeight=20.00
}
