//================================================================================
// ChristaTrigger1.
//================================================================================

class ChristaTrigger1 extends Trigger;

var() name MatchingMoversObjectName;

function bool IsRelevant (Actor Other)
{
  if ( (harry(Other) != None) || (Other.Name == MatchingMoversObjectName) )
  {
    return True;
  } else {
    return False;
  }
}

function Activate (Actor Other, Pawn Instigator)
{
  local CutScene A;

  cm("***** Other.name=" $ string(Other.Name));
  if ( Other.Name == MatchingMoversObjectName )
  {
    foreach AllActors(Class'CutScene',A,Event)
    {
      cm("***** Found cutscene=" $ string(A.Name));
      A.bPlayOnce = True;
      A.nPlayedCount = 0;
    }
  }
  Super.Activate(Other,Instigator);
}

