//================================================================================
// StatusGroupWizardCards.
//================================================================================

class StatusGroupWizardCards extends StatusGroup;

enum ECardType 
{
	CardType_Bronze,
	CardType_Silver,
	CardType_Gold,
	CardType_None
};

var ECardType LastObtainedCardType;


const nSTART_Y= 4;
const nSTART_X= 416;
const nCARDTYPE_NONE= 3;
const nCARDTYPE_GOLD= 2;
const nCARDTYPE_SILVER= 1;
const nCARDTYPE_BRONZE= 0;

// DivingDeep39: Omega:
/*function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, Canvas.SizeX, Canvas.SizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}*/

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(nCanvasSizeX);
	nOutX 			= fScaleFactor * nSTART_X;
	nOutY 			= fScaleFactor * nSTART_Y;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local int nFinalX;
	local int nFinalY;
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(Canvas.SizeX);
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	nOutX 			= nFinalX;
	nOutY 			= -(nIconHeight * fScaleFactor);
}

function AssignAllSilverToVendors()
{
	local StatusItemWizardCards siWC;
	local int nCardId;
	local Class<Actor> classWC;

	siWC = StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards'));
	
	
	// Metallicafan212:	Obvious loop
	
	for(nCardId = 0; nCardId < smParent.nTOTAL_WIZARD_CARDS; nCardId++)
	{
		classWC = siWC.GetCardClassFromId(nCardId);
		if ( (classWC != None) && ClassIsChildOf(classWC,Class'SilverCards') )
		{
			smParent.PlayerHarry.ClientMessage("SilverCard " $ string(classWC) $ " " $ string(nCardId));
			if ( siWC.GetCardOwner(nCardId) != siWC.ECardOwner.CardOwner_Harry )
			{
				siWC.SetCardOwner(nCardId,	siWC.ECardOwner.CardOwner_Vendor);
			}
		}
	}
	
	/*
	nCardId = 0;
	if ( nCardId < 101 )
	{
		classWC = siWC.GetCardClassFromId(nCardId);
		if ( (classWC != None) && ClassIsChildOf(classWC,Class'SilverCards') )
		{
			smParent.PlayerHarry.ClientMessage("SilverCard " $ string(classWC) $ " " $ string(nCardId));
			if ( bool(siWC.GetCardOwner(nCardId)) != bool(siWC.1) )
			{
				siWC.SetCardOwner(nCardId,siWC.2);
			}
		}
		nCardId++;
		goto JL001D;
	}
	*/
}

function AssignVendorCards()
{
	local chestbronze Chest;
	local bronzecauldron Cauldron;
	local WizardCardIcon WCard;
	local int I;
	local StatusItemWizardCards siCards;

	foreach AllActors(Class'chestbronze',Chest)
	{
		for(I = 0; I < ArrayCount(Chest.EjectedObjects); I++)
		{
			if ( ClassIsChildOf(Chest.EjectedObjects[I],Class'WizardCardIcon') )
			{
				AssignVendorCardFromClass(Chest.EjectedObjects[I]);
			}
		}
		/*
		I = 0;
		if ( I < 8 )
		{
			if ( ClassIsChildOf(Chest.EjectedObjects[I],Class'WizardCardIcon') )
			{
				AssignVendorCardFromClass(Chest.EjectedObjects[I]);
			}
			I++;
			goto JL0017;
		}
		*/
	}
	foreach AllActors(Class'bronzecauldron',Cauldron)
	{
		for(I = 0; I < ArrayCount(Cauldron.EjectedObjects); I++)
		{
			if ( ClassIsChildOf(Cauldron.EjectedObjects[I],Class'WizardCardIcon') )
			{
				AssignVendorCardFromClass(Cauldron.EjectedObjects[I]);
			}
		}
		/*
		I = 0;
		if ( I < 3 )
		{
			if ( ClassIsChildOf(Cauldron.EjectedObjects[I],Class'WizardCardIcon') )
			{
				AssignVendorCardFromClass(Cauldron.EjectedObjects[I]);
			}
		I++;
		goto JL007F;
		}
		*/
	}
	foreach AllActors(Class'WizardCardIcon',WCard)
	{
		if ( WCard.bVendorsCanSell && HasCardGameStatePassed(WCard.strVendorOwnedAfterGState) )
		{
			if ( ClassIsChildOf(WCard.Class,Class'BronzeCards') )
			{
				siCards = StatusItemWizardCards(GetStatusItem(Class'StatusItemBronzeCards'));
			}
			if ( ClassIsChildOf(WCard.Class,Class'SilverCards') )
			{
				siCards = StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards'));
			}
			if ( ClassIsChildOf(WCard.Class,Class'Goldcards') )
			{
				siCards = StatusItemWizardCards(GetStatusItem(Class'StatusItemGoldCards'));
			}
			if ( siCards.GetCardOwner(WCard.Id) != siCards.ECardOwner.CardOwner_Harry )
			{
				siCards.SetCardOwner(WCard.Id, siCards.ECardOwner.CardOwner_Vendor);
			}
		}
	}
}

