//================================================================================
// secretdust.
//================================================================================

class secretdust extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=28.00,Rand=0.00)

    SourceWidth=(Base=150.00,Rand=10.00)

    SourceDepth=(Base=28.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=-0.50,Rand=1.00)

    Lifetime=(Base=8.00,Rand=4.00)

    ColorStart=(Base=(R=197,G=198,B=193,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=210,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=0.50,Rand=1.00)

    SizeLength=(Base=0.50,Rand=1.00)

    Chaos=0.20

    Gravity=(X=0.00,Y=0.50,Z=0.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_Neutral'

    Rotation=(Pitch=16208,Yaw=0,Roll=0)
}
