//================================================================================
// StatusItemWizardCards.
//================================================================================

class StatusItemWizardCards extends StatusItem
  Abstract;

const MAX_CARDS = 50;

enum ECardOwner 
{
	CardOwner_None,
	CardOwner_Harry,
	CardOwner_Vendor
};


struct TCardData
{
	var int nId;
	var ECardOwner Owner;
};

var TCardData WizardCards[MAX_CARDS];





function ECardOwner GetCardOwner (int nId)
{
  local int I;

  if ( nId == 0 )
  {
    sgParent.smParent.PlayerHarry.ClientMessage("ERROR in GetCardOwner- 0 is an invalid card id");
    return CardOwner_None;
  }
  
  /*
  I = 0;
  if ( I < 50 )
  {
    if ( WizardCards[I].nId == nId )
    {
      return WizardCards[I].Owner;
    }
    I++;
    goto JL0066;
  }
  */
  
	for(i = 0; i < MAX_CARDS; i++)
	{
		if(WizardCards[i].nID == nID)
		{
			return WizardCards[i].Owner;
		}
	}
  
  return CardOwner_None;
}

function bool IsOwnedByHarry (int nId)
{
  return GetCardOwner(nId) == CardOwner_Harry;
}

function bool IsOwnedByVendor (int nId)
{
  return GetCardOwner(nId) == CardOwner_Vendor;
}

function bool IsOwnedByNone (int nId)
{
  return GetCardOwner(nId) == CardOwner_None;
}

function SetCardOwner (int nId, ECardOwner Owner)
{
  local int I;

  if ( nId == 0 )
  {
    sgParent.smParent.PlayerHarry.ClientMessage("ERROR in GetCardOwner- 0 is an invalid card id");
    return;
  }
  
  /*
  I = 0;
  if ( I < 50 )
  {
    if ( WizardCards[I].nId == nId )
    {
      WizardCards[I].Owner = Owner;
      if ( bool(Owner) == bool(1) )
      {
        MoveCardToEnd(I);
      }
      goto JL010F;
    } else {
      if ( WizardCards[I].nId == 0 )
      {
        WizardCards[I].nId = nId;
        WizardCards[I].Owner = Owner;
      } else {
        I++;
        goto JL0065;
      }
    }
  }
  if ( bool(Owner) == bool(1) )
  {
    StatusGroupWizardCards(sgParent).SetLastObtainedCardItem(self);
  }
  UpdateCount();
  */
  
	for(i = 0; i < MAX_CARDS; i++)
	{
		if(WizardCards[i].nId == nID)
		{
			WizardCards[i].Owner = Owner;
			if(Owner == CardOwner_Harry)
			{
				MoveCardToEnd(i);
			}
			break;
		}
		else if(WizardCards[i].nID == 0)
		{
			WizardCards[i].nID 		= nId;
			WizardCards[i].Owner	= Owner;
			break;
		}
	}
  
	if(Owner == CardOwner_Harry)
	{
		StatusGroupWizardCards(sgParent).SetLastObtainedCardItem(self);
	}
	
	UpdateCount();
	
}

function MoveCardToEnd (int nStartIdx)
{
  local int I;
  local int nMovedCardId;
  local ECardOwner MovedCardOwner;

  nMovedCardId 		= WizardCards[nStartIdx].nId;
  MovedCardOwner 	= WizardCards[nStartIdx].Owner;
  
  /*
  I = nStartIdx + 1;
  if ( I < 50 )
  {
    if ( WizardCards[I].nId > 0 )
    {
      WizardCards[I - 1].nId = WizardCards[I].nId;
      WizardCards[I - 1].Owner = WizardCards[I].Owner;
    } else {
      goto JL00B4;
    }
    I++;
    goto JL003A;
  }
  --I;
  WizardCards[I].nId = nMovedCardId;
  WizardCards[I].Owner = MovedCardOwner;
  */
  
	for(i = nStartIdx + 1; i < MAX_CARDS; i++)
	{
		if(WizardCards[i].nID > 0)
		{
			WizardCards[i - 1].nID 		= WizardCards[i].nID;
			WizardCards[i - 1].Owner	= WizardCards[i].Owner;
		}
		else
		{
			break;
		}
	}
	
	i--;
	WizardCards[i].nID 		= nMovedCardId;
	WizardCards[i].Owner	= MovedCardOwner;
  
}

