//================================================================================
// QArmor.
//================================================================================

class QArmor extends HProp;

auto state BounceIntoPlace
{
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup11'

    bPickupOnTouch=True

    // PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupQGear'

    classStatusItem=Class'StatusItemQArmor'

    bBounceIntoPlace=True

    soundBounce=Sound'HPSounds.Magic_sfx.bean_bounce'

    // Physics=1
	Physics=PHYS_Walking

    bPersistent=True

    Mesh=SkeletalMesh'HProps.skQuidArmorMesh'

    bBlockPlayers=False
}
