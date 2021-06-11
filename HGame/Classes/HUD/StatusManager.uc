//================================================================================
// StatusManager.
//================================================================================

class StatusManager extends HudItemManager;

const nTOTAL_WIZARD_CARDS= 101;
var StatusGroup sgList;
var int nCanvasSizeX;
var int nCanvasSizeY;
var harry PlayerHarry;


event PreBeginPlay ()
{
  Super.PreBeginPlay();
  sgList = None;
  nCanvasSizeX = 0;
  nCanvasSizeY = 0;
}

function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
  local StatusGroup sgLoop;

  nCanvasSizeX = Canvas.SizeX;
  nCanvasSizeY = Canvas.SizeY;
// JL0033:
  // sgLoop = sgList;
  // if ( sgLoop != None )
  for(sgLoop = sgList; sgLoop != None; sgLoop = sgLoop.sgNext)
  {
    sgLoop.RenderHudItemManager(Canvas,bMenuMode,bFullCutMode,bHalfCutMode);
    // sgLoop = sgLoop.sgNext;
    // goto JL0033;
  }
}

function PickupItem (HProp Prop)
{
  local StatusGroup sgUpdate;
  local StatusItem siUpdate;
  local Actor actorTemp;
  local int nOthersInLevel;

  if ( (Prop.classStatusGroup == None) || (Prop.classStatusItem == None) )
  {
    return;
  }
  sgUpdate = GetStatusGroup(Prop.classStatusGroup);
  if ( sgUpdate != None )
  {
    siUpdate = sgUpdate.GetStatusItem(Prop.classStatusItem);
    if ( (siUpdate != None) && (siUpdate.bDisplayMaxCount == True) && (siUpdate.nCount == 0) )
    {
      nOthersInLevel = 0;
      foreach AllActors(Prop.Class,actorTemp)
      {
        nOthersInLevel++;
      }
      siUpdate.nMaxCount = nOthersInLevel;
    }
    sgUpdate.IncrementCount(Prop.classStatusItem,Prop.nPickupIncrement);
  }
}

function DropOffItem (HProp Prop)
{
  local StatusGroup sgUpdate;

  if ( (Prop.classStatusGroup == None) || (Prop.classStatusItem == None) )
  {
    return;
  }
  sgUpdate = GetStatusGroup(Prop.classStatusGroup);
  if ( sgUpdate != None )
  {
    sgUpdate.IncrementCount(Prop.classStatusItem, -Prop.nPickupIncrement);
  }
}

function IncrementCount (Class<StatusGroup> classGroup, Class<StatusItem> classItem, int nNum)
{
  local StatusGroup sgUpdate;
  local StatusItem siUpdate;

  sgUpdate = GetStatusGroup(classGroup);
  if ( sgUpdate != None )
  {
    sgUpdate.IncrementCount(classItem,nNum);
  }
}

function SetCount (Class<StatusGroup> classGroup, Class<StatusItem> classItem, int nNum)
{
  local StatusItem siUpdate;

  siUpdate = GetStatusItem(classGroup,classItem);
  if ( siUpdate != None )
  {
    siUpdate.SetCount(nNum);
  }
}

function IncrementCountPotential (Class<StatusGroup> classGroup, Class<StatusItem> classItem, int nNum)
{
  local StatusGroup sgUpdate;
  local StatusItem siUpdate;

  sgUpdate = GetStatusGroup(classGroup);
  if ( sgUpdate != None )
  {
    sgUpdate.IncrementCountPotential(classItem,nNum);
  }
}

function Vector GetHudLocation (HProp Prop)
{
  local StatusGroup sg;

  if ( (Prop.classStatusGroup == None) || (Prop.classStatusItem == None) )
  {
    Log("Error: StatusManager data not setup correctly for " $ string(Prop.Class));
    return vect(0.00,0.00,0.00);
  }
  sg = GetStatusGroup(Prop.classStatusGroup);
  return sg.GetItemLocation(Prop.classStatusItem,False);
}

function StatusItem GetStatusItem (Class<StatusGroup> classGroup, Class<StatusItem> classItem)
{
  local StatusGroup sgFound;

  sgFound = GetStatusGroup(classGroup);
  if ( sgFound != None )
  {
    return sgFound.GetStatusItem(classItem);
  } else {
    Log("Error: could not create or find StatusGroup " $ string(classGroup));
  }
}

function StatusGroup GetStatusGroup (Class<StatusGroup> classGroup)
{
  local StatusGroup sgLoop;

  if ( sgList == None )
  {
    sgList = Spawn(classGroup);
    sgList.sgNext = None;
    sgList.smParent = self;
    return sgList;
  }
  // sgLoop = sgList;
  // if ( sgLoop != None )
  for(sgLoop = sgList; sgLoop != None; sgLoop = sgLoop.sgNext)
  {
    if ( sgLoop.Class == classGroup )
    {
      return sgLoop;
    }
    if ( sgLoop.sgNext == None )
    {
      sgLoop.sgNext = Spawn(classGroup);
      sgLoop.sgNext.smParent = self;
      return sgLoop.sgNext;
    }
    // sgLoop = sgLoop.sgNext;
    // goto JL004A;
  }
  Log("Error: StatusManager::GetStatusGroup- should not get to here");
  return None;
}