function AssignVendorCardFromClass (Class classObject)
{
	local Class<WizardCardIcon> classWC;
	local int nId;
	local bool bVendorsCanSell;
	local string strVendorOwnedAfterGState;
	local StatusItemWizardCards siCards;

	if ( ClassIsChildOf(classObject,Class'WizardCardIcon') )
	{
		classWC 					= Class<WizardCardIcon>(classObject);
		nId 						= classWC.Default.Id;
		bVendorsCanSell 			= classWC.Default.bVendorsCanSell;
		strVendorOwnedAfterGState 	= classWC.Default.strVendorOwnedAfterGState;
		if ( bVendorsCanSell && HasCardGameStatePassed(strVendorOwnedAfterGState) )
		{
			if ( ClassIsChildOf(classObject,Class'BronzeCards') )
			{
				siCards = StatusItemWizardCards(GetStatusItem(Class'StatusItemBronzeCards'));
			} 
			else if ( ClassIsChildOf(classObject,Class'SilverCards') )
			{
				siCards = StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards'));
			} 
			else if ( ClassIsChildOf(classObject,Class'Goldcards') )
			{
				siCards = StatusItemWizardCards(GetStatusItem(Class'StatusItemGoldCards'));
			}
			
			if ( siCards.GetCardOwner(nId) != siCards.ECardOwner.CardOwner_Harry )
			{
				siCards.SetCardOwner(nId, siCards.ECardOwner.CardOwner_Vendor);
			}
		}
	}
}

function RemoveHarryOwnedCardsFromLevel (WizardCardIcon wcExceptThisInstance)
{
	local chestbronze Chest;
	local bronzecauldron Cauldron;
	local WizardCardIcon WCard;
	local int I;
	local StatusItemWizardCards siCards;
	local Class<WizardCardIcon> classWC;

	foreach AllActors(Class'chestbronze',Chest)
	{
		for(I = 0; I < ArrayCount(Chest.EjectedObjects); I++)
		{
			if ( ClassIsChildOf(Chest.EjectedObjects[I],Class'WizardCardIcon') )
			{
				classWC 	= Class<WizardCardIcon>(Chest.EjectedObjects[I]);
				smParent.PlayerHarry.ClientMessage("Object in chest " $ string(classWC) $ string(classWC.Default.Id));
				if ( 	StatusItemWizardCards(GetStatusItem(Class'StatusItemBronzeCards')).IsOwnedByHarry(classWC.Default.Id) 
					|| 	StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards')).IsOwnedByHarry(classWC.Default.Id) 
					|| 	StatusItemWizardCards(GetStatusItem(Class'StatusItemGoldCards')).IsOwnedByHarry(classWC.Default.Id) )
				{
					smParent.PlayerHarry.ClientMessage("Replacing wizard card in chest because Harry already has it: " $ string(classWC));
					Chest.EjectedObjects[I] = Class'Jellybean';
				}
			}
		}
		/*
		I = 0;
		if ( I < 8 )
		{
			if ( ClassIsChildOf(Chest.EjectedObjects[I],Class'WizardCardIcon') )
			{
				classWC = Class<WizardCardIcon>(Chest.EjectedObjects[I]);
				smParent.PlayerHarry.ClientMessage("Object in chest " $ string(classWC) $ string(classWC.Default.Id));
				if ( StatusItemWizardCards(GetStatusItem(Class'StatusItemBronzeCards')).IsOwnedByHarry(classWC.Default.Id) || StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards')).IsOwnedByHarry(classWC.Default.Id) || StatusItemWizardCards(GetStatusItem(Class'StatusItemGoldCards')).IsOwnedByHarry(classWC.Default.Id) )
				{
					smParent.PlayerHarry.ClientMessage("Replacing wizard card in chest because Harry already has it: " $ string(classWC));
					Chest.EjectedObjects[I] = Class'Jellybean';
				}
			}
			I++;
			goto JL0017;
		}
		*/
	}
	foreach AllActors(Class'WizardCardIcon',WCard)
	{
		if ( WCard.Name != wcExceptThisInstance.Name )
		{
			if ( 	StatusItemWizardCards(GetStatusItem(Class'StatusItemBronzeCards')).IsOwnedByHarry(WCard.Id) 
				|| 	StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards')).IsOwnedByHarry(WCard.Id) 
				|| 	StatusItemWizardCards(GetStatusItem(Class'StatusItemGoldCards')).IsOwnedByHarry(WCard.Id) )
			{
				smParent.PlayerHarry.ClientMessage("Deleting wizard card from level because Harry already has it: " $ string(WCard));
				WCard.Destroy();
			}
		}
	}
}

