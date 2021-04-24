//================================================================================
// Snitch_FX.
//================================================================================

class Snitch_FX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=4.00,Rand=0.00)

    SourceHeight=(Base=4.00,Rand=0.00)

    SourceDepth=(Base=4.00,Rand=0.00)

    AngularSpreadWidth=(Base=30.00,Rand=0.00)

    AngularSpreadHeight=(Base=30.00,Rand=0.00)

    bSteadyState=True

    Lifetime=(Base=0.50,Rand=0.50)

    ColorStart=(Base=(R=255,G=222,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=253,G=202,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=16.00,Rand=8.00)

    SizeLength=(Base=16.00,Rand=8.00)

    Damping=1.00

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'

    CollisionRadius=10000.00
}
