//================================================================================
// WaterBknSprayBase.
//================================================================================

class WaterBknSprayBase extends WaterShowerFX;

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=25.00)

    AngularSpreadWidth=(Base=20.00,Rand=20.00)

    AngularSpreadHeight=(Base=60.00,Rand=20.00)

    Speed=(Base=170.00,Rand=30.00)

    Lifetime=(Base=0.50,Rand=0.00)

    ColorStart=(Base=(R=0,G=206,B=83,A=0),Rand=(R=99,G=68,B=39,A=0))

    ColorEnd=(Base=(R=61,G=88,B=70,A=0),Rand=(R=47,G=77,B=85,A=0))

    SizeWidth=(Base=4.00,Rand=4.00)

    AlphaDelay=0.40

    ColorDelay=0.20

    Attraction=(X=0.00,Y=0.00,Z=0.00)

    Damping=0.00

    GravityModifier=0.30

    CollisionRadius=120.00

    CollisionHeight=120.00
}
