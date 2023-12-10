//================================================================================
// ResolveHPointTies.
//================================================================================

class ResolveHPointTies extends Trigger;

function Activate (Actor Other, Pawn Instigator)
{
  local harry PlayerHarry;
  local StatusGroupHousePoints sgHousePts;
  local CeremonySTextures CeremonyObj;

  PlayerHarry = harry(Level.PlayerHarryActor);
  sgHousePts = StatusGroupHousePoints(PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints'));
  sgHousePts.ResolveTies();
  foreach AllActors(Class'CeremonySTextures',CeremonyObj)
  {
    CeremonyObj.EnsureTexturesInitialized();
  }
}

defaultproperties
{
    ReTriggerDelay=5.00

}
