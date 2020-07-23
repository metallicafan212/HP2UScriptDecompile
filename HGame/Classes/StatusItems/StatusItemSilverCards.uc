//================================================================================
// StatusItemSilverCards.
//================================================================================

class StatusItemSilverCards extends StatusItemWizardCards;

function UpdateCount ()
{
  local int nOldCount;

  nOldCount = nCount;
  Super.UpdateCount();
  if ( nOldCount != nCount )
  {
    switch (nCount)
    {
      case 10:
      sgParent.smParent.GetStatusGroup(Class'StatusGroupLocks').IncrementCount(Class'StatusItemLock1',1);
      break;
      case 20:
      sgParent.smParent.GetStatusGroup(Class'StatusGroupLocks').IncrementCount(Class'StatusItemLock2',1);
      break;
      case 30:
      sgParent.smParent.GetStatusGroup(Class'StatusGroupLocks').IncrementCount(Class'StatusItemLock3',1);
      break;
      case 40:
      sgParent.smParent.GetStatusGroup(Class'StatusGroupLocks').IncrementCount(Class'StatusItemLock4',1);
      break;
      default:
    }
  } 
  else 
  {
  }
}

defaultproperties
{
    nMaxCount=40

}