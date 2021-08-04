//================================================================================
// TriggerChangeActorMesh.
//================================================================================

class TriggerChangeActorMesh extends Trigger;

var() Mesh NewMesh;
var() Animation NewSkelAnim;
var() name AnimToPlay;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger();
}

function Touch (Actor Other)
{
  Super.Touch(Other);
  ProcessTrigger();
}

function ProcessTrigger()
{
  local Actor A;

  foreach AllActors(Class'Actor',A,Event)
  {
    // goto JL0019;
	break;
  }
  if ( A == None )
  {
    Log("TriggerChangeActorMesh: Couldn't find actor to change mesh");
    return;
  }
  if ( NewMesh != None )
  {
    A.Mesh = NewMesh;
  }
  if ( NewSkelAnim != None )
  {
    A.SkelAnim = NewSkelAnim;
  }
  if ( (NewMesh != None) && (AnimToPlay != 'None') )
  {
    LoopAnim(AnimToPlay);
  }
}

