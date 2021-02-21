//================================================================================
// Snow.
//================================================================================

class Snow extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=40.00,Rand=0.00)

    SourceWidth=(Base=256.00,Rand=0.00)

    SourceHeight=(Base=1024.00,Rand=0.00)

    bSteadyState=True

    bPrime=True

    Speed=(Base=60.00,Rand=10.00)

    Lifetime=(Base=8.00,Rand=0.00)

    ColorStart=(Base=(R=169,G=165,B=211,A=0),Rand=(R=117,G=117,B=117,A=0))

    ColorEnd=(Base=(R=105,G=88,B=188,A=0),Rand=(R=125,G=125,B=125,A=0))

    AlphaStart=(Base=0.50,Rand=1.00)

    SizeWidth=(Base=8.00,Rand=4.00)

    SizeLength=(Base=8.00,Rand=4.00)

    AlphaDelay=9.00

    Chaos=1.00

    WindModifier=1.00

    GravityModifier=0.01

    Gravity=(X=0.00,Y=0.00,Z=-1.00)

    Textures=Texture'HPParticle.particle_fx.soft_pfx'
}
