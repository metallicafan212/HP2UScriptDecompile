//================================================================================
// GenericColObj.
//================================================================================

class GenericColObj extends HiddenHPawn;

var bool bIsHead;

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
	return HPawn(Owner).HandleSpellFlipendo(spell,vHitLocation);
}

function Touch (Actor Other)
{
	if ( HPawn(Owner) != None )
	{
		HPawn(Owner).ColObjTouch(Other,self);
	}
}

defaultproperties
{
    bIgnoreZonePainDamage=True

    DrawType=DT_None

    CollisionRadius=20.00

    CollisionHeight=30.00

    bCollideActors=True

}