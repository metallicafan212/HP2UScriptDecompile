//================================================================================
// WaterDripCOS.
//================================================================================

class WaterDripCOS extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=0.10,Rand=1.00)

    SourceWidth=(Base=14.00,Rand=14.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=1.00,Rand=0.00)

    Lifetime=(Base=3.00,Rand=2.00)

    ColorStart=(Base=(R=66,G=87,B=130,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=70,G=80,B=132,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    DripTime=(Base=0.50,Rand=0.50)

    GravityModifier=0.35

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_Neutral'

    RenderPrimitive=PPRIM_Liquid
}
