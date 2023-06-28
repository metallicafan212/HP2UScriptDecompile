//================================================================================
// Characters.
//================================================================================

class Characters extends HChar; 

const strCUE_OUT_OF_STOCK_DONE= "_OutOfStockDone";
const strCUE_LURING_DONE= "_LuringDone";
enum EVendorDialog {
  VDialog_FredWeasley,
  VDialog_GeorgeWeasley,
  VDialog_GenericMale1,
  VDialog_GenericMale2,
  VDialog_GenericFemale1,
  VDialog_GenericFemale2,
  VDialog_DuelVendor,
  VDialog_None
};

enum ESells {
  Sells_Nimbus2001,
  Sells_QArmor,
  Sells_WBark,
  Sells_FMucus,
  Sells_BronzeCards,
  Sells_SilverCards,
  Sells_Duel,
  Sells_Nothing
};
struct TVendorDialog
{
  var string strLureId;
  var string strSellNimbusId;
  var string strSellQArmorId;
  var string strSellWBarkId;
  var string strSellFMucusId;
  var string strSellBronzeCardsId;
  var string strSellSilverCardsId;
  var string strRanOutOfBeansId;
  var string strNotEnoughBeansId;
  var string strDeclineId;
  var string strTransactionDoneId;
  var string strOutOfStockId;
  var string strSellDuelId;
  var string strNarratorInstrId;
  var string strHarryWhatYouGotId;
};

var(Vendor) ESells CharacterSells;
var(Vendor) EVendorDialog VendorDialogSet;
var(Vendor) int nPriceNimbus2001;
var(Vendor) int nPriceQArmor;
var(Vendor) int nPriceWBark;
var(Vendor) int nPriceFMucus;
var(Vendor) int nPriceBronzeCardsMin;
var(Vendor) int nPriceBronzeCardsMax;
var(Vendor) int nPriceSilverCardsMin;
var(Vendor) int nPriceSilverCardsMax;
var(Vendor) bool bLuringEnabled;
var(Vendor) int nLureDistance;
var(Vendor) int nFMucusInventoryMin;
var(Vendor) int nFMucusInventoryMax;
var(Vendor) int nWBarkInventoryMin;
var(Vendor) int nWBarkInventoryMax;
var(Vendor) int DuelRank;
var TriggerChangeLevel DuelLevelTrigger;
var int DuelBeans;
var TVendorDialog VendorDialog;
var name nameVendorSavedState;
var bool bInLureRange;
var string strCurrLureLine;
var Sound soundCurrVendorPopup;
var VendorManager managerVendor;
var string strCueVendorGive;
var Jellybean VendorJellybean;
var float fLureTick;
var int nCurrIngrCount;
var string LastIngrCountUpdateState;
var Rotator rSave;
var Characters WeasleyTwin;
var name PersistentState;
var name PersistentLeadingActor;
var name PersistentNavPName;


event PostBeginPlay()
{
  local Actor A;

  VendorInit();
  if ( CutName == "" )
  {
    CutName = string(Name);
  }
  if ( bPersistent )
  {
    if ( PersistentState != 'None' && PersistentState == 'stateIdle' || (PersistentState == 'stateLeadingActorPause' || PersistentState == 'stateLeadingActor') )
    {
      foreach AllActors(Class'Actor',A)
      {
        if ( A.Name == PersistentLeadingActor )
        {
          LeadingActor = A;
        }
        if ( A.Name == PersistentNavPName )
        {
          navP = NavigationPoint(A);
        }
      }
      Log("*!* " $ string(self) $ " P_LOADING: PersistentState: " $ string(PersistentState) $ " for " $ string(self));
      Log("*!* " $ string(self) $ " P_LOADING: PersistentLeadingActor: " $ string(PersistentLeadingActor) $ " LeadingActor: " $ string(LeadingActor) $ " AnimSequence: " $ string(AnimSequence));
      InitialState = PersistentState;
    }
  }
  if ( (DuelRank > 0) && (DuelRank <= 10) )
  {
    CharacterSells = Sells_Duel;
    VendorDialogSet = VDialog_DuelVendor;
  }
  rSave = Rotation;
  Super.PostBeginPlay();
}

event OnResolveGameState()
{
  Super.OnResolveGameState();
  if (  !bInCurrentGameState && IsInState('VendorIdle') )
  {
    GotoState('stateIdle');
  }
}

