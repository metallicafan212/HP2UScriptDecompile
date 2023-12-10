//================================================================================
// baseBasilisk.
//================================================================================

class baseBasilisk extends baseBoss;

var() float HeadDamage;
var() float TailDamage;

function ColObjTouch (Actor Other, GenericColObj ColObj)
{
}

defaultproperties
{
    HeadDamage=80.00

    TailDamage=3.00

    // EnemyHealthBar=1
	EnemyHealthBar=EnemyBar_Basilisk

    // Physics=0
	Physics=PHYS_None
}
