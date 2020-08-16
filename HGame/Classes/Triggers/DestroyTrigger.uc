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
    // I = 0;
    // if ( I < 8 )
	for(I = 0; I < 8; I++)
    {
      if ( Events[I] != 'None' )
      {
        foreach AllActors(Class'Actor',A,Events[I])
        {
          A.Destroy();
        }
      }
      // I++;
      // goto JL0010;
    }
  }
}

function PassThru (Actor Other)
{
  local Actor A;
  local int I;

  // I = 0;
  // if ( I < 8 )
  for(I = 0; I < 8; I++)
  {
    if ( Events[I] != 'None' )
    {
      foreach AllActors(Class'Actor',A,Events[I])
      {
        A.Destroy();
      }
    }
    // I++;
    // goto JL0007;
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
    // I = 0;
    // if ( I < 8 )
	for(I = 0; I < 8; I++)
    {
      if ( Events[I] != 'None' )
      {
        foreach AllActors(Class'Actor',A,Events[I])
        {
          A.Destroy();
        }
      }
      // I++;
      // goto JL0015;
    }
    Destroy();
  }
}

