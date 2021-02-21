//================================================================================
// RainBasic.
//================================================================================

class RainBasic extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=75.00,Rand=50.00)

    SourceWidth=(Base=384.00,Rand=0.00)

    SourceHeight=(Base=384.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=300.00,Rand=0.00)

    Lifetime=(Base=3.00,Rand=0.00)

    ColorStart=(Base=(R=214,G=222,B=241,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=63,G=85,B=146,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=0.00)

    SizeLength=(Base=2.00,Rand=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_Neutral'

    RenderPrimitive=PPRIM_Liquid

    Rotation=(Pitch=-16608,Yaw=0,Roll=0)
}
