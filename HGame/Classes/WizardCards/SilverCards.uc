//================================================================================
// SilverCards.
//================================================================================

class SilverCards extends WizardCardIcon
  Abstract;

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup_WC_silver'

    bPickupOnTouch=True

    //PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupWizardCards'

    classStatusItem=Class'StatusItemSilverCards'
}
