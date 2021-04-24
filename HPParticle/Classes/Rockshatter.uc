//================================================================================
// Rockshatter.
//================================================================================

class Rockshatter extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5000.00,Rand=0.00)

    AngularSpreadWidth=(Base=60.00,Rand=0.00)

    AngularSpreadHeight=(Base=60.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=150.00,Rand=50.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=199,G=167,B=120,A=0),Rand=(R=173,G=146,B=120,A=0))

    ColorEnd=(Base=(R=102,G=100,B=77,A=0),Rand=(R=156,G=109,B=82,A=0))

    SizeWidth=(Base=6.00,Rand=4.00)

    SizeLength=(Base=6.00,Rand=4.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Damping=3.00

    GravityModifier=0.75

    ParticlesMax=20

    Textures(0)=Texture'HPParticle.hp_fx.Particles.rockpiece'

    Style=STY_Masked

    AmbientGlow=200
}
