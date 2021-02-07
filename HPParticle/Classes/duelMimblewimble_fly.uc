//================================================================================
// duelMimblewimble_fly.
//================================================================================

class duelMimblewimble_fly extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=10.00,Rand=0.00)

    AngularSpreadHeight=(Base=10.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=30.00,Rand=15.00)

    ColorStart=(Base=(R=34,G=67,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=113,G=6,B=164,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=10.00,Rand=0.00)

    SizeLength=(Base=10.00,Rand=0.00)

    SizeEndScale=(Base=-1.00,Rand=0.00)

    SpinRate=(Base=5.00,Rand=10.00)

    SizeDelay=1.00

    Chaos=3.00

    Damping=2.00

    GravityModifier=0.05

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
