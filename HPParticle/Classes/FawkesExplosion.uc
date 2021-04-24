//================================================================================
// FawkesExplosion.
//================================================================================

class FawkesExplosion extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=400.00,Rand=0.00)

    SourceWidth=(Base=30.00,Rand=15.00)

    SourceHeight=(Base=5.00,Rand=15.00)

    SourceDepth=(Base=30.00,Rand=15.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    Speed=(Base=100.00,Rand=50.00)

    Lifetime=(Base=0.50,Rand=1.00)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=255,G=200,B=125,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=5.00)

    SizeLength=(Base=15.00,Rand=5.00)

    SizeEndScale=(Base=0.10,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    SizeDelay=0.60

    Chaos=2.00

    Damping=5.00

    GravityModifier=-0.50

    ParticlesMax=500

    Textures(0)=FireTexture'HPParticle.hp_fx.Spells.GoldSparkle01'

    bDynamicLight=True

    Rotation=(Pitch=16368,Yaw=0,Roll=0)

    bSelected=True

    CollisionRadius=35.00

    CollisionHeight=40.00
}
