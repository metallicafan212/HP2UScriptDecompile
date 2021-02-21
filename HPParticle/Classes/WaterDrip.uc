//================================================================================
// WaterDrip.
//================================================================================

class WaterDrip extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=0.25,Rand=0.00)

    SourceDepth=(Base=2.00,Rand=0.00)

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=3.50,Rand=0.00)

    ColorStart=(Base=(R=16,G=197,B=197,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=28,G=170,B=163,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=0.90,Rand=0.00)

    SizeWidth=(Base=4.00,Rand=0.00)

    SizeLength=(Base=4.00,Rand=0.00)

    DripTime=(Base=0.25,Rand=0.00)

    Elasticity=0.10

    Gravity=(X=0.00,Y=0.00,Z=-200.00)

    RenderPrimitive=PPRIM_Liquid

    CollisionHeight=512.00
}
