//================================================================================
// DestroyTrigger.
//================================================================================

class DestroyTrigger extends Trigger;

var() name Events[8];
var() bool bActivatedByTrigger;

event Trigger (Actor Other, Pawn EventInstigator)
{
  local Actor A;
  local int I;

  if ( bActivatedByTrigger )
  {
	for(I = 0; I < 8; I++)
    {
      if ( Events[I] != 'None' )
      {
        foreach AllActors(Class'Actor',A,Events[I])
        {
          A.Destroy();
        }
      }
    }
  }
}

function PassThru (Actor Other)
{
  local Actor A;
  local int I;

  for(I = 0; I < 8; I++)
  {
    if ( Events[I] != 'None' )
    {
      foreach AllActors(Class'Actor',A,Events[I])
      {
        A.Destroy();
      }
    }
  }
  if ( Message != "" )
  {
    Other.Instigator.ClientMessage(Message);
  }
  Destroy();
}

function Touch (Actor Other)
{
  local Actor A;
  local int I;

  if ( IsRelevant(Other) )
  {
	for(I = 0; I < 8; I++)
    {
      if ( Events[I] != 'None' )
      {
        foreach AllActors(Class'Actor',A,Events[I])
        {
          A.Destroy();
        }
      }
    }
    Destroy();
  }
}

