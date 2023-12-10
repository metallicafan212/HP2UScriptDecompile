//================================================================================
// BossEncounterTrigger.
//================================================================================

class BossEncounterTrigger extends Trigger;

var() bool bHarryShouldLockOntoBoss;
var() bool bReverseInput;
var() bool bKeepHarryFixed;
var() bool bCanCast;
var() ESpellType ForceSpellType;
var() bool bFixedFaceDirection;
var() bool bDontNeedABoss;
var() bool bExtendedTargetting;
var() bool bSendTriggerToBoss;
var() bool bDontShowBossMeter;
var bool bDisabled;

function Trigger (Actor Other, Pawn EventInstigator)
{
  DoTrigger(Other,EventInstigator);
}

function DoTrigger (Actor Other, Pawn EventInstigator)
{
  local baseBoss Boss;

  Log("******** BossEncounterTrigger");
  if (  !bDisabled )
  {
    ProcessTrigger();
    Super.Touch(Other);
    if ( bSendTriggerToBoss )
    {
      foreach AllActors(Class'baseBoss',Boss,Event)
      {
        Log("******** BossEncounterTrigger sent trigger '" $ string(Event) $ "' to boss:" $ string(Boss));
        Boss.Trigger(None,None);
      }
    }
  }
}

function Touch (Actor Other)
{
  if ( harry(Other) == None )
  {
    return;
  }
  if (  !bDisabled )
  {
    Super.Touch(Other);
    Log("******** boss encounter touch");
    ProcessTrigger();
  }
}

function ProcessTrigger()
{
  local harry H;
  local baseBoss Boss;
  local Vector vFixedFaceDirection;

  bDisabled = True;
  if ( bFixedFaceDirection )
  {
    vFixedFaceDirection = vector(Rotation);
  } else {
    vFixedFaceDirection = vect(0.00,0.00,0.00);
  }
  foreach AllActors(Class'baseBoss',Boss,Event)
  {
    // goto JL004C;
	break;
  }
  Log("Found Boss:" $ string(Boss));
  if ( (Boss != None) || bDontNeedABoss )
  {
    foreach AllActors(Class'harry',H)
    {
      H.StartBossEncounter(Boss,bHarryShouldLockOntoBoss,bReverseInput,bKeepHarryFixed,bCanCast,vFixedFaceDirection,ForceSpellType,bExtendedTargetting,bDontShowBossMeter);
      // goto JL00D0;
	  break;
    }
  } else {
    Log("BossEncounterTrigger : Couldn't find boss to have encounter with");
  }
}

defaultproperties
{
    bHarryShouldLockOntoBoss=True

    bSendTriggerToBoss=True

    InitialState=None

    bDirectional=True

}
