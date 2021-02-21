//================================================================================
// Spongify_Fly.
//================================================================================

class Spongify_Fly extends AllSpellCast_FX;

defaultproperties
{
    SourceWidth=(Base=5.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    SourceDepth=(Base=5.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=10.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=143,G=63,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=43,G=62,B=138,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=8.00)

    SizeLength=(Base=4.00,Rand=8.00)

    bSystemRelative=True

    Chaos=10.00

    Damping=10.00

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