function VendorInit()
{
  if ( VendorDialogSet == VDialog_GenericFemale2 )
  {
    if ( (CharacterSells == Sells_BronzeCards) || (CharacterSells == Sells_SilverCards) )
    {
      VendorDialogSet = VDialog_GenericFemale1;
    }
  }
  switch (VendorDialogSet)
  {
    case VDialog_FredWeasley:
		VendorDialog.strLureId = "PC_Frd_Vendor_01";
		VendorDialog.strSellNimbusId = "PC_Frd_Vendor_37";
		VendorDialog.strSellQArmorId = "";
		VendorDialog.strSellWBarkId = "PC_Frd_Vendor_74";
		VendorDialog.strSellFMucusId = "PC_Frd_Vendor_08";
		VendorDialog.strSellBronzeCardsId = "PC_Frd_Vendor_32";
		VendorDialog.strSellSilverCardsId = "PC_Frd_Vendor_47";
		VendorDialog.strRanOutOfBeansId = "PC_Frd_Vendor_20";
		VendorDialog.strNotEnoughBeansId = "PC_Frd_Vendor_56";
		VendorDialog.strDeclineId = "PC_Frd_Vendor_14";
		VendorDialog.strTransactionDoneId = "PC_Frd_Vendor_26";
		VendorDialog.strOutOfStockId = "PC_Frd_Vendor_85";
		VendorDialog.strSellDuelId = "";
		VendorDialog.strNarratorInstrId = "PC_Nar_Vendor_88";
		VendorDialog.strHarryWhatYouGotId = "PC_Hry_Vendor_07";
		break;
    case VDialog_GeorgeWeasley:
		VendorDialog.strLureId = "PC_Grg_Vendor_02";
		VendorDialog.strSellNimbusId = "";
		VendorDialog.strSellQArmorId = "PC_Grg_Vendor_38";
		VendorDialog.strSellWBarkId = "PC_Grg_Vendor_48";
		VendorDialog.strSellFMucusId = "PC_Grg_Vendor_09";
		VendorDialog.strSellBronzeCardsId = "PC_Grg_Vendor_32";
		VendorDialog.strSellSilverCardsId = "PC_Grg_Vendor_75";
		VendorDialog.strRanOutOfBeansId = "PC_Grg_Vendor_21";
		VendorDialog.strNotEnoughBeansId = "PC_Grg_Vendor_57";
		VendorDialog.strDeclineId = "PC_Grg_Vendor_15";
		VendorDialog.strTransactionDoneId = "PC_Grg_Vendor_27";
		VendorDialog.strOutOfStockId = "PC_Grg_Vendor_86";
		VendorDialog.strSellDuelId = "";
		VendorDialog.strNarratorInstrId = "PC_Nar_Vendor_88";
		VendorDialog.strHarryWhatYouGotId = "PC_Hry_Vendor_07";
		break;
    case VDialog_GenericMale1:
		VendorDialog.strLureId = "PC_Gv1_Vendor_03";
		VendorDialog.strSellNimbusId = "";
		VendorDialog.strSellQArmorId = "";
		VendorDialog.strSellWBarkId = "PC_Gv1_Vendor_39";
		VendorDialog.strSellFMucusId = "PC_Gv1_Vendor_10";
		VendorDialog.strSellBronzeCardsId = "PC_Gv1_Vendor_33";
		VendorDialog.strSellSilverCardsId = "PC_Gv1_Vendor_43";
		VendorDialog.strRanOutOfBeansId = "PC_Gv1_Vendor_22";
		VendorDialog.strNotEnoughBeansId = "PC_Gv1_Vendor_52";
		VendorDialog.strDeclineId = "PC_Gv1_Vendor_16";
		VendorDialog.strTransactionDoneId = "PC_Gv1_Vendor_28";
		VendorDialog.strOutOfStockId = "PC_Gv1_Vendor_80";
		VendorDialog.strSellDuelId = "";
		VendorDialog.strNarratorInstrId = "PC_Nar_Vendor_88";
		VendorDialog.strHarryWhatYouGotId = "PC_Hry_Vendor_07";
		break;
    case VDialog_GenericMale2:
		VendorDialog.strLureId = "PC_Gv2_Vendor_04";
		VendorDialog.strSellNimbusId = "";
		VendorDialog.strSellQArmorId = "";
		VendorDialog.strSellWBarkId = "PC_Gv2_Vendor_40";
		VendorDialog.strSellFMucusId = "PC_Gv2_Vendor_11";
		VendorDialog.strSellBronzeCardsId = "PC_Gv2_Vendor_34";
		VendorDialog.strSellSilverCardsId = "PC_Gv2_Vendor_44";
		VendorDialog.strRanOutOfBeansId = "PC_Gv2_Vendor_23";
		VendorDialog.strNotEnoughBeansId = "PC_Gv2_Vendor_53";
		VendorDialog.strDeclineId = "PC_Gv2_Vendor_17";
		VendorDialog.strTransactionDoneId = "PC_Gv2_Vendor_29";
		VendorDialog.strOutOfStockId = "PC_Gv2_Vendor_81";
		VendorDialog.strSellDuelId = "";
		VendorDialog.strNarratorInstrId = "PC_Nar_Vendor_88";
		VendorDialog.strHarryWhatYouGotId = "PC_Hry_Vendor_07";
		break;
    case VDialog_GenericFemale1:
		VendorDialog.strLureId = "PC_Gv3_Vendor_05";
		VendorDialog.strSellNimbusId = "";
		VendorDialog.strSellQArmorId = "";
		VendorDialog.strSellWBarkId = "PC_Gv3_Vendor_41";
		VendorDialog.strSellFMucusId = "PC_Gv3_Vendor_12";
		VendorDialog.strSellBronzeCardsId = "PC_Gv3_Vendor_35";
		VendorDialog.strSellSilverCardsId = "PC_Gv3_Vendor_45";
		VendorDialog.strRanOutOfBeansId = "PC_Gv3_Vendor_24";
		VendorDialog.strNotEnoughBeansId = "PC_Gv3_Vendor_54";
		VendorDialog.strDeclineId = "PC_Gv3_Vendor_18";
		VendorDialog.strTransactionDoneId = "PC_Gv3_Vendor_30";
		VendorDialog.strOutOfStockId = "PC_Gv3_Vendor_82";
		VendorDialog.strSellDuelId = "";
		VendorDialog.strNarratorInstrId = "PC_Nar_Vendor_88";
		VendorDialog.strHarryWhatYouGotId = "PC_Hry_Vendor_07";
		break;
    case VDialog_GenericFemale2:
		VendorDialog.strLureId = "PC_Gv4_Vendor_06";
		VendorDialog.strSellNimbusId = "";
		VendorDialog.strSellQArmorId = "";
		VendorDialog.strSellWBarkId = "PC_Gv4_Vendor_42";
		VendorDialog.strSellFMucusId = "PC_Gv4_Vendor_13";
		VendorDialog.strSellBronzeCardsId = "PC_Gv4_Vendor_36";
		VendorDialog.strSellSilverCardsId = "PC_Gv4_Vendor_46";
		VendorDialog.strRanOutOfBeansId = "PC_Gv4_Vendor_25";
		VendorDialog.strNotEnoughBeansId = "PC_Gv4_Vendor_55";
		VendorDialog.strDeclineId = "PC_Gv4_Vendor_19";
		VendorDialog.strTransactionDoneId = "PC_Gv4_Vendor_31";
		VendorDialog.strOutOfStockId = "PC_Gv4_Vendor_83";
		VendorDialog.strSellDuelId = "";
		VendorDialog.strNarratorInstrId = "PC_Nar_Vendor_88";
		VendorDialog.strHarryWhatYouGotId = "PC_Hry_Vendor_07";
		break;
    default:
		if ( CharacterSells != Sells_Nothing )
		{
		  harry(Level.PlayerHarryActor).ClientMessage("WARNING: Vendor's VendorDialogSet not assigned");
		}
		break;
  }
  if ( IsDuelVendor() )
  {
    VendorDialog.strLureId = "";
    VendorDialog.strSellNimbusId = "";
    VendorDialog.strSellQArmorId = "";
    VendorDialog.strSellWBarkId = "";
    VendorDialog.strSellFMucusId = "";
    VendorDialog.strSellBronzeCardsId = "";
    VendorDialog.strSellSilverCardsId = "";
    VendorDialog.strRanOutOfBeansId = "";
    VendorDialog.strNotEnoughBeansId = "WizardDuel_0005";
    VendorDialog.strDeclineId = "";
    VendorDialog.strTransactionDoneId = "";
    VendorDialog.strOutOfStockId = "";
    VendorDialog.strSellDuelId = "";
    VendorDialog.strNarratorInstrId = "WizardDuel_0006";
    VendorDialog.strHarryWhatYouGotId = "";
  }
}

