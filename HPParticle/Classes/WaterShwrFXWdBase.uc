//================================================================================
// WaterShwrFXWdBase.
//================================================================================

class WaterShwrFXWdBase extends WaterShowerFX;

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=10.00)

    AngularSpreadWidth=(Base=120.00,Rand=5.00)

    AngularSpreadHeight=(Base=120.00,Rand=5.00)

    Speed=(Base=120.00,Rand=30.00)

    Lifetime=(Base=1.50,Rand=0.00)

    ColorEnd=(Base=(R=23,G=255,B=35,A=0),Rand=(R=36,G=0,B=1,A=0))

    Damping=0.40

    CollisionRadius=120.00
}
