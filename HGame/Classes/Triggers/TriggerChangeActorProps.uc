//================================================================================
// TriggerChangeActorProps.
//================================================================================

class TriggerChangeActorProps extends Trigger;

var() int iNewColActors;
var() int iNewBlockActors;
var() int iNewBlockPlayers;

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
  local bool bNewColActors;
  local bool bNewBlockActors;
  local bool bNewBlockPlayers;

  foreach AllActors(Class'Actor',A,Event)
  {
    if ( (iNewColActors != 0) || (iNewBlockActors != 0) || (iNewBlockPlayers != 0) )
    {
      if ( iNewColActors == 1 )
      {
        bNewColActors = True;
      } else //{
        if ( iNewColActors == -1 )
        {
          bNewColActors = False;
        } else {
          bNewColActors = A.bCollideActors;
        }
      //}
      if ( iNewBlockActors == 1 )
      {
        bNewBlockActors = True;
      } else //{
        if ( iNewBlockActors == -1 )
        {
          bNewBlockActors = False;
        } else {
          bNewBlockActors = A.bBlockActors;
        }
     // }
      if ( iNewBlockPlayers == 1 )
      {
        bNewBlockPlayers = True;
      } else //{
        if ( iNewBlockPlayers == -1 )
        {
          bNewBlockPlayers = False;
        } else {
          bNewBlockPlayers = A.bBlockPlayers;
        }
      //}
      A.SetCollision(bNewColActors,bNewBlockActors,bNewBlockPlayers);
    }
  }
}

