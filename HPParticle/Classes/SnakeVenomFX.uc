//================================================================================
// SnakeVenomFX.
//================================================================================

class SnakeVenomFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=45.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=0.17,Rand=0.00)

    ColorStart=(Base=(R=134,G=96,B=223,A=0),Rand=(R=88,G=70,B=191,A=0))

    ColorEnd=(Base=(R=214,G=32,B=223,A=0),Rand=(R=230,G=72,B=155,A=0))

    SizeWidth=(Base=16.00,Rand=8.00)

    SizeLength=(Base=16.00,Rand=8.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_1'
}
