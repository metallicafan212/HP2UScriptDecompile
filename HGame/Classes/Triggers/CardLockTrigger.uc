//================================================================================
// CardLockTrigger.
//================================================================================

class CardLockTrigger extends Trigger;

var StatusGroupLocks sgLocks;
var StatusItemLock1 siLock1;
var StatusItemLock2 siLock2;
var StatusItemLock3 siLock3;
var StatusItemLock4 siLock4;
var() name nameLock1Event;
var() name nameLock2Event;
var() name nameLock3Event;
var() name nameLock4Event;
var() float fLock1WaitTime;
var() float fLock2WaitTime;
var() float fLock3WaitTime;
var() float fLock4WaitTime;

state NormalTrigger
{
  event Activate (Actor Other, Pawn EventInstigator)
  {
    Super.Activate(Other,EventInstigator);
    if ( Other != Level.PlayerHarryActor )
    {
      return;
    }
    GotoState('SendLockMessages');
  }
  begin:
}

state SendLockMessages
{
  function BeginState()
  {
    sgLocks = StatusGroupLocks(harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupLocks'));
    siLock1 = StatusItemLock1(sgLocks.GetStatusItem(Class'StatusItemLock1'));
    siLock2 = StatusItemLock2(sgLocks.GetStatusItem(Class'StatusItemLock2'));
    siLock3 = StatusItemLock3(sgLocks.GetStatusItem(Class'StatusItemLock3'));
    siLock4 = StatusItemLock4(sgLocks.GetStatusItem(Class'StatusItemLock4'));
  }
 begin:
  sgLocks.SetEffectTypeToPermanent();
  sgLocks.SetCutSceneRenderMode(True);
  if ( siLock1.nCount >= 1 )
  {
    TriggerEvent(nameLock1Event,None,None);
    nameLock1Event = 'None';
    Sleep(fLock1WaitTime / 2.0);
    siLock1.SetCount(0);
    Sleep(fLock1WaitTime / 2.0);
  }
  if ( siLock2.nCount >= 1 )
  {
    TriggerEvent(nameLock2Event,None,None);
    nameLock2Event = 'None';
    Sleep(fLock2WaitTime / 2.0);
    siLock2.SetCount(0);
    Sleep(fLock2WaitTime / 2.0);
  }
  if ( siLock3.nCount >= 1 )
  {
    TriggerEvent(nameLock3Event,None,None);
    nameLock3Event = 'None';
    Sleep(fLock3WaitTime / 2.0);
    siLock3.SetCount(0);
    Sleep(fLock3WaitTime / 2.0);
  }
  if ( siLock4.nCount >= 1 )
  {
    TriggerEvent(nameLock4Event,None,None);
    nameLock4Event = 'None';
    Sleep(fLock4WaitTime / 2.0);
    siLock4.SetCount(0);
  }
  sgLocks.SetCutSceneRenderModeToNormal();
  sgLocks.SetCutSceneRenderModeToNormal();
  GotoState('NormalTrigger');
}

defaultproperties
{
    nameLock1Event=CardLock1

    nameLock2Event=CardLock2

    nameLock3Event=CardLock3

    nameLock4Event=CardLock4

    fLock1WaitTime=1.00

    fLock2WaitTime=1.00

    fLock3WaitTime=1.00

    fLock4WaitTime=1.00

}