function string GetVendorHarryInquiryId()
{
  return VendorDialog.strHarryWhatYouGotId;
}

function string GetVendorInstructionId()
{
  return VendorDialog.strNarratorInstrId;
}

function string GetVendorLureId()
{
  return VendorDialog.strLureId;
}

function string GetVendorRanOutOfBeansId()
{
  return VendorDialog.strRanOutOfBeansId;
}

function string GetVendorNotEnoughBeansId()
{
  return VendorDialog.strNotEnoughBeansId;
}

function string GetVendorTransactionDoneId()
{
  return VendorDialog.strTransactionDoneId;
}

function string GetVendorOutOfStockId()
{
  return VendorDialog.strOutOfStockId;
}

function string GetVendorDeclineId()
{
  return VendorDialog.strDeclineId;
}

function string GetSellDialogId()
{
  local string strDialogID;

  switch (CharacterSells)
  {
    case Sells_Nimbus2001:
    strDialogID = VendorDialog.strSellNimbusId;
    break;
    case Sells_QArmor:
    strDialogID = VendorDialog.strSellQArmorId;
    break;
    case Sells_WBark:
    strDialogID = VendorDialog.strSellWBarkId;
    break;
    case Sells_FMucus:
    strDialogID = VendorDialog.strSellFMucusId;
    break;
    case Sells_BronzeCards:
    strDialogID = VendorDialog.strSellBronzeCardsId;
    break;
    case Sells_SilverCards:
    strDialogID = VendorDialog.strSellSilverCardsId;
    break;
    case Sells_Duel:
    strDialogID = VendorDialog.strSellDuelId;
    break;
    default:
    break;
  }
  return strDialogID;
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string sCutName;
  local Actor A;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "SellVendorItem" )
  {
    strCueVendorGive = cue;
    GotoState('VendorGive');
    return True;
  }
  return Super.CutCommand(Command,cue,bFastFlag);
}