function CreateStartupItems ()
{
  GetStatusItem(Class'StatusGroupHealth',Class'StatusItemHealth');
  GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts');
  GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemRavenclawPts');
  GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemHufflePuffPts');
  GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemSlytherinPts');
  GetStatusItem(Class'StatusGroupJellybeans',Class'StatusItemJellybeans');
  GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemBronzeCards');
  GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemSilverCards');
  GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemGoldCards');
}

function AddHPointsG (int nPoints)
{
  AddHousePoints(Class'StatusItemGryffindorPts',nPoints);
}

function int GetHPointsG ()
{
  return GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts').nCount;
}

function AddHPointsH (int nPoints)
{
  AddHousePoints(Class'StatusItemHufflePuffPts',nPoints);
}

function int GetHPointsH ()
{
  return GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemHufflePuffPts').nCount;
}

function AddHPointsS (int nPoints)
{
  AddHousePoints(Class'StatusItemSlytherinPts',nPoints);
}

function int GetHPointsS ()
{
  return GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemSlytherinPts').nCount;
}

function AddHPointsR (int nPoints)
{
  AddHousePoints(Class'StatusItemRavenclawPts',nPoints);
}

function int GetHPointsR ()
{
  return GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemRavenclawPts').nCount;
}

function AddHousePoints (Class<StatusItem> classItem, int nPoints)
{
  local StatusGroup sgHousePts;
  local StatusItem siHousePts;

  sgHousePts = GetStatusGroup(Class'StatusGroupHousePoints');
  sgHousePts.IncrementCount(classItem,nPoints);
  siHousePts = sgHousePts.GetStatusItem(classItem);
  siHousePts = sgHousePts.GetStatusItem(Class'StatusItemGryffindorPts');
  PlayerHarry.ClientMessage("Gryffindor : " $ string(siHousePts.nCount));
  siHousePts = sgHousePts.GetStatusItem(Class'StatusItemHufflePuffPts');
  PlayerHarry.ClientMessage("Hufflepuff : " $ string(siHousePts.nCount));
  siHousePts = sgHousePts.GetStatusItem(Class'StatusItemRavenclawPts');
  PlayerHarry.ClientMessage("Ravenclaw : " $ string(siHousePts.nCount));
  siHousePts = sgHousePts.GetStatusItem(Class'StatusItemSlytherinPts');
  PlayerHarry.ClientMessage("Slytherin : " $ string(siHousePts.nCount));
}

function AddFMucus (int nCount)
{
  IncrementCount(Class'StatusGroupPotionIngr',Class'StatusItemFlobberMucus',nCount);
}

function int GetFMucusCount ()
{
  return GetStatusItem(Class'StatusGroupPotionIngr',Class'StatusItemFlobberMucus').nCount;
}

function AddWBark (int nCount)
{
  IncrementCount(Class'StatusGroupPotionIngr',Class'StatusItemWiggenBark',nCount);
}

function int GetWBarkCount ()
{
  return GetStatusItem(Class'StatusGroupPotionIngr',Class'StatusItemWiggenBark').nCount;
}

function AddBicorn (int nCount)
{
  IncrementCount(Class'StatusGroupPolyIngr',Class'StatusItemBicorn',nCount);
}

function int GetBicornCount ()
{
  return GetStatusItem(Class'StatusGroupPolyIngr',Class'StatusItemBicorn').nCount;
}

function AddBoomslang (int nCount)
{
  IncrementCount(Class'StatusGroupPolyIngr',Class'StatusItemBoomslang',nCount);
}

function int GetBoomslangCount ()
{
  return GetStatusItem(Class'StatusGroupPolyIngr',Class'StatusItemBoomslang').nCount;
}

function int AddNimbus (int nCount)
{
  IncrementCount(Class'StatusGroupQGear',Class'StatusItemNimbus',nCount);
}

function int GetNimbusCount ()
{
  return GetStatusItem(Class'StatusGroupQGear',Class'StatusItemNimbus').nCount;
}

function int AddQArmor (int nCount)
{
  IncrementCount(Class'StatusGroupQGear',Class'StatusItemQArmor',nCount);
}

function int GetQArmorCount ()
{
  return GetStatusItem(Class'StatusGroupQGear',Class'StatusItemQArmor').nCount;
}

function AddBeans (int nCount)
{
  IncrementCount(Class'StatusGroupJellybeans',Class'StatusItemJellybeans',nCount);
}

function int GetBeanCount ()
{
  return GetStatusItem(Class'StatusGroupJellybeans',Class'StatusItemJellybeans').nCount;
}

function AddPotions (int nCount)
{
  IncrementCount(Class'StatusGroupPotions',Class'StatusItemWiggenwell',nCount);
}

function int GetPotionCount ()
{
  return GetStatusItem(Class'StatusGroupPotions',Class'StatusItemWiggenwell').nCount;
}

function AddHealth (int nCount)
{
  IncrementCount(Class'StatusGroupHealth',Class'StatusItemHealth',nCount);
}

