//================================================================================
// duelExpelliarmus_hit.
//================================================================================

class duelExpelliarmus_hit extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=16.00,Rand=0.00)

    SourceHeight=(Base=16.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=0.00)

    Lifetime=(Base=0.50,Rand=0.25)

    ColorStart=(Base=(R=255,G=237,B=15,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=191,B=60,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=10.00,Rand=0.00)

    SizeLength=(Base=10.00,Rand=0.00)

    ParticlesMax=100

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16320,Yaw=0,Roll=0)
}
