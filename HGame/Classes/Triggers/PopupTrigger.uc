//================================================================================
// PopupTrigger.
//================================================================================

class PopupTrigger extends Trigger;

var(popup) string dialogID;
var(popup) bool bPlayDialogSound;
var(popup) float fPopupDuration;
var(popup) bool bDoNothingIfHarryCaptured;

// DivingDeep39: Omega: Added to enable users to do M212Say style localized audio in other packages
var(popupM212) string LocalizationFile;
var(popupM212) string Package;
var(popupM212) string Section;

function Trigger (Actor Other, Pawn EventInstigator)
{
  Activate(Other,EventInstigator);
}

function Activate (Actor Other, Pawn Instigator)
{
  if ( bDoNothingIfHarryCaptured && harry(Level.PlayerHarryActor).bIsCaptured )
  {
    return;
  }
  if ( dialogID != "" )
  {
    // DivingDeep39: Replaced the og function with the new one containing the new vars
	//DeliverLocalizedDialog(dialogID,bPlayDialogSound,fPopupDuration);
	DeliverLocalizedDialog(dialogID,bPlayDialogSound,fPopupDuration,LocalizationFile,Section,Package);
  }
}

defaultproperties
{
    bPlayDialogSound=True

    bDoNothingIfHarryCaptured=True

    bTriggerOnceOnly=True
	
	// DivingDeep39: Defaults for new vars
	LocalizationFile="HPDialog"
	
	Package="AllDialog"
	
	Section="All"
}
