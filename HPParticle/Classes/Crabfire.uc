//================================================================================
// Crabfire.
//================================================================================

class Crabfire extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=70.00,Rand=30.00)

    SourceWidth=(Base=0.00,Rand=15.00)

    SourceHeight=(Base=0.00,Rand=15.00)

    SourceDepth=(Base=0.00,Rand=15.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=20.00,Rand=10.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=255,G=200,B=125,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=8.00,Rand=4.00)

    SizeLength=(Base=8.00,Rand=4.00)

    SizeEndScale=(Base=0.10,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    Chaos=2.00

    Elasticity=0.01

    Damping=5.00

    GravityModifier=0.50

    Textures=Texture'HPParticle.hp_fx.Spells.Les_fire_01'

    bDynamicLight=True

    Rotation=(Pitch=16368,Yaw=0,Roll=0)

    bSelected=True
}
