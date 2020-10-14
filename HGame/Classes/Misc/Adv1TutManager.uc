//================================================================================
// Adv1TutManager.
//================================================================================

class Adv1TutManager extends Director;

var() float LookAtRonConeAngle;
var() name Event_HarrySeesRon;
var() name Event_PushForward;
var() name Event_PushBackward;
var() name Event_PushStrafeLeft;
var() name Event_PushStrafeRight;
var Ron Ron;
var harry PlayerHarry;
var bool bTriggerReceived;
var bool bConditionMet;

function PostBeginPlay ()
{
  foreach AllActors(Class'Ron',Ron)
  {
    // goto JL0014;
	break;
  }
  foreach AllActors(Class'harry',PlayerHarry)
  {
    PlayerHarry.Adv1TutManager = self;
    // goto JL0039;
	break;
  }
}

function ForwardPushed ()
{
}

function BackwardPushed ()
{
}

function StrafeLeftPushed ()
{
}

function StrafeRightPushed ()
{
}

auto state stateStart
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    PlayerHarry.ClientMessage("**** Trigger, wait for look at ron");
    GotoState('stateWaitForHarryLookAtRon');
  }
  
}

state stateWaitForHarryLookAtRon
{
begin:
	
  do
  {
	  if ( Normal(Ron.Location - PlayerHarry.Cam.Location) Dot vector(PlayerHarry.Cam.Rotation) > Cos(LookAtRonConeAngle * 2 * 3.14159989 / 360) )
	  {
		PlayerHarry.ClientMessage("**** See Ron");
		break;
	  } //else {
		Sleep(0.1);
		//if (! False ) goto JL0000;
	  //}
  }
  until(false);
  
  TriggerEvent(Event_HarrySeesRon,self,PlayerHarry);
  GotoState('stateWaitForHarryMoveForward');
}

state stateWaitForHarryMoveForward
{
  function BeginState ()
  {
    bTriggerReceived = False;
    bConditionMet = False;
  }
  
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    PlayerHarry.ClientMessage("*** waitforharrymoveforward trigger");
    bTriggerReceived = True;
    PlayerHarry.bLockOutForward = False;
  }
  
  function ForwardPushed ()
  {
    PlayerHarry.ClientMessage("*** pushforward");
    if ( bTriggerReceived )
    {
      bConditionMet = True;
    }
  }
  
 begin:
 
  do
  {
	Sleep(0.1);
  }
  until(bConditionMet);
  //if (! bConditionMet ) goto JL0000;
  
  Sleep(0.5);
  PlayerHarry.bLockOutForward = True;
  TriggerEvent(Event_PushForward,self,PlayerHarry);
  GotoState('stateWaitForHarryMoveBackward');
}

state stateWaitForHarryMoveBackward
{
  function BeginState ()
  {
    bTriggerReceived = False;
    bConditionMet = False;
  }
  
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    bTriggerReceived = True;
    PlayerHarry.bLockOutBackward = False;
  }
  
  function BackwardPushed ()
  {
    if ( bTriggerReceived )
    {
      bConditionMet = True;
    }
  }
  
 begin:
 
  do
  {
	Sleep(0.1);
  }
  until(bConditionMet);
  //if (! bConditionMet ) goto JL0000;
  
  Sleep(0.5);
  PlayerHarry.bLockOutBackward = True;
  TriggerEvent(Event_PushBackward,self,PlayerHarry);
  GotoState('stateWaitForHarryStrafeLeft');
}

state stateWaitForHarryStrafeLeft
{
  function BeginState ()
  {
    bTriggerReceived = False;
    bConditionMet = False;
  }
  
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    bTriggerReceived = True;
    PlayerHarry.bLockOutStrafeLeft = False;
  }
  
  function StrafeLeftPushed ()
  {
    if ( bTriggerReceived )
    {
      bConditionMet = True;
    } else {
      PlayerHarry.ClientMessage("Trigger not received yet");
    }
  }
  
 begin:
 
  do
  {
	Sleep(0.1);
  }
  until(bConditionMet);
  //if (! bConditionMet ) goto JL0000;
  
  Sleep(0.5);
  PlayerHarry.bLockOutStrafeLeft = True;
  TriggerEvent(Event_PushStrafeLeft,self,PlayerHarry);
  GotoState('stateWaitForHarryStrafeRight');
}

state stateWaitForHarryStrafeRight
{
  function BeginState ()
  {
    bTriggerReceived = False;
    bConditionMet = False;
  }
  
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    bTriggerReceived = True;
    PlayerHarry.bLockOutStrafeRight = False;
  }
  
  function StrafeRightPushed ()
  {
    if ( bTriggerReceived )
    {
      bConditionMet = True;
    }
  }
  
 begin:
  
  do
  {
	Sleep(0.1);
  }
  until(bConditionMet);
  //if (! bConditionMet ) goto JL0000;
  
  Sleep(0.5);
  PlayerHarry.bLockOutStrafeRight = True;
  TriggerEvent(Event_PushStrafeRight,self,PlayerHarry);
  GotoState('stateKeepHarryLocked');
}

state stateKeepHarryLocked
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    PlayerHarry.bLockOutForward = False;
    PlayerHarry.bLockOutBackward = False;
    PlayerHarry.bLockOutStrafeLeft = False;
    PlayerHarry.bLockOutStrafeRight = False;
    GotoState('stateDone1');
  }
  
}

state stateDone1
{
}

defaultproperties
{
    LookAtRonConeAngle=10.00

}
