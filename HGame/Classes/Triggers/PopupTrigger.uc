//================================================================================
// PopupTrigger.
//================================================================================

class PopupTrigger extends Trigger;

var(popup) string dialogID;
var(popup) bool bPlayDialogSound;
var(popup) float fPopupDuration;
var(popup) bool bDoNothingIfHarryCaptured;

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
    DeliverLocalizedDialog(dialogID,bPlayDialogSound,fPopupDuration);
  }
}

defaultproperties
{
    bPlayDialogSound=True

    bDoNothingIfHarryCaptured=True

    bTriggerOnceOnly=True

}
