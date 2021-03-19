//================================================================================
// CloudWind.
//================================================================================

class CloudWind extends FlyingFord;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceHeight=(Base=100.00,Rand=0.00)

    Speed=(Base=300.00,Rand=150.00)

    ColorStart=(Base=(R=128,G=128,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=20.00,Rand=0.00)

    SizeLength=(Base=20.00,Rand=0.00)

    SpinRate=(Base=3.00,Rand=2.00)

    Textures=Texture'HPParticle.hp_fx.Particles.swirl001'

    LastUpdateLocation=(X=-104.67,Y=5.33,Z=-74.00)

    LastEmitLocation=(X=-104.67,Y=5.33,Z=-74.00)

    EmissionResidue=0.28

    Age=10880.93

    ParticlesEmitted=117183

    Location=(X=-104.67,Y=5.33,Z=-74.00)

    Rotation=(Pitch=0,Yaw=0,Roll=0)

    OldLocation=(X=-122.00,Y=16.00,Z=-16.00)
}
