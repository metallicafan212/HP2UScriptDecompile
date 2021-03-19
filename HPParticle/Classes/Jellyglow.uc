//================================================================================
// Jellyglow.
//================================================================================

class Jellyglow extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=10.00,Rand=0.00)

    SourceWidth=(Base=15.00,Rand=0.00)

    SourceHeight=(Base=15.00,Rand=0.00)

    SourceDepth=(Base=15.00,Rand=0.00)

    AngularSpreadWidth=(Base=2.00,Rand=0.00)

    AngularSpreadHeight=(Base=2.00,Rand=0.00)

    Speed=(Base=2.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=157,G=101,B=203,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=10.00)

    SizeLength=(Base=2.00,Rand=10.00)

    SizeEndScale=(Base=-0.50,Rand=0.00)

    SpinRate=(Base=0.50,Rand=10.00)

    Attraction=(X=10.00,Y=10.00,Z=0.00)

    ParticlesAlive=10

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
