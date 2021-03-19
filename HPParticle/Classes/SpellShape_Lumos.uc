//================================================================================
// SpellShape_Lumos.
//================================================================================

class SpellShape_Lumos extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    SourceDepth=(Base=1.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    bSteadyState=True

    Speed=(Base=80.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=8.00)

    SizeLength=(Base=1.00,Rand=8.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Chaos=1.00

    Damping=20.00

    GravityModifier=0.10

    ParticlesMax=180

    Textures=Texture'HPParticle.hp_fx.General.CandleF'

    EmitDelay=0.79

    LastUpdateLocation=(X=224.00,Y=0.00,Z=32.00)

    LastEmitLocation=(X=224.00,Y=0.00,Z=32.00)

    LastUpdateRotation=(Pitch=16336,Yaw=0,Roll=0)

    Age=1451.50

    bDynamicLight=True

    Tag=Dummyparticle

    Location=(X=224.00,Y=0.00,Z=32.00)

    Rotation=(Pitch=16336,Yaw=0,Roll=0)

    OldLocation=(X=224.00,Y=0.00,Z=32.00)
}