function UpdateCount()
{
  local int I;

  nCount = 0;
  
  /*
  I = 0;
  if ( I < 50 )
  {
    if ( WizardCards[I].nId == 0 )
    {
      return;
    } else {
      if ( bool(WizardCards[I].Owner) == bool(1) )
      {
        ++nCount;
      }
    }
    I++;
    goto JL000E;
  }
  */
  
	for(i = 0; i < MAX_CARDS; i++)
	{
		if(WizardCards[i].nID == 0)
		{
			return;
		}
		else if(WizardCards[i].Owner == CardOwner_Harry)
		{
			++nCount;
		}
	}
  
}

function bool GetFirstVendorCardId (out int nCardId)
{
  local int I;

  /*
  I = 0;
  
  if ( I < 50 )
  {
    if ( WizardCards[I].nId == 0 )
    {
      nCardId = 0;
      return False;
    }
    if ( bool(WizardCards[I].Owner) == bool(2) )
    {
      nCardId = WizardCards[I].nId;
      return True;
    }
    I++;
    goto JL0007;
  }
  */
  
	for(i = 0; i < MAX_CARDS; i++)
	{
		if(WizardCards[i].Owner == CardOwner_None)
		{
			nCardID = 0;
			return false;
		}
		
		if(WizardCards[i].Owner == CardOwner_Vendor)
		{
			nCardID = WizardCards[i].nID;
			return true;
		}
	}
  
	nCardId = 0;
	return False;
}

function bool GetFirstVendorCardIdAndClass (out int nCardId, out Class<Actor> classWC)
{
	if (!GetFirstVendorCardId(nCardId) )
	{
		return False;
	}
	classWC = GetCardClassFromId(nCardId);
	return classWC != None;
}

