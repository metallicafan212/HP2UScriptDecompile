//================================================================================
// FSSeedSmoke.
//================================================================================

class FSSeedSmoke extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=10.00,Rand=40.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    Speed=(Base=1.00,Rand=1.00)

    Lifetime=(Base=1.00,Rand=2.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=3.50)

    SizeLength=(Base=1.00,Rand=3.50)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    SizeDelay=1.00

    SizeGrowPeriod=0.10

    Distribution=DIST_OwnerMesh

    GravityModifier=-0.01

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Dark_Smoke5'

    Style=STY_Modulated
}