function int GetHealthCount ()
{
  return GetStatusItem(Class'StatusGroupHealth',Class'StatusItemHealth').nCount;
}

function SetHealthCount (int nCount)
{
  SetCount(Class'StatusGroupHealth',Class'StatusItemHealth',nCount);
}

function AddHealthPotential (int nCount)
{
  IncrementCountPotential(Class'StatusGroupHealth',Class'StatusItemHealth',nCount);
}

function int GetHealthPotentialCount ()
{
  return GetStatusItem(Class'StatusGroupHealth',Class'StatusItemHealth').nCurrCountPotential;
}

function AddLock1 (int nCount)
{
  IncrementCountPotential(Class'StatusGroupLocks',Class'StatusItemLock1',nCount);
}

function int GetLock1Count ()
{
  return GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock1').nCount;
}

function AddLock2 (int nCount)
{
  IncrementCountPotential(Class'StatusGroupLocks',Class'StatusItemLock2',nCount);
}

function int GetLock2Count ()
{
  return GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock2').nCount;
}

function AddLock3 (int nCount)
{
  IncrementCountPotential(Class'StatusGroupLocks',Class'StatusItemLock3',nCount);
}

function int GetLock3Count ()
{
  return GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock3').nCount;
}

function AddLock4 (int nCount)
{
  IncrementCountPotential(Class'StatusGroupLocks',Class'StatusItemLock4',nCount);
}

function int GetLock4Count ()
{
  return GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock4').nCount;
}

function GiveCardToHarry (int nCardId)
{
  GiveCard(nCardId,True);
}

function GiveCardToVendors (int nCardId)
{
  GiveCard(nCardId,False);
}

function GiveCard (int nCardId, bool bHarry)
{
  local StatusItemWizardCards siWC;
  local Class<Actor> classWC;
  local string strDebug;

  if ( bHarry )
  {
    strDebug = "Harry has ";
  } else {
    strDebug = "Vendors have ";
  }
  siWC = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemBronzeCards'));
  classWC = siWC.GetCardClassFromId(nCardId);
  if ( classWC != None )
  {
    if ( ClassIsChildOf(classWC,Class'BronzeCards') )
    {
      strDebug = strDebug $ "bronze card ";
      siWC = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemBronzeCards'));
    } else //{
      if ( ClassIsChildOf(classWC,Class'SilverCards') )
      {
        strDebug = strDebug $ "silver card ";
        siWC = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemSilverCards'));
      } else //{
        if ( ClassIsChildOf(classWC,Class'Goldcards') )
        {
          strDebug = strDebug $ "gold card ";
          siWC = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemGoldCards'));
        }
      // }
    // }
    strDebug = strDebug $ string(nCardId);
    PlayerHarry.ClientMessage(strDebug);
    if ( bHarry )
    {
      siWC.SetCardOwner(nCardId,siWC.ECardOwner.CardOwner_Harry);
    } else {
      siWC.SetCardOwner(nCardId,siWC.ECardOwner.CardOwner_Vendor);
    }
  }
}

function GiveAllCardsToHarry ()
{
  local StatusItemWizardCards siBronzeCards;
  local StatusItemWizardCards siSilverCards;
  local StatusItemWizardCards siGoldCards;
  local Class<Actor> classWC;
  local int I;

  siBronzeCards = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemBronzeCards'));
  siSilverCards = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemSilverCards'));
  siGoldCards = StatusItemWizardCards(GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemGoldCards'));
  // I = 1;
  // if ( I <= 101 )
  for(I = 1; I <= nTOTAL_WIZARD_CARDS; I++)
  {
    classWC = siBronzeCards.GetCardClassFromId(I);
    if ( classWC != Class'WCPotter' )
    {
      if ( ClassIsChildOf(classWC,Class'BronzeCards') )
      {
        siBronzeCards.SetCardOwner(I,siBronzeCards.ECardOwner.CardOwner_Harry);
      } else //{
        if ( ClassIsChildOf(classWC,Class'SilverCards') )
        {
          siSilverCards.SetCardOwner(I,siSilverCards.ECardOwner.CardOwner_Harry);
        } else //{
          if ( ClassIsChildOf(classWC,Class'Goldcards') )
          {
            siGoldCards.SetCardOwner(I,siGoldCards.ECardOwner.CardOwner_Harry);
          }
        // }
      // }
    }
    // I++;
    // goto JL0058;
  }
  siGoldCards.SetCardOwner(Class'WCPotter'.Default.Id,siGoldCards.ECardOwner.CardOwner_Harry);
  GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock1').SetCount(1);
  GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock2').SetCount(1);
  GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock3').SetCount(1);
  GetStatusItem(Class'StatusGroupLocks',Class'StatusItemLock4').SetCount(1);
}

function ShowCardData ()
{
  local StatusGroupWizardCards sgWC;

  sgWC = StatusGroupWizardCards(GetStatusGroup(Class'StatusGroupWizardCards'));
  sgWC.ShowCardData();
}

defaultproperties
{
    bHidden=True

}