event PreSaveGame()
{
  Super.PreSaveGame();
  if ( managerVendor != None )
  {
    managerVendor.Destroy();
    managerVendor = None;
  }
}

event Bump (Actor Other)
{
  if ( (Other == Level.PlayerHarryActor) && (Level.PlayerHarryActor.Physics != PHYS_Falling) && (HaveSomethingToSell() || SellsSomethingButOutOfStock()) )
  {
    if ( managerVendor == None )
    {
      managerVendor = VendorManager(FancySpawn(Class'VendorManager'));
      managerVendor.SetVendor(self);
    }
    bInLureRange = True;
    InterruptOtherVendorPopup();
    if ( IsInVendorPopupState() )
    {
      StopSound(soundCurrVendorPopup);
    } else {
      nameVendorSavedState = GetStateName();
    }
    if ( SellsSomethingButOutOfStock() )
    {
      GotoState('SayOutOfStockLine');
    } else {
      managerVendor.DoEngageVendor(nameVendorSavedState);
      GotoState('VendorEngaged');
    }
  } else {
    Super.Bump(Other);
  }
}

function InterruptOtherVendorPopup()
{
  local Characters character;

  foreach AllActors(Class'Characters',character)
  {
    if ( character != self )
    {
      character.OtherVendorInterruptedPopup();
    }
  }
}

function OtherVendorInterruptedPopup()
{
  StopSound(soundCurrVendorPopup);
  if ( IsInVendorPopupState() )
  {
    DesiredRotation = rSave;
    GotoState('VendorIdle');
  }
}

function bool IsInVendorPopupState()
{
  return (IsInState('SayVendorLureLine') || IsInState('SayOutOfStockLine'));
}

function int GetSellingPrice()
{
  switch (CharacterSells)
  {
    case Sells_Nimbus2001:
    return nPriceNimbus2001;
    case Sells_QArmor:
    return nPriceQArmor;
    case Sells_WBark:
    return nPriceWBark;
    case Sells_FMucus:
    return nPriceFMucus;
    case Sells_BronzeCards:
    return RandRange(nPriceBronzeCardsMin,nPriceBronzeCardsMax);
	case Sells_SilverCards:
    return RandRange(nPriceSilverCardsMin,nPriceSilverCardsMax);
	case Sells_Duel:
    return DuelBeans;
    default:
	return 0;
  }
}

function bool HaveSomethingToSell()
{
  if ( harry(Level.PlayerHarryActor).bIsGoyle )
  {
    return False;
  }
  switch (CharacterSells)
  {
    case Sells_Nimbus2001:
    return !harry(Level.PlayerHarryActor).bHaveNimbus2001;
    case Sells_QArmor:
    return !harry(Level.PlayerHarryActor).bHaveQArmor;
    case Sells_WBark:
    return nCurrIngrCount > 0;
    case Sells_FMucus:
    return nCurrIngrCount > 0;
    case Sells_BronzeCards:
    return IsWizardCardAvailable(Class'StatusItemBronzeCards');
    case Sells_SilverCards:
    return IsWizardCardAvailable(Class'StatusItemSilverCards');
    case Sells_Duel:
    return IsDuelVendor();
    default:
	return False;
  }
}

function bool SellsSomethingButOutOfStock()
{
  return (CharacterSells != Sells_Nothing) &&  !HaveSomethingToSell();
}

function bool IsWizardCardAvailable (Class<StatusItemWizardCards> classCardItem)
{
  local int nTemp;

  return GetAvailableWizardCardId(classCardItem,nTemp);
}

