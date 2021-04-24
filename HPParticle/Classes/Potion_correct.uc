//================================================================================
// Potion_correct.
//================================================================================

class Potion_correct extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceWidth=(Base=20.00,Rand=10.00)

    SourceHeight=(Base=20.00,Rand=10.00)

    SourceDepth=(Base=5.00,Rand=0.00)

    AngularSpreadWidth=(Base=60.00,Rand=0.00)

    AngularSpreadHeight=(Base=60.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=3.00)

    ColorStart=(Base=(R=130,G=130,B=130,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=0.00)

    SizeLength=(Base=15.00,Rand=0.00)

    SizeEndScale=(Base=-1.00,Rand=20.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Chaos=5.00

    Damping=0.20

    GravityModifier=-0.02

    ParticlesMax=75

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke2'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
