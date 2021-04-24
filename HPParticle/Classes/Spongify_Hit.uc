//================================================================================
// Spongify_Hit.
//================================================================================

class Spongify_Hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5000.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=30.00,Rand=30.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=0.00)

    SizeLength=(Base=2.00,Rand=0.00)

    bSystemRelative=True

    Damping=1.50

    ParticlesMax=50

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_2'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
