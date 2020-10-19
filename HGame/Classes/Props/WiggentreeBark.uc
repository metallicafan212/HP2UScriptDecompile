//================================================================================
// WiggentreeBark.
//================================================================================

class WiggentreeBark extends PotionIngredients;

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup_wig_bark'

    soundDropOff=Sound'HPSounds.menu_sfx.add_potion_ingredient'

    bPickupOnTouch=True

    // PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    fMinFlyToHudScale=0.10

    fMaxFlyToHudScale=0.60

    classStatusGroup=Class'StatusGroupPotionIngr'

    classStatusItem=Class'StatusItemWiggenBark'

    bBounceIntoPlace=True

    soundBounce=Sound'HPSounds.Magic_sfx.bean_bounce'

    // Physics=5
	Physics=PHYS_Rotating

    Mesh=SkeletalMesh'HProps.skWiggentreeBarkMesh'

    DrawScale=0.80

    CollisionRadius=5.00

    CollisionHeight=10.00

    bBlockPlayers=False

    bFixedRotationDir=True

    RotationRate=(Pitch=0,Yaw=15000,Roll=0)
}
