//================================================================================
// FlyingFord.
//================================================================================

class FlyingFord extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=4.00,Rand=0.00)

    SourceWidth=(Base=30.00,Rand=0.00)

    SourceHeight=(Base=50.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=250.00,Rand=200.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=60.00,Rand=0.00)

    SizeLength=(Base=30.00,Rand=0.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.FF_Wind'

    LastUpdateLocation=(X=-128.08,Y=-40.05,Z=186.00)

    LastEmitLocation=(X=-128.08,Y=-40.05,Z=186.00)

    LastUpdateRotation=(Pitch=16,Yaw=0,Roll=0)

    EmissionResidue=0.34

    Age=12313.84

    ParticlesEmitted=117612

    Tag=ParticleFX

    Location=(X=-128.08,Y=-40.05,Z=186.00)

    Rotation=(Pitch=16,Yaw=0,Roll=0)

    OldLocation=(X=32.00,Y=-16.00,Z=-16.00)
}
