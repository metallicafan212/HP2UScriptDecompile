//================================================================================
// PuzzleTrigger.
//================================================================================

class PuzzleTrigger extends Trigger;

var(Puzzle) int KeyFrames[8];
var(Puzzle) name Tags[8];
var(Puzzle) name PuzzleName;
var float fWaitTime;
var float fCurrTime;
var bool bIsOpen;
var int Pieces;

function PostBeginPlay()
{
  local ElevatorMover EM;
  local int Count;

  Super.PostBeginPlay();
  if ( PuzzleName == 'None' )
  {
    Pieces = 0;
    return;
  }
  Count = 0;
  foreach AllActors(Class'ElevatorMover',EM)
  {
    if ( EM.PuzzleName == PuzzleName )
    {
      Count++;
    }
  }
  Pieces = Count;
}

function MyOpenDoor()
{
  if (  !bIsOpen )
  {
    MyToggleDoor();
    bIsOpen = True;
  }
}

function MyCloseDoor()
{
  if ( bIsOpen )
  {
    MyToggleDoor();
    bIsOpen = False;
  }
}

function MyToggleDoor()
{
  local Trigger t;
  local Mover M;

  if ( Event != 'None' )
  {
    foreach AllActors(Class'Trigger',t,Event)
    {
      foreach AllActors(Class'Mover',M,t.Event)
      {
        t.TriggerEvent(t.Event,None,None);
      }
    }
  }
}

function Tick (float DeltaTime)
{
  local ElevatorMover EM;
  local int I;
  local int Test[16];
  local bool DoOpen;

  Super.Tick(DeltaTime);
  if ( Pieces == 0 )
  {
    return;
  }
  fCurrTime += DeltaTime;
  if ( fCurrTime < fWaitTime )
  {
    return;
  }
  fCurrTime = 0.0;
  for(I = 0; I < Pieces; I++) 
  {
    Test[I] = 0;
  }
  foreach AllActors(Class'ElevatorMover',EM)
  {
    if ( EM.PuzzleName == PuzzleName )
    {
	  for(I = 0; I < Pieces; I++)
      {
        if ( (EM.Tag != 'None') && (EM.Tag == Tags[I]) )
        {
		  break;
        }
      }
      if ( I < Pieces )
      {
        if ( EM.KeyNum == KeyFrames[I] )
        {
          Test[I] = 1;
        }
      }
    }
  }
  DoOpen = True;

  for(I = 0; I < Pieces; I++)
  {
    if ( Test[I] == 0 )
    {
      DoOpen = False;
    }
  }
  if ( DoOpen )
  {
    MyOpenDoor();
  } else {
    MyCloseDoor();
  }
}

defaultproperties
{
    fWaitTime=1.00

}
