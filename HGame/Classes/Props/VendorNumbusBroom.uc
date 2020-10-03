//================================================================================
// VendorNimbusBroom.
//================================================================================

class VendorNimbusBroom extends HProp;

auto state BounceIntoPlace extends BounceIntoPlace
{
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup11'

    bPickupOnTouch=True

    PickupFlyTo=2

    classStatusGroup=Class'StatusGroupQGear'

    classStatusItem=Class'StatusItemNimbus'

    bBounceIntoPlace=True

    soundBounce=Sound'HPSounds.Magic_sfx.bean_bounce'

    Physics=1

    bPersistent=True

    Mesh=SkeletalMesh'HProps.skBroomQudditchMesh'

    CollisionRadius=45.00

    CollisionWidth=10.00

    CollisionHeight=5.00

    CollideType=2

    bBlockPlayers=False

    bBlockCamera=False

}