function bool GetAvailableWizardCardId (Class<StatusItemWizardCards> classCardItem, out int nId)
{
  local StatusManager managerStatus;
  local StatusGroupWizardCards sgWC;
  local StatusItemWizardCards siWC;

  managerStatus = harry(Level.PlayerHarryActor).managerStatus;
  sgWC = StatusGroupWizardCards(managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
  siWC = StatusItemWizardCards(sgWC.GetStatusItem(classCardItem));
  return siWC.GetFirstVendorCardId(nId);
}

event Tick (float fDeltaTime)
{
  Super.Tick(fDeltaTime);
  if ( (CharacterSells == Sells_WBark) || (CharacterSells == Sells_FMucus) )
  {
    if ( LastIngrCountUpdateState != Level.PlayerHarryActor.CurrentGameState )
    {
      LastIngrCountUpdateState = Level.PlayerHarryActor.CurrentGameState;
      if ( CharacterSells == Sells_FMucus )
      {
        nCurrIngrCount = RandRange(nFMucusInventoryMin,nFMucusInventoryMax); 
	  }
	  else if ( CharacterSells == Sells_WBark )
      {
        nCurrIngrCount = RandRange(nWBarkInventoryMin,nWBarkInventoryMax);
	  }	 
    }
  }
  if ( bLuringEnabled &&  !bHidden )
  {
    fLureTick += fDeltaTime;
    if ( fLureTick >= 0.25 )
    {
      fLureTick = 0.0;
      if ( VSize2D(Level.PlayerHarryActor.Location - Location) <= nLureDistance )
      {
        if ( !bInLureRange && HaveSomethingToSell() && harry(Level.PlayerHarryActor).LineOfSightTo(self) && harry(Level.PlayerHarryActor).InFrontOfHarry(self) && !HPHud(harry(Level.PlayerHarryActor).myHUD).IsCutSceneOrPopupInProgress() )
        {
          bInLureRange = True;
          nameVendorSavedState = GetStateName();
          GotoState('SayVendorLureLine');
        }
      } 
	  else 
	  {
         bInLureRange = False;
      }
    }
  }
}

function OnHarryCaptured()
{
  if ( IsInVendorPopupState() )
  {
    DesiredRotation = rSave;
    StopSound(soundCurrVendorPopup);
    GotoState('VendorIdle');
  }
}

function Characters GetWeasleyTwin()
{
  local Characters Weasley;
  local Characters NearestWeasley;
  local float fDistToWeasley;
  local float fDistToNearestWeasley;
  local name nameWeasley;

  if ( IsA('GeorgeWeasley') )
  {
    nameWeasley = 'FredWeasley';
  } else //{
    if ( IsA('FredWeasley') )
    {
      nameWeasley = 'GeorgeWeasley';
    } else {
      return None;
    }
  //}
  foreach AllActors(Class'Characters',Weasley)
  {
    if ( Weasley.IsA(nameWeasley) )
    {
      fDistToWeasley = VSize2D(Level.PlayerHarryActor.Location - Weasley.Location);
      if ( NearestWeasley == None )
      {
        fDistToNearestWeasley = fDistToWeasley;
        NearestWeasley = Weasley;
      } else //{
        if ( fDistToWeasley < fDistToNearestWeasley )
        {
          fDistToNearestWeasley = fDistToWeasley;
          NearestWeasley = Weasley;
        }
      //}
    }
  }
  return NearestWeasley;
}

function MakePurchase()
{
  local StatusManager managerStatus;
  local StatusItemWizardCards siWizardCards;
  local int nWizardCardId;
  local Class<Actor> classSpawn;
  local Actor aSpawnedObject;
  local Vector vSpawnLoc;
  local Rotator R;
  local Vector vTargetDir;
  local float fYawChange;

  switch (CharacterSells)
  {
    case Sells_Nimbus2001:
		harry(Level.PlayerHarryActor).bHaveNimbus2001 = True;
		classSpawn = Class'VendorNimbusBroom';
		break;
    case Sells_QArmor:
		harry(Level.PlayerHarryActor).bHaveQArmor = True;
		classSpawn = Class'QArmor';
		break;
    case Sells_WBark:
		classSpawn = Class'WiggentreeBark';
		--nCurrIngrCount;
		break;
    case Sells_FMucus:
		classSpawn = Class'FlobberwormMucus';
		--nCurrIngrCount;
		break;
    case Sells_BronzeCards:
		managerStatus = harry(Level.PlayerHarryActor).managerStatus;
		siWizardCards = StatusItemWizardCards(managerStatus.GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemBronzeCards'));
		siWizardCards.GetFirstVendorCardIdAndClass(nWizardCardId,classSpawn);
		break;
    case Sells_SilverCards:
		managerStatus = harry(Level.PlayerHarryActor).managerStatus;
		siWizardCards = StatusItemWizardCards(managerStatus.GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemSilverCards'));
		siWizardCards.GetFirstVendorCardIdAndClass(nWizardCardId,classSpawn);
		break;
    case Sells_Duel:
		break;
    default:
		break;
  }
  if ( classSpawn != None )
  {
    vSpawnLoc = Location;
    vSpawnLoc.Z += CollisionHeight / 4;
    vSpawnLoc += Normal(PlayerHarry.Location - Location) * (CollisionRadius + 10);
    vSpawnLoc.Z += CollisionHeight / 4;
    Spawn(Class'Spawn_flash_2',,,vSpawnLoc,rot(0,0,0));
    aSpawnedObject = FancySpawn(classSpawn,,,vSpawnLoc);
    R = rotator(PlayerHarry.Location - Location);
    fYawChange = RandRange(8192.0,18205.0);
    if ( Rand(2) == 0 )
    {
      fYawChange =  -fYawChange;
    }
    R.Yaw += fYawChange;
	vTargetDir = Normal(vector(R)); //UTPT didn't decompile this for some reason -AdamJD
    aSpawnedObject.Velocity = vTargetDir * RandRange(100.0,400.0);
    aSpawnedObject.SetPhysics(PHYS_Falling);
    if ( (CharacterSells == Sells_BronzeCards) || (CharacterSells == Sells_SilverCards) )
    {
      siWizardCards.SetCardOwner(nWizardCardId,siWizardCards.ECardOwner.CardOwner_None);
    }
    switch (CharacterSells)
    {
      case Sells_Nimbus2001:
      PlaySound(Sound'vendor_spawn_quid');
      break;
      case Sells_QArmor:
      PlaySound(Sound'vendor_spawn_quid');
      break;
      case Sells_WBark:
      PlaySound(Sound'vendor_spawn_ingred');
      break;
      case Sells_FMucus:
      PlaySound(Sound'vendor_spawn_ingred');
      break;
      case Sells_BronzeCards:
      PlaySound(Sound'vendor_spawn_WC');
      break;
      case Sells_SilverCards:
      PlaySound(Sound'vendor_spawn_WC');
      break;
      case Sells_Duel:
      PlaySound(Sound'vendor_spawn_WC');
      break;
      default:
	  PlaySound(Sound'vendor_spawn_ingred');
	  break;
    }
  }
}

function name GetTalkAnimName()
{
  switch (Rand(3))
  {
    case 0:
    return 'talk_bothhands';
    case 1:
    return 'talk_lhand';
    case 2:
    return 'talk_lhand';
    default:
  }
}

state VendorEngaged
{
ignores Bump;
}

state VendorGive
{
ignores Bump;

begin:
  PlayAnim('vendor_give',1.39999998,0.4);
  Sleep(0.75);
  MakePurchase();
  FinishAnim();
  CutNotifyActor.CutCue(strCueVendorGive);
}

function SayPopupLine (string strDialogID, string strCue, name nameAnim)
{
  local string strDialog;
  local float fSoundLen;
  local TimedCue tcue;

  strDialog = Localize("all",strDialogID,"HPdialog");
  soundCurrVendorPopup = Sound(DynamicLoadObject("AllDialog." $ strDialogID,Class'Sound'));
  if ( soundCurrVendorPopup != None )
  {
      fSoundLen = GetSoundDuration(soundCurrVendorPopup);
      // Omega: Slot_Talk plsssss
      PlaySound(soundCurrVendorPopup,Slot_Talk,,,10000.0,,True);
  } 
  else 
  {
      fSoundLen = (Len(strDialog) * 0.01) + 3.0;
  }
  //UTPT didn't decompile this for some reason -AdamJD
  strDialog = HandleFacialExpression(strDialog, fSoundLen);
  harry(Level.PlayerHarryActor).myHUD.SetSubtitleText(strDialog, fSoundLen);
  tcue = Spawn(class'TimedCue');
  tcue.CutNotifyActor = self;
  tcue.SetupTimer(fSoundLen + 0.50, strCue);
  PlayAnim(nameAnim,, 0.750, AT_Combine);
}

state SayVendorLureLine
{
  function CutCue (string strCue)
  {
    if ( strCue ~= strCUE_LURING_DONE )
    {
      DesiredRotation = rSave;
      GotoState('VendorIdle');
      if ( WeasleyTwin != None )
      {
        WeasleyTwin.DesiredRotation = WeasleyTwin.rSave;
        WeasleyTwin.GotoState('VendorIdle');
      }
    }
  }
  
  function BeginState()
  {
    InterruptOtherVendorPopup();
  }
  
  function EndState()
  {
  }
  
begin:  
  WeasleyTwin = GetWeasleyTwin();
  if ( WeasleyTwin != None )
  {
    WeasleyTwin.GotoState('stateIdle');
    WeasleyTwin.TurnToward(Level.PlayerHarryActor);
  }
  SayPopupLine(VendorDialog.strLureId,strCUE_LURING_DONE,'wave');
keep_facing_harry:
  if (  !IsAnimating() )
  {
    CurrIdleAnimName = GetCurrIdleAnimName();
    LoopAnim(CurrIdleAnimName,,[TweenTime]0.4);
  }
  TurnToward(Level.PlayerHarryActor);
  if ( WeasleyTwin != None )
  {
    WeasleyTwin.TurnToward(Level.PlayerHarryActor);
  }
  goto ('keep_facing_harry');
}

state SayOutOfStockLine
{
ignores Bump;

  function CutCue (string strCue)
  {
    if ( strCue ~= strCUE_OUT_OF_STOCK_DONE )
    {
      DesiredRotation = rSave;
      GotoState('VendorIdle');
      if ( WeasleyTwin != None )
      {
        WeasleyTwin.DesiredRotation = WeasleyTwin.rSave;
        WeasleyTwin.GotoState('VendorIdle');
      }
    }
  }
  
  function BeginState()
  {
    InterruptOtherVendorPopup();
  }
  
  function EndState()
  {
  }
  
begin:
  WeasleyTwin = GetWeasleyTwin();
  if ( WeasleyTwin != None )
  {
    WeasleyTwin.GotoState('stateIdle');
    WeasleyTwin.TurnToward(Level.PlayerHarryActor);
  }
  SayPopupLine(VendorDialog.strOutOfStockId,strCUE_OUT_OF_STOCK_DONE,GetTalkAnimName());
keep_facing_harry:
  if (  !IsAnimating() )
  {
    CurrIdleAnimName = GetCurrIdleAnimName();
    LoopAnim(CurrIdleAnimName,,[TweenTime]0.4);
  }
  TurnToward(Level.PlayerHarryActor);
  if ( WeasleyTwin != None )
  {
    WeasleyTwin.TurnToward(Level.PlayerHarryActor);
  }
  goto ('keep_facing_harry');
}

state VendorIdle
{
  //UTPT added this for some reason -AdamJD
  //ignores  Tick;
  
  function BeginState()
  {
    if (  !bHidden && (CharacterSells != Sells_Nothing) &&  !IsDuelVendor() )
    {
      VendorJellybean = Jellybean(FancySpawn(Class'Jellybean',self,,,Rotation));
      VendorJellybean.bPersistent = False;
      VendorJellybean.bAlignBottom = False;
      VendorJellybean.bRotateToDesired = False;
      VendorJellybean.SetPhysics(PHYS_None);
      VendorJellybean.SetCollision(False,False,False);
      VendorJellybean.DrawScale = 0.5;
    } else {
      GotoState('stateIdle');
    }
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick (float fDelta)
  {
	if ( VendorJellybean != None )
	{
		VendorJellybean.SetLocation(WeaponLoc + vect(0.00,0.00,4.00));
		VendorJellybean.SetRotation(WeaponRot);
	}
	Global.Tick(fDelta);
  }
  
  function EndState()
  {
    if ( VendorJellybean != None )
    {
      VendorJellybean.Destroy();
    }
  }
  
begin:
  do
  {
	  PlayAnim('vendor_idle',RandRange(0.75,1.29999995),0.2);
	  FinishAnim();
  }
  until(False);
}

auto state patrol
{
  function startup()
  {
    if ( CharacterSells != Sells_Nothing )
    {
      GotoState('VendorIdle');
    } else {
      Super.startup();
    }
  }
  
}

function bool IsDuelVendor()
{
  if ( CharacterSells != Sells_Duel )
  {
    return False;
  }
  if ( DuelRank <= 0 )
  {
    return False;
  }
  if ( DuelRank > 10 )
  {
    return False;
  }
  return True;
}

function SetEverythingForTheDuel()
{
  local string DuelLevelName;
  local int nGameState;

  if ( PlayerHarry.bIsGoyle )
  {
    return;
  }
  if ( DuelRank <= 0 )
  {
    return;
  }
  if ( DuelRank > 10 )
  {
    return;
  }
  if ( DuelRank > PlayerHarry.DuelRankHarry )
  {
    return;
  }
  nGameState = PlayerHarry.ConvertGameStateToNumber();
  if ( nGameState < 80 )
  {
    return;
  }
  if ( nGameState == 120 )
  {
    return;
  }
  if ( nGameState == 150 )
  {
    return;
  }
  if ( nGameState == 160 )
  {
    return;
  }
  if ( nGameState == 170 )
  {
    return;
  }
  bHidden = False;
  SetCollision(True,True,True);
  switch (DuelRank)
  {
    case 1:
		DuelBeans = 10;
		DuelLevelName = "Duel01";
		Mesh = SkeletalMesh'skhp2_genmale2Mesh';
		MultiSkins[0] = Texture'skhp2_genmale1_1Tex0';
		MultiSkins[1] = Texture'skhp2_genmale1_1Tex1';
		break;
    case 2:
		DuelBeans = 15;
		DuelLevelName = "Duel02";
		Mesh = SkeletalMesh'skhp2_genfemale1Mesh';
		MultiSkins[0] = Texture'skhp2_genfemale1_6Tex0';
		MultiSkins[1] = Texture'skhp2_genfemale1_6Tex1';
		break;
    case 3:
		DuelBeans = 20;
		DuelLevelName = "Duel03";
		Mesh = SkeletalMesh'skhp2_genfemale1Mesh';
		MultiSkins[0] = Texture'skhp2_genfemale1_4Tex0';
		MultiSkins[1] = Texture'skhp2_genfemale1_4Tex1';
		break;
    case 4:
		DuelBeans = 25;
		DuelLevelName = "Duel04";
		Mesh = SkeletalMesh'skhp2_genmale2Mesh';
		MultiSkins[0] = Texture'skhp2_genmale1_3Tex0';
		MultiSkins[1] = Texture'skhp2_genmale1_3Tex1';
		break;
    case 5:
		DuelBeans = 35;
		DuelLevelName = "Duel05";
		Mesh = SkeletalMesh'skhp2_genmale1Mesh';
		MultiSkins[0] = Texture'skhp2_genmale1_0Tex0';
		MultiSkins[1] = Texture'skhp2_genmale1_0Tex1';
		break;
    case 6:
		DuelBeans = 50;
		DuelLevelName = "Duel06";
		Mesh = SkeletalMesh'skhp2_genfemale2Mesh';
		MultiSkins[0] = Texture'skhp2_genfemale1_3Tex0';
		MultiSkins[1] = Texture'skhp2_genfemale1_3Tex1';
		break;
    case 7:
		DuelBeans = 70;
		DuelLevelName = "Duel07";
		Mesh = SkeletalMesh'skhp2_genmale2Mesh';
		MultiSkins[0] = Texture'skhp2_genmale1_7Tex0';
		MultiSkins[1] = Texture'skhp2_genmale1_7Tex1';
		break;
    case 8:
		DuelBeans = 100;
		DuelLevelName = "Duel08";
		Mesh = SkeletalMesh'skhp2_genfemale1Mesh';
		MultiSkins[0] = Texture'skhp2_genfemale1_2Tex0';
		MultiSkins[1] = Texture'skhp2_genfemale1_2Tex1';
		break;
    case 9:
		DuelBeans = 150;
		DuelLevelName = "Duel09";
		Mesh = SkeletalMesh'skhp2_genfemale1Mesh';
		MultiSkins[0] = Texture'skhp2_genfemale1_0Tex0';
		MultiSkins[1] = Texture'skhp2_genfemale1_0Tex1';
		break;
    case 10:
		DuelBeans = 200;
		DuelLevelName = "Duel10";
		Mesh = SkeletalMesh'skhp2_genmale1Mesh';
		MultiSkins[0] = Texture'skhp2_genmale1_2Tex0';
		MultiSkins[1] = Texture'skhp2_genmale1_2Tex1';
		break;
    default:
		DuelBeans = 0;
		DuelLevelName = "";
		break;
  }
  if ( DuelLevelTrigger == None )
  {
    DuelLevelTrigger = Spawn(Class'TriggerChangeLevel',,,);
  }
  if ( DuelLevelTrigger != None )
  {
    DuelLevelTrigger.NewMapName = DuelLevelName;
    DuelLevelTrigger.SetCollision(False,False,False);
  }
}

defaultproperties
{
    // CharacterSells=7
	CharacterSells=Sells_Nothing

    // VendorDialogSet=7
	VendorDialogSet=VDialog_None

    nPriceNimbus2001=700

    nPriceQArmor=500

    nPriceWBark=75

    nPriceFMucus=50

    nPriceBronzeCardsMin=120

    nPriceBronzeCardsMax=230

    nPriceSilverCardsMin=200

    nPriceSilverCardsMax=300

    nLureDistance=300

    nFMucusInventoryMin=2

    nFMucusInventoryMax=5

    nWBarkInventoryMin=2

    nWBarkInventoryMax=5

    bSnapToPatrolPoint=True

    bDoEyeBlinks=True
}