function Class<Actor> GetCardClassFromId (int nCardId)
{
  local Class<Actor> classWC;

  switch (nCardId)
  {
    case 1:
    classWC = Class'WCMerlin';
    break;
    case 2:
    classWC = Class'WCAgrippa';
    break;
    case 3:
    classWC = Class'WCClagg';
    break;
    case 4:
    classWC = Class'WCStump';
    break;
    case 5:
    classWC = Class'WCPokeby';
    break;
    case 6:
    classWC = Class'WCPeakes';
    break;
    case 7:
    classWC = Class'WCStarkey';
    break;
    case 8:
    classWC = Class'WCShimpling';
    break;
    case 9:
    classWC = Class'WCGunhilda';
    break;
    case 10:
    classWC = Class'WCMuldoon';
    break;
    case 11:
    classWC = Class'WCHerpo';
    break;
    case 12:
    classWC = Class'WCMerwyn';
    break;
    case 13:
    classWC = Class'WCAndros';
    break;
    case 14:
    classWC = Class'WCFulbert';
    break;
    case 15:
    classWC = Class'WCParacelsus';
    break;
    case 16:
    classWC = Class'WCCliodne';
    break;
    case 17:
    classWC = Class'WCFay';
    break;
    case 18:
    classWC = Class'WCUlric';
    break;
    case 19:
    classWC = Class'WCScamander';
    break;
    case 20:
    classWC = Class'WCWendelin';
    break;
    case 21:
    classWC = Class'WCWithers';
    break;
    case 22:
    classWC = Class'WCCirce';
    break;
    case 23:
    classWC = Class'WCChittock';
    break;
    case 24:
    classWC = Class'WCWaffling';
    break;
    case 25:
    classWC = Class'WCFancourt';
    break;
    case 26:
    classWC = Class'WCSawbridge';
    break;
    case 27:
    classWC = Class'WCPlunkett';
    break;
    case 28:
    classWC = Class'WCToke';
    break;
    case 29:
    classWC = Class'WCAlderton';
    break;
    case 30:
    classWC = Class'WCLufkin';
    break;
    case 31:
    classWC = Class'WCBlane';
    break;
    case 32:
    classWC = Class'WCWenlock';
    break;
    case 33:
    classWC = Class'WCMarjoribanks';
    break;
    case 34:
    classWC = Class'WCTremlett';
    break;
    case 35:
    classWC = Class'WCWright';
    break;
    case 36:
    classWC = Class'WCWadcock';
    break;
    case 37:
    classWC = Class'WCVablatsky';
    break;
    case 38:
    classWC = Class'WCOldridge';
    break;
    case 39:
    classWC = Class'WCJones';
    break;
    case 40:
    classWC = Class'WCPinkstone';
    break;
    case 41:
    classWC = Class'WCGriffindor';
    break;
    case 42:
    classWC = Class'WCCronk';
    break;
    case 43:
    classWC = Class'WCYoudle';
    break;
    case 44:
    classWC = Class'WCWhitehorn';
    break;
    case 45:
    classWC = Class'WCOglethorpe';
    break;
    case 46:
    classWC = Class'WCGoshawk';
    break;
    case 47:
    classWC = Class'WCStroulger';
    break;
    case 48:
    classWC = Class'WCSlytherin';
    break;
    case 49:
    classWC = Class'WCKetteridge';
    break;
    case 50:
    classWC = Class'WCBarkwith';
    break;
    case 51:
    classWC = Class'WCEthelred';
    break;
    case 52:
    classWC = Class'WCSummerbee';
    break;
    case 53:
    classWC = Class'WCCatchlove';
    break;
    case 54:
    classWC = Class'WCShingleton';
    break;
    case 55:
    classWC = Class'WCNutcombe';
    break;
    case 56:
    classWC = Class'WCCrumb';
    break;
    case 57:
    classWC = Class'WCOllerton';
    break;
    case 58:
    classWC = Class'WCHipworth';
    break;
    case 59:
    classWC = Class'WCGregory';
    break;
    case 60:
    classWC = Class'WCMontmorency';
    break;
    case 61:
    classWC = Class'WCSweeting';
    break;
    case 62:
    classWC = Class'WCWildsmith';
    break;
    case 63:
    classWC = Class'WCWintringham';
    break;
    case 64:
    classWC = Class'WCSykes';
    break;
    case 65:
    classWC = Class'WCOliphant';
    break;
    case 66:
    classWC = Class'WCBelby';
    break;
    case 67:
    classWC = Class'WCPilliwickle';
    break;
    case 68:
    classWC = Class'WCDuke';
    break;
    case 69:
    classWC = Class'WCBott';
    break;
    case 70:
    classWC = Class'WCSmethwyck';
    break;
    case 71:
    classWC = Class'WCMaeve';
    break;
    case 72:
    classWC = Class'WCHufflepuff';
    break;
    case 73:
    classWC = Class'WCMopsus';
    break;
    case 74:
    classWC = Class'WCKnightley';
    break;
    case 75:
    classWC = Class'WCBonham';
    break;
    case 76:
    classWC = Class'WCWagtail';
    break;
    case 77:
    classWC = Class'WCTwonk';
    break;
    case 78:
    classWC = Class'WCThruston';
    break;
    case 79:
    classWC = Class'WCBeamish';
    break;
    case 80:
    classWC = Class'WCBloxam';
    break;
    case 81:
    classWC = Class'WCPo';
    break;
    case 82:
    classWC = Class'WCRavenclaw';
    break;
    case 83:
    classWC = Class'WCPlumpton';
    break;
    case 84:
    classWC = Class'WCKegg';
    break;
    case 85:
    classWC = Class'WCStalk';
    break;
    case 86:
    classWC = Class'WCWellbeloved';
    break;
    case 87:
    classWC = Class'WCThurkell';
    break;
    case 88:
    classWC = Class'WCWarbeck';
    break;
    case 89:
    classWC = Class'WCToothill';
    break;
    case 90:
    classWC = Class'WCTugwood';
    break;
    case 91:
    classWC = Class'WCElphick';
    break;
    case 92:
    classWC = Class'WCRastrick';
    break;
    case 93:
    classWC = Class'WCBarbary';
    break;
    case 94:
    classWC = Class'WCGraves';
    break;
    case 95:
    classWC = Class'WCPlatt';
    break;
    case 96:
    classWC = Class'WCWoodcroft';
    break;
    case 97:
    classWC = Class'WCGrunnion';
    break;
    case 98:
    classWC = Class'WCFurmage';
    break;
    case 99:
    classWC = Class'WCDodderidge';
    break;
    case 100:
    classWC = Class'WCPotter';
    break;
    case 101:
    classWC = Class'WCDumbledore';
    break;
    default:
    break;
  }
	if ( VerifyCardClass(nCardId,classWC) )
	{
		return classWC;
	} 
	else 
	{
		return None;
	}
}

