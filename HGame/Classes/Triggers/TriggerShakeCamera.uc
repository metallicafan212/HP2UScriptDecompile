//================================================================================
// TriggerShakeCamera.
//================================================================================

class TriggerShakeCamera extends Triggers;

var() float fShakeTime;
var() float fRollMagnitude;
var() float fVertMagnitude;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger();
}

function ProcessTrigger()
{
  harry(Level.PlayerHarryActor).ShakeView(fShakeTime,fRollMagnitude,fVertMagnitude);
}

defaultproperties
{
    fShakeTime=2.00

    fRollMagnitude=100.00

    fVertMagnitude=100.00

}
