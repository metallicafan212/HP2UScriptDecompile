//================================================================================
// Bicorn.
//================================================================================

class Bicorn extends PotionIngredients;

state PickupProp
{
  function EndState()
  {
    TriggerEvent(Event,None,None);
    Super.EndState();
  }
  
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup11'

    soundDropOff=Sound'HPSounds.menu_sfx.add_potion_ingredient'

    bPickupOnTouch=True

    // PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupPolyIngr'

    classStatusItem=Class'StatusItemBicorn'

    // Physics=1
	Physics=PHYS_Walking

    Mesh=SkeletalMesh'HProps.skBicornMesh'

    CollisionRadius=14.00

    CollisionHeight=30.00

    bBlockActors=False

    bBlockPlayers=False
}
