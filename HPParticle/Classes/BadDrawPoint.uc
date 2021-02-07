//================================================================================
// BadDrawPoint.
//================================================================================

class BadDrawPoint extends GoodDrawPoint;

defaultproperties
{
    AngularSpreadWidth=(Base=60.00,Rand=0.00)

    AngularSpreadHeight=(Base=60.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=0.00)

    Lifetime=(Base=3.00,Rand=3.00)

    ColorStart=(Base=(R=255,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeEndScale=(Base=1.00,Rand=5.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    GravityModifier=0.10
}
