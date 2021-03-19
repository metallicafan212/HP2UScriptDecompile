//================================================================================
// GoldstarFinal.
//================================================================================

class GoldstarFinal extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=5.00)

    SourceWidth=(Base=10.00,Rand=10.00)

    SourceHeight=(Base=10.00,Rand=10.00)

    SourceDepth=(Base=5.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=80.00,Rand=30.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=244,G=253,B=85,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=255,G=26,B=31,A=0),Rand=(R=127,G=127,B=127,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    AlphaDelay=0.70

    Attraction=(X=3.00,Y=3.00,Z=3.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Goldstar01'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
