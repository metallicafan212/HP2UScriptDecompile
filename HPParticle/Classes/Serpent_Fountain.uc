//================================================================================
// Serpent_Fountain.
//================================================================================

class Serpent_Fountain extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=15.00,Rand=10.00)

    SourceWidth=(Base=6.00,Rand=0.00)

    SourceHeight=(Base=6.00,Rand=0.00)

    bSteadyState=True

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=58,G=193,B=13,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=61,G=171,B=71,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=0.00)

    SizeLength=(Base=3.00,Rand=0.00)

    SizeEndScale=(Base=4.00,Rand=3.00)

    GravityModifier=0.10

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_1'

    RenderPrimitive=PPRIM_Liquid

    Rotation=(Pitch=-6208,Yaw=128,Roll=0)

    bRotateToDesired=True
}
