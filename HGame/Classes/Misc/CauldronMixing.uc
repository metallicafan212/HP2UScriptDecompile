//================================================================================
// CauldronMixing.
//================================================================================

class CauldronMixing extends HCauldron;

const strCUE_CAULDRON_NOT_AVAIL_LINE= "_MixingCauldronsNotAvailableYet";
const nPOTIONS_AVAILABLE_STATE= 40;
const strTEMP_CAULDRON_CUT_NAME= "TempMixingCauldronCutName";
const TOP_OF_CAULDRON_OFFSET= 25;
enum ECauldronFX {
  CauldronFX_Neutral,
  CauldronFX_Mixed
};

enum EStartMixOn {
  StartMixOn_Trigger,
  StartMixOn_Bump
};
var StatusGroup sgPotionIngr;
var StatusGroup sgPotions;
var StatusItem siWiggenBark;
var StatusItem siFlobberMucus;
var HProp propTemp;
var Vector vFlobberHudLoc;
var Vector vWiggenHudLoc;
var Vector vWWellPotionHudLoc;
var Vector vTopOfCauldron;
var int nPotionCount;
var int I;
var Rotator R;
var Vector vTargetDir;
var float fYawChange;
var() EStartMixOn StartMixOn;
var() bool bMixingEnabled;


event PostBeginPlay()
{
  Super.PostBeginPlay();
  sgPotionIngr = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupPotionIngr');
  sgPotions = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupPotions');
  siWiggenBark = sgPotionIngr.GetStatusItem(Class'StatusItemWiggenBark');
  siFlobberMucus = sgPotionIngr.GetStatusItem(Class'StatusItemFlobberMucus');
}

event Trigger (Actor Other, Pawn EventInstigator)
{
  if ( bMixingEnabled && StartMixOn == StartMixOn_Trigger && HaveWiggenPotionIngredients() )
  {
    GotoState('Mixing');
  }
}

event Bump (Actor Other)
{
  local int nGameState;

  nGameState = PlayerHarry.ConvertGameStateToNumber();
  if ( nGameState < 40 )
  {
    GotoState('CauldronsNotAvailableYet');
  } else //{
    if ( bMixingEnabled && StartMixOn == StartMixOn_Bump && HaveWiggenPotionIngredients() )
    {
      TriggerEvent(Event,None,None);
      GotoState('Mixing');
    }
  //}
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string sCutName;
  local Actor A;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    return Super.CutCommand(Command,cue,bFastFlag);
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      return Super.CutCommand(Command,cue,bFastFlag);
    } else //{
      if ( sActualCommand ~= "Enable" )
      {
        bMixingEnabled = True;
        CutNotifyActor.CutCue(cue);
        return True;
      } else //{
        if ( sActualCommand ~= "Disable" )
        {
          bMixingEnabled = False;
          CutNotifyActor.CutCue(cue);
          return True;
        } else {
          return Super.CutCommand(Command,cue,bFastFlag);
        }
      //}
    //}
  //}
}

function SetCauldronFX (ECauldronFX FX)
{
  local Vector vOffset;

  killAttachedParticleFX(0.0);
  vOffset.X = 0.0;
  vOffset.Y = 0.0;
  vOffset.Z = 25.0;
  attachedParticleOffset[0] = vOffset;
  switch (FX)
  {
    // case 0:
	case CauldronFX_Neutral:
    attachedParticleClass[0] = Class'Cauldron_Neutral';
    break;
    // case 1:
	case CauldronFX_Mixed:
    attachedParticleClass[0] = Class'Cauldron_Mixed';
    break;
    default:
    Log("ERROR: Invalid cauldron fx");
    break;
  }
  CreateAttachedParticleFX();
}

function int GetNumPotionsToMake()
{
  return Min(siWiggenBark.nCount,siFlobberMucus.nCount);
}

function bool HaveWiggenPotionIngredients()
{
  return (siWiggenBark.nCount >= 1) && (siFlobberMucus.nCount >= 1);
}

auto state Idle
{
  event BeginState()
  {
    Super.BeginState();
    // SetCauldronFX(0);
	SetCauldronFX(CauldronFX_Neutral);
  }
  
}