function bool GetGameStateTokenIndex (string strGameState, out int nIdx)
{
	local string strTest;

	/*
	nIdx = 0;
	if ( nIdx < smParent.PlayerHarry.TotalGameStateTokens )
	{
		strTest = smParent.PlayerHarry.GetGameStateMasterListToken(nIdx);
		if ( strTest == strGameState )
		{
			return True;
		}
		nIdx++;
		goto JL0007;
	}
	*/
	
	for(nIdx = 0; nIdx < smParent.PlayerHarry.TotalGameStateTokens; nIdx++)
	{
		strTest = smParent.PlayerHarry.GetGameStateMasterListToken(nIdx);
		if ( strTest == strGameState )
		{
			return True;
		}
	}
	
	nIdx = 0;
	return False;
}

function bool HasCardGameStatePassed (string strCardGameState)
{
	local int nCurrStateTokenIdx;
	local int nCardStateTokenIdx;

	/*
	if ( GetGameStateTokenIndex(smParent.PlayerHarry.CurrentGameState,nCurrStateTokenIdx) )
	{
		if ( GetGameStateTokenIndex(strCardGameState,nCardStateTokenIdx) )
		{
			if ( nCardStateTokenIdx <= nCurrStateTokenIdx )
			{
				smParent.PlayerHarry.ClientMessage("Game state passed " $ strCardGameState);
				return True;
			}
		} 
		else 
		{
			smParent.PlayerHarry.ClientMessage("ERROR getting wizard card game state token idx " $ strCardGameState);
		}
	}
	return False;
	*/
	
	if(	GetGameStateTokenIndex(smParent.PlayerHarry.CurrentGameState,nCurrStateTokenIdx) )
	{
		if( GetGameStateTokenIndex(strCardGameState,nCardStateTokenIdx) )
		{
			if( nCardStateTokenIdx <= nCurrStateTokenIdx )
			{
				smParent.PlayerHarry.ClientMessage("Game state passed " $strCardGameState);
				return True;
			}
		}
		else
		{
			smParent.PlayerHarry.ClientMessage("ERROR getting wizard card game state token idx " $strCardGameState);
		}
	}
	
	return false;
	
}

function ShowCardData()
{
	StatusItemWizardCards(GetStatusItem(Class'StatusItemBronzeCards')).ShowCardData();
	StatusItemWizardCards(GetStatusItem(Class'StatusItemSilverCards')).ShowCardData();
	StatusItemWizardCards(GetStatusItem(Class'StatusItemGoldCards')).ShowCardData();
}

function SetLastObtainedCardItem (StatusItemWizardCards siWC)
{
	if ( siWC.IsA('StatusItemBronzeCards') )
	{
		LastObtainedCardType = CardType_Bronze;
	} 
	else if ( siWC.IsA('StatusItemSilverCards') )
	{
		LastObtainedCardType = CardType_Silver;
	} 
	else if ( siWC.IsA('StatusItemGoldCards') )
	{
		LastObtainedCardType = CardType_Gold;
	}
}

function ECardType GetLastObtainedCardType()
{
	return LastObtainedCardType;
}

function SetLastObtainedCardTypeAsInt (int nLastCardType)
{
	switch (nLastCardType)
	{
		case nCARDTYPE_BRONZE:
			LastObtainedCardType = CardType_Bronze;
			break;
		case nCARDTYPE_SILVER:
			LastObtainedCardType = CardType_Silver;
			break;
		case nCARDTYPE_GOLD:
			LastObtainedCardType = CardType_Gold;
			break;
		default:
			LastObtainedCardType = CardType_None;
			break;
	}
}

function int GetLastObtainedCardTypeAsInt()
{
	switch (LastObtainedCardType)
	{
		case CardType_Bronze:
			return nCARDTYPE_BRONZE;
		case CardType_Silver:
			return nCARDTYPE_SILVER;
		case CardType_Gold:
			return nCARDTYPE_GOLD;
		case CardType_None:
			return nCARDTYPE_NONE;
	}
}

defaultproperties
{
    LastObtainedCardType=CardType_None

    bDisplayJustFirstItem=True

    fTotalEffectInTime=0.50

    fTotalHoldTime=3.00

    fTotalEffectOutTime=0.20
	
	// Metallicafan212:	Missing for some reason
	MenuProps=Menu_Never
	
	// DivingDeep39: Omega:
	AlignmentType=AT_Right
}