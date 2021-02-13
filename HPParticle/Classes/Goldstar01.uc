//================================================================================
// Goldstar01.
//================================================================================

class Goldstar01 extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=5.00)

    SourceWidth=(Base=10.00,Rand=10.00)

    SourceHeight=(Base=10.00,Rand=10.00)

    SourceDepth=(Base=5.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=1.50,Rand=0.50)

    ColorStart=(Base=(R=244,G=253,B=85,A=0),Rand=(R=138,G=138,B=138,A=0))

    ColorEnd=(Base=(R=255,G=26,B=31,A=0),Rand=(R=127,G=127,B=127,A=0))

    SizeWidth=(Base=2.00,Rand=4.00)

    SizeLength=(Base=2.00,Rand=4.00)

    SpinRate=(Base=-1.00,Rand=2.00)

    AlphaDelay=0.70

    Attraction=(X=10.00,Y=10.00,Z=10.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Goldstar01'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