function bool VerifyCardClass (int nCardId, Class<Actor> classWC)
{
	if ( ClassIsChildOf(classWC,Class'WizardCardIcon') )
	{
		if ( Class<WizardCardIcon>(classWC).Default.Id == nCardId )
		{
			return True;
		} 
		else 
		{
			sgParent.smParent.PlayerHarry.ClientMessage("ERROR in wizard card id" $ string(nCardId) $ " <> " $ string(Class<WizardCardIcon>(classWC).Default.Id));
			return False;
		}
	} 
	else 
	{
		sgParent.smParent.PlayerHarry.ClientMessage("ERROR in VerifyCardClass- class is not WizardCardIcon " $ string(nCardId) $ " " $ string(classWC));
		return False;
	}
}

function GetCardData (int nIdx, out int nId, out int nOwner)
{
	  if ( (nIdx >= 0) && (nIdx < 50) )
	  {
			nId 	= WizardCards[nIdx].nId;
			nOwner 	= WizardCards[nIdx].Owner;
	  } 
	  else 
	  {
			sgParent.smParent.PlayerHarry.ClientMessage("ERROR: Invalid WizardCards index in GetCardData");
			nId = 0;
			nOwner = 0;
	  }
}

function int GetCardId (int nIdx)
{
	  local int nId;
	  local int nOwner;

	  GetCardData(nIdx,nId,nOwner);
	  return nId;
}

function SetCardData (int nIdx, int nId, int nOwner)
{
	  if ( (nIdx >= 0) && (nIdx < 50) )
	  {
			WizardCards[nIdx].nId = nId;
			if ( nOwner == 0 )
			{
				WizardCards[nIdx].Owner = CardOwner_None;
			} 
			else 
			{
				  if ( nOwner == 1 )
				  {
						WizardCards[nIdx].Owner = CardOwner_Harry;
				  } 
				  else 
				  {
						if ( nOwner == 2 )
						{
							WizardCards[nIdx].Owner = CardOwner_Vendor;
						} 
						else 
						{
							sgParent.smParent.PlayerHarry.ClientMessage("ERROR: Invalid owner in SetCardData");
						}
				  }
			}
	  } 
	  else 
	  {
			sgParent.smParent.PlayerHarry.ClientMessage("ERROR: Invalid WizardCards index in SetCardData");
	  }
}

function ShowCardData()
{
	local int I;

	sgParent.smParent.PlayerHarry.ClientMessage("WizardCards: " $ string(Class));
	
	/*
	I = 0;
	if ( I < 50 )
	{
		if ( WizardCards[I].nId == 0 )
		{
			goto JL00C7;
		}
		sgParent.smParent.PlayerHarry.ClientMessage("ID: " $ string(WizardCards[I].nId) $ " Owner: " $ string(WizardCards[I].Owner));
		I++;
		goto JL003F;
	}
	*/
	
	for(i = 0; i < MAX_CARDS; i++)
	{
		if(WizardCards[i].nID == 0)
		{
			break;
		}
		
		sgParent.smParent.PlayerHarry.ClientMessage("ID: " $ string(WizardCards[I].nId) $ " Owner: " $ string(WizardCards[I].Owner));
	}
	
}

defaultproperties
{
    strHudIcon="HP2_Menu.Icons.HP2CardFolio"

    nActualIconW=52

    nActualIconH=64

    strToolTipId="InGameMenu_0021"

}