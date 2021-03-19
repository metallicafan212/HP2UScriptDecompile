//================================================================================
// FSSeedFire.
//================================================================================

class FSSeedFire extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=20.00)

    SourceWidth=(Base=0.00,Rand=1.00)

    SourceHeight=(Base=0.00,Rand=1.00)

    SourceDepth=(Base=0.00,Rand=1.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    Speed=(Base=0.00,Rand=8.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    SizeWidth=(Base=1.00,Rand=1.00)

    SizeLength=(Base=1.00,Rand=1.00)

    SizeEndScale=(Base=0.00,Rand=1.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    Chaos=1.00

    Damping=5.00

    Distribution=DIST_OwnerMesh

    GravityModifier=-0.05

    Textures=Texture'HPParticle.hp_fx.Spells.Les_fire_01'
}
