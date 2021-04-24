//================================================================================
// Incend_book.
//================================================================================

class Incend_book extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=250.00,Rand=50.00)

    SourceWidth=(Base=25.00,Rand=0.00)

    SourceHeight=(Base=15.00,Rand=0.00)

    SourceDepth=(Base=40.00,Rand=0.00)

    AngularSpreadWidth=(Base=35.00,Rand=0.00)

    AngularSpreadHeight=(Base=35.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=30.00,Rand=10.00)

    Lifetime=(Base=1.50,Rand=0.00)

    ColorStart=(Base=(R=128,G=64,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=9.00,Rand=0.00)

    SizeLength=(Base=15.00,Rand=0.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=0.00,Y=0.00,Z=-5.00)

    Damping=4.00

    Textures(0)=FireTexture'HPParticle.hp_fx.Particles.F_Spark2'

    LastUpdateLocation=(X=-383.54,Y=385.14,Z=15.72)

    LastEmitLocation=(X=-383.54,Y=385.14,Z=15.72)

    LastUpdateRotation=(Pitch=16256,Yaw=-16336,Roll=0)

    EmissionResidue=0.50

    Age=180.03

    bDynamicLight=True

    Tag=ParticleFX

    Location=(X=-383.54,Y=385.14,Z=15.72)

    Rotation=(Pitch=16256,Yaw=-16336,Roll=0)

    OldLocation=(X=-352.65,Y=233.87,Z=15.72)
}
