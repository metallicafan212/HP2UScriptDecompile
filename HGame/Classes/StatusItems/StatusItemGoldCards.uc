//================================================================================
// StatusItemGoldCards.
//================================================================================

class StatusItemGoldCards extends StatusItemWizardCards;

function MoveHarryCardToEnd ()
{
  local int I;
  local int nHarryCardId;

  nHarryCardId = GetHarryCardId();
  
  /*
  I = 0;
  if ( I < nMaxCount )
  {
    if ( WizardCards[I].nId == nHarryCardId )
    {
      MoveCardToEnd(I);
    }
    I++;
    goto JL0013;
  }
  */
  
	for(i = 0; i < nMaxCount; i++)
	{
		if(WizardCards[i].nID == nHarryCardID)
		{
			MoveCardToEnd(I);
		}
	}
}

function bool HaveHarryCard ()
{
  local int I;
  local int nHarryCardId;

  nHarryCardId = GetHarryCardId();
  
  /*
  I = 0;
  if ( I < nMaxCount )
  {
    if ( WizardCards[I].nId == nHarryCardId )
    {
      return True;
    }
    I++;
    goto JL0013;
  }
  */
  
	for(i = 0; i < nMaxCount; i++)
	{
		if(WizardCards[i].nID == nHarryCardID)
		{
			return true;
		}
	}
  
  return False;
}

function int GetHarryCardId ()
{
  local Class<Actor> classWC;

  classWC = Class'WCPotter';
  return Class<WizardCardIcon>(classWC).Default.Id;
}

defaultproperties
{
    nMaxCount=11

}