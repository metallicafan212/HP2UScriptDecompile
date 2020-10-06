//================================================================================
// Goldcards.
//================================================================================

class Goldcards extends WizardCardIcon
  Abstract;

defaultproperties
{
    bPickupSendsEvent=True

    soundPickup=Sound'HPSounds.Magic_sfx.pickup_WC_gold'

    bPickupOnTouch=True

    //PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupWizardCards'

    classStatusItem=Class'StatusItemGoldCards'
}
