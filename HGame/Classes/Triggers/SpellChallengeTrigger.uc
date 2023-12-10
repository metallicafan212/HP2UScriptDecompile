//================================================================================
// SpellChallengeTrigger.
//================================================================================

class SpellChallengeTrigger extends Trigger;

var(SpellChallenge) int nChallengeId;
var(SpellChallenge) int nMaxHousePoints;
var(SpellChallenge) int nMaxScore;

function Activate (Actor Other, Pawn Instigator)
{
  local harry PlayerHarry;
  local ChallengeScoreManager managerChallenge;

  foreach AllActors(Class'harry',PlayerHarry)
  {
    if ( PlayerHarry.bIsPlayer && (PlayerHarry != self) )
    {
      // goto JL0033;
	  break;
    }
  }
  foreach AllActors(Class'ChallengeScoreManager',managerChallenge)
  {
    // goto JL0048;
	break;
  }
  managerChallenge.BeginChallenge();
}

defaultproperties
{
    bTriggerOnceOnly=True

    bHidden=False

}
