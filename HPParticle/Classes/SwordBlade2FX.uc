//================================================================================
// SwordBlade2FX.
//================================================================================

class SwordBlade2FX extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=10.00)

    SourceWidth=(Base=6.00,Rand=0.00)

    SourceHeight=(Base=6.00,Rand=0.00)

    AngularSpreadWidth=(Base=10.00,Rand=0.00)

    AngularSpreadHeight=(Base=10.00,Rand=0.00)

    Speed=(Base=30.00,Rand=15.00)

    Lifetime=(Base=0.30,Rand=0.00)

    ColorStart=(Base=(R=254,G=27,B=1,A=0),Rand=(R=254,G=186,B=5,A=0))

    ColorEnd=(Base=(R=247,G=255,B=77,A=0),Rand=(R=254,G=159,B=18,A=0))

    SizeWidth=(Base=25.00,Rand=0.00)

    SizeLength=(Base=25.00,Rand=0.00)

    SizeEndScale=(Base=-1.00,Rand=0.00)

    SpinRate=(Base=5.00,Rand=10.00)

    Chaos=3.00

    GravityModifier=0.05

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
