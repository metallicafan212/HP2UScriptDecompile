//================================================================================
// hideTrigger.
//================================================================================

class hideTrigger extends Trigger;

var(Trigger) bool bUnHide;

event Trigger (Actor Other, Pawn EventInstigator)
{
  local Actor A;

  if ( ReTriggerDelay > 0 )
  {
    if ( Level.TimeSeconds - TriggerTime < ReTriggerDelay )
    {
      return;
    }
    TriggerTime = Level.TimeSeconds;
  }
  if ( Event != 'None' )
  {
    foreach AllActors(Class'Actor',A,Event)
    {
      A.bHidden =  !bUnHide;
      A.SetCollision(,, !A.bHidden);
    }
  }
  if ( Other.IsA('Pawn') && (Pawn(Other).SpecialGoal == self) )
  {
    Pawn(Other).SpecialGoal = None;
  }
  if ( Message != "" )
  {
    Other.Instigator.ClientMessage(Message);
  }
  if ( bTriggerOnceOnly )
  {
    SetCollision(False);
  } else //{
    if ( RepeatTriggerTime > 0 )
    {
      SetTimer(RepeatTriggerTime,False);
    }
  //}
}

function Touch (Actor Other)
{
  local Actor A;

  if ( IsRelevant(Other) )
  {
    if ( ReTriggerDelay > 0 )
    {
      if ( Level.TimeSeconds - TriggerTime < ReTriggerDelay )
      {
        return;
      }
      TriggerTime = Level.TimeSeconds;
    }
    if ( Event != 'None' )
    {
      foreach AllActors(Class'Actor',A,Event)
      {
        A.bHidden =  !bUnHide;
        A.SetCollision(,, !A.bHidden);
      }
    }
    if ( Other.IsA('Pawn') && (Pawn(Other).SpecialGoal == self) )
    {
      Pawn(Other).SpecialGoal = None;
    }
    if ( Message != "" )
    {
      Other.Instigator.ClientMessage(Message);
    }
    if ( bTriggerOnceOnly )
    {
      SetCollision(False);
    } else //{
      if ( RepeatTriggerTime > 0 )
      {
        SetTimer(RepeatTriggerTime,False);
      }
    //}
  }
}