state CauldronsNotAvailableYet
{
ignores Bump;
  function CutCue (string cue)
  {
    if ( cue ~= "_MixingCauldronsNotAvailableYet" )
    {
      GotoState('Idle');
    }
  }
  
  event BeginState()
  {
    local string strDialog;
    local string strDialogID;
    local float fSoundLen;
    local TimedCue tcue;
  
    if ( Rand(2) == 0 )
    {
      strDialogID = "Shared_Menu_0009";
    } else {
      strDialogID = "Shared_Menu_0010";
    }
    strDialog = Localize("All",strDialogID,"HPMenu");
    fSoundLen = Len(strDialog) * 0.01 + 3.0;
    tcue = Spawn(Class'TimedCue');
    tcue.CutNotifyActor = self;
    tcue.SetupTimer(fSoundLen + 0.5,"_MixingCauldronsNotAvailableYet");
    harry(Level.PlayerHarryActor).myHUD.SetSubtitleText(strDialog,fSoundLen);
  }
  
}

state Mixing
{
ignores Bump;
begin:
  PlayerHarry.DoPotionMixingBegin();
  sgPotionIngr.SetEffectTypeToPermanent();
  sgPotions.SetEffectTypeToPermanent();
  sgPotionIngr.SetCutSceneRenderMode(True);
  sgPotions.SetCutSceneRenderMode(True);
  Sleep(0.5);
  vTopOfCauldron = Location;
  vTopOfCauldron.Z += 40;
  nPotionCount = GetNumPotionsToMake();
  // I = 0;
  // if ( I < nPotionCount )
  for(I = 0; I < nPotionCount; I++)
  {
    vFlobberHudLoc = sgPotionIngr.GetItemLocation(Class'StatusItemFlobberMucus',False);
    propTemp = HProp(FancySpawn(Class'FlobberwormMucus',,,vFlobberHudLoc));
    propTemp.fMinFlyToHudScale = 0.1;
    propTemp.fMaxFlyToHudScale = 0.41;
    propTemp.DoDropOffProp(vTopOfCauldron,True);
    Sleep(0.1);
    vWiggenHudLoc = sgPotionIngr.GetItemLocation(Class'StatusItemWiggenBark',False);
    propTemp = HProp(FancySpawn(Class'WiggentreeBark',,,vFlobberHudLoc));
    propTemp.fMinFlyToHudScale = 0.1;
    propTemp.fMaxFlyToHudScale = 0.41;
    propTemp.DoDropOffProp(vTopOfCauldron,True);
    Sleep(0.1);
    // I++;
    // goto JL0082;
  }
  PlayerHarry.DoPotionMixingStir();
  Sleep(1.0);
  // I = 0;
  // if ( I < nPotionCount )
  for(I = 0; I < nPotionCount; I++)
  {
    vWWellPotionHudLoc = sgPotions.GetItemLocation(Class'StatusItemWiggenwell',False);
    propTemp = HProp(FancySpawn(Class'WWellCauldronBottle',,,vTopOfCauldron));
    Sleep(0.25);
    propTemp.fTotalFlyTime = 0.5;
    propTemp.fMinFlyToHudScale = 0.81;
    propTemp.DoPickupProp();
    Sleep(0.25);
    // I++;
    // goto JL01B3;
  }
  // SetCauldronFX(1);
  SetCauldronFX(CauldronFX_Mixed);
  Sleep(0.31);
  PlayerHarry.DoPotionMixingIdle();
  PlaySound(Sound'Potion_complete');
  PlayerHarry.DoPotionMixingEnd();
  Sleep(4.5);
  sgPotionIngr.SetCutSceneRenderModeToNormal();
  sgPotions.SetCutSceneRenderModeToNormal();
  sgPotionIngr.SetEffectTypeToNormal();
  sgPotions.SetEffectTypeToNormal();
  GotoState('Idle');
}

defaultproperties
{
    bMixingEnabled=True

    Mesh=SkeletalMesh'HProps.skCauldronTeacherMesh'

    CollisionRadius=15.00

    CollisionHeight=100.00

}
