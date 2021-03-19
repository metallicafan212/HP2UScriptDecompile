//================================================================================
// CloudPuffs.
//================================================================================

class CloudPuffs extends FlyingFord;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=2.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=30.00,Rand=0.00)

    SourceDepth=(Base=150.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    Speed=(Base=20.00,Rand=200.00)

    Lifetime=(Base=5.00,Rand=0.00)

    ColorEnd=(Base=(R=128,G=128,B=192,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=40.00,Rand=0.00)

    SizeLength=(Base=40.00,Rand=0.00)

    SizeEndScale=(Base=10.00,Rand=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.FF_SmallPuff'

    EmitDelay=0.03

    LastUpdateLocation=(X=-113.11,Y=32.23,Z=-79.87)

    LastEmitLocation=(X=-113.11,Y=32.23,Z=-79.87)

    LastUpdateRotation=(Pitch=16,Yaw=-16,Roll=0)

    EmissionResidue=0.10

    Age=8829.47

    ParticlesEmitted=93169

    Location=(X=-113.11,Y=32.23,Z=-79.87)

    Rotation=(Pitch=0,Yaw=-16,Roll=0)

    OldLocation=(X=-96.07,Y=-0.05,Z=-92.00)
}
