//================================================================================
// HallwayRunBoss.
//================================================================================

class HallwayRunBoss extends baseBoss;

event Trigger (Actor Other, Pawn EventInstigator)
{
  PlayerHarry.StopBossEncounter();
}

