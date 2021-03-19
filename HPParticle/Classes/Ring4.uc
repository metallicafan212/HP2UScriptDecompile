//================================================================================
// Ring4.
//================================================================================

class Ring4 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=175.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=255,G=207,B=15,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=102,B=28,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=35.00,Rand=15.00)

    SizeLength=(Base=35.00,Rand=15.00)

    SizeEndScale=(Base=-1.00,Rand=0.00)

    Distribution=DIST_OwnerMesh

    GravityModifier=0.10

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
