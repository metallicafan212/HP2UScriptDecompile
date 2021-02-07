//================================================================================
// duelExpelliarmus_fly.
//================================================================================

class duelExpelliarmus_fly extends AllSpellCast_FX;

defaultproperties
{
    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=237,B=15,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=191,B=60,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=7.00,Rand=0.00)

    SizeLength=(Base=7.00,Rand=0.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    bSystemRelative=True

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=0,Yaw=0,Roll=0)
}
