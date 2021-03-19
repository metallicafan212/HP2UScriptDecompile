//================================================================================
// DizzyStars.
//================================================================================

class DizzyStars extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1.00,Rand=10.00)

    SourceWidth=(Base=30.00,Rand=30.00)

    SourceHeight=(Base=5.00,Rand=5.00)

    SourceDepth=(Base=30.00,Rand=30.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=20.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=244,G=253,B=85,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=255,G=26,B=31,A=0),Rand=(R=127,G=127,B=127,A=0))

    SizeWidth=(Base=2.00,Rand=4.00)

    SizeLength=(Base=2.00,Rand=4.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    AlphaDelay=0.70

    Chaos=1.00

    Attraction=(X=10.00,Y=10.00,Z=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Goldstar01'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
