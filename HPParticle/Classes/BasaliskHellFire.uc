//================================================================================
// BasaliskHellFire.
//================================================================================

class BasaliskHellFire extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=100.00,Rand=25.00)

    SourceHeight=(Base=50.00,Rand=25.00)

    SourceDepth=(Base=5.00,Rand=5.00)

    Speed=(Base=300.00,Rand=300.00)

    Lifetime=(Base=6.00,Rand=2.00)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=255,G=200,B=125,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=50.00,Rand=25.00)

    SizeLength=(Base=200.00,Rand=25.00)

    SizeEndScale=(Base=0.10,Rand=0.00)

    SizeDelay=0.60

    Chaos=2.00

    Attraction=(X=0.50,Y=0.50,Z=0.00)

    Damping=0.70

    Gravity=(X=0.00,Y=0.00,Z=-20.00)

    ParticlesMax=500

    Textures(0)=FireTexture'HPParticle.hp_fx.Spells.GoldSparkle01'

    bDynamicLight=True

    bSelected=True

    CollisionRadius=35.00

    CollisionHeight=40.00
}
