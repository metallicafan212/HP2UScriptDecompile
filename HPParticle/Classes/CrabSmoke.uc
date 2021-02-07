//================================================================================
// CrabSmoke.
//================================================================================

class CrabSmoke extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=0.00)

    SourceWidth=(Base=2.00,Rand=2.00)

    SourceHeight=(Base=2.00,Rand=2.00)

    AngularSpreadWidth=(Base=20.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=15.00,Rand=10.00),

    Lifetime=(Base=3.00,Rand=3.00),

    ColorStart=(Base=(R=171,G=172,B=173,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaStart=(Base=0.25,Rand=0.00)

    AlphaEnd=(Base=1.00,Rand=0.00)

    SizeWidth=(Base=16.00,Rand=6.00)

    SizeLength=(Base=16.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=5.00

    ChaosDelay=1.00

    Attraction=(X=1.00,Y=1.00,Z=0.00)

    Damping=0.20

    ParticlesMax=25

    Textures=None

    Rotation=(Pitch=16384,Yaw=0,Roll=0)

    Style=STY_Modulated
}
