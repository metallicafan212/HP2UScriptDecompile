//================================================================================
// Skurge_hit.
//================================================================================

class Skurge_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

function PreBeginPlay()
{
  Super.PreBeginPlay();
  SetRotation(DesiredRotation);
}

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=64.00,Rand=0.00)

    SourceHeight=(Base=64.00,Rand=0.00)

    SourceDepth=(Base=10.00,Rand=0.00)

    AngularSpreadWidth=(Base=60.00,Rand=0.00)

    AngularSpreadHeight=(Base=60.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=80.00)

    Lifetime=(Base=3.00,Rand=3.00)

    ColorStart=(Base=(R=94,G=225,B=97,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=99,G=172,B=68,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=6.00)

    SizeLength=(Base=12.00,Rand=6.00)

    SizeEndScale=(Base=-1.00,Rand=2.00)

    Chaos=1.00

    Elasticity=0.10

    Damping=1.00

    GravityModifier=1.00

    Textures(0)=Texture'HPParticle.hp_fx.Particles.blob32'

    Rotation=(Pitch=16352,Yaw=0,Roll=0)

    bFixedRotationDir=True

    bRotateToDesired=True
}
