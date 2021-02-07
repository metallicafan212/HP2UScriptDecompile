//================================================================================
// Explosion_02.
//================================================================================

class Explosion_02 extends Explosion_01;

defaultproperties
{
    SourceWidth=(Base=0.00,Rand=10.00)

    SourceHeight=(Base=0.00,Rand=10.00)

    SourceDepth=(Base=0.00,Rand=10.00)

    Speed=(Base=300.00,Rand=100.00)

    ColorStart=(Base=(R=255,G=128,B=64,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=64,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=8.00)

    SizeLength=(Base=4.00,Rand=8.00)

    SizeEndScale=(Base=0.00,Rand=20.00)

    Chaos=10.00

    Attraction=(X=-0.08,Y=-0.08,Z=-0.08)

    Damping=10.00

    GravityModifier=-0.02
}
