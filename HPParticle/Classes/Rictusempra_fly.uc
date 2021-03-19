//================================================================================
// Rictusempra_fly.
//================================================================================

class Rictusempra_fly extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=40.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=207,G=46,B=50,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=111,B=55,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=16.00,Rand=0.00)

    SizeLength=(Base=16.00,Rand=0.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=1.00,Rand=8.00)

    SizeDelay=1.00

    Damping=2.00

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Physics=PHYS_Rotating

    bFixedRotationDir=True

    RotationRate=(Pitch=0,Yaw=200000,Roll=200000)
}
