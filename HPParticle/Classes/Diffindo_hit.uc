//================================================================================
// Diffindo_hit.
//================================================================================

class Diffindo_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=10.00,Rand=5.00)

    SourceHeight=(Base=10.00,Rand=5.00)

    SourceDepth=(Base=5.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=100.00,Rand=30.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=121,G=255,B=11,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=5.00,Rand=8.00)

    SizeLength=(Base=5.00,Rand=8.00)

    DripTime=(Base=0.10,Rand=0.00)

    bSystemRelative=True

    Damping=1.00

    ParticlesMax=100

    Textures=Texture'HPParticle.particle_fx.noisy2_pfx'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
