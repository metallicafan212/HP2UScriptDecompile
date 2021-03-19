//================================================================================
// Levitate_wand.
//================================================================================

class Levitate_wand extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=60.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    AngularSpreadHeight=(Base=1.00,Rand=0.00)

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=0.25,Rand=0.00)

    ColorStart=(Base=(R=169,G=184,B=241,A=0),Rand=(R=60,G=39,B=175,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=0.00)

    SizeLength=(Base=1.00,Rand=0.00)

    SizeEndScale=(Base=-1.00,Rand=10.00)

    SpinRate=(Base=1.00,Rand=20.00)

    Chaos=1.00

    GravityModifier=0.00

    Textures=FireTexture'HPParticle.hp_fx.Particles.F_spark'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
