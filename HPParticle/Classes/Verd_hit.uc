//================================================================================
// Verd_hit.
//================================================================================

class Verd_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=0.00)

    SourceWidth=(Base=20.00,Rand=30.00)

    SourceHeight=(Base=20.00,Rand=30.00)

    SourceDepth=(Base=60.00,Rand=30.00)

    AngularSpreadWidth=(Base=40.00,Rand=0.00)

    AngularSpreadHeight=(Base=40.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=40.00)

    Lifetime=(Base=3.00,Rand=0.00)

    ColorStart=(Base=(R=15,G=217,B=4,A=0),Rand=(R=64,G=114,B=56,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=0.00)

    SizeLength=(Base=15.00,Rand=0.00)

    SizeEndScale=(Base=-5.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=5.00

    Attraction=(X=20.00,Y=20.00,Z=0.00)

    ParticlesMax=200

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_8'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
