//================================================================================
// Bludger_FX.
//================================================================================

class Bludger_FX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=5.00)

    SourceHeight=(Base=0.00,Rand=5.00)

    SourceDepth=(Base=0.00,Rand=5.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=30.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=83,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=8.00)

    SizeLength=(Base=1.00,Rand=8.00)

    SizeEndScale=(Base=0.00,Rand=15.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    Textures=Texture'HPParticle.hp_fx.Spells.Les_BlueSmoke'

    CollisionRadius=10000.00
}
