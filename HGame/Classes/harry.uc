//================================================================================
// harry.
//================================================================================ 

class harry extends PlayerPawn
  Config(User);    

const nSPONGIFY_CHALLENGE_IDX= 3;
const nDIFFINDO_CHALLENGE_IDX= 2;  
const nSKURGE_CHALLENGE_IDX= 1;
const nRICTUSEMPRA_CHALLENGE_IDX= 0;
struct ChallengeScoreType  
{  
  var int nHighScore;
  var int nMaxScore; 
};  

struct QuidGameResult 
{
  var string Opponent;
  var int myScore;
  var int OpponentScore;
  var int HousePoints;
  var bool bLocked;
  var bool bWon;
}; 

const FALL_DAMAGE_DISTANCE= 512;
const NUM_HARRY_ANIM_SETS= 6;
enum enumHarryAnimSet {
  HARRY_ANIM_SET_MAIN,
  HARRY_ANIM_SET_ECTO,
  HARRY_ANIM_SET_SLEEPY,
  HARRY_ANIM_SET_SWORD,
  HARRY_ANIM_SET_WEB,
  HARRY_ANIM_SET_DUEL
};

struct cHarryAnims
{
  var name Idle;
  var name Walk;
  var name run;
  var name WalkBack;
  var name StrafeRight;
  var name StrafeLeft;
  var name Jump;
  var name Jump2;
  var name Fall;
  var name Land;
};

const NUM_SPONGIFY_FX= 2;
const NUM_DUEL_SPELLS= 3;
const MAX_NUM_SPELLS= 32; 
struct WCardSaveData
{
  var int nCardId;
  var int nCardOwner;
};

struct StatusSaveData
{
  var Class<StatusGroup> classGroup;
  var Class<StatusItem> classItem;
  var int nPotential;
  var int nCount;
  var int nMaxCount;
};

const NUM_HURT_SOUNDS= 15;
var globalconfig bool bAutoCenterCamera;
var globalconfig bool bMoveWhileCasting;
var globalconfig bool bAutoQuaff;
var globalconfig bool bWithOlly;
var bool bMapQuickLook;
var(Sounds) Sound drown;
var(Sounds) Sound breathagain;
var(Sounds) Sound HitSound3;
var(Sounds) Sound HitSound4;
var(Sounds) Sound Die2;
var(Sounds) Sound Die3;
var(Sounds) Sound Die4;
var(Sounds) Sound GaspSound;
var(Sounds) Sound UWHit1;
var(Sounds) Sound UWHit2;
var(Sounds) Sound LandGrunt;
var(Sounds) Sound Speech[20];
var(Display) const Class<Decal> ShadowClass;
var bool bLastJumpAlt;
var bool b3DSound;
var globalconfig int AnnouncerVolume;
var string eaid;
var Sound HurtSound[15];
var input float aBroomYaw;
var input float aBroomPitch;
var input float aJoyBroomYaw;
var input float aJoyBroomPitch;
var input float aSpellLessonX;
var input float aSpellLessonY;
var input byte bBroomYawLeft;
var input byte bBroomYawRight;
var input byte bBroomPitchUp;
var input byte bBroomPitchDown;
var input byte bBroomBoost;
var input byte bBroomBrake;
var input byte bBroomAction;
var input byte bDrinkWiggenwell;
var input byte bSpellBallAction;
var input byte bVendorReply;
var input byte bDuelRictusempra;
var input byte bDuelMimblewimble;
var input byte bDuelExpelliarmus;
var input byte bDuelCycleSpell;
var input byte bSpellLessonLeft;
var input byte bSpellLessonRight;
var input byte bSpellLessonUp;
var input byte bSpellLessonDown;
var input byte bOpenMap;
var input byte bSkipCutScene;
var globalconfig bool bInvertBroomPitch;
var globalconfig bool bAllowBroomMouse;
var(Movement) float turnRate;
var SpellCursor SpellCursor;
var Rotator AimRotOffset;
var bool bSkipKeyPressed;
var travel int numHousePointsHarry;
var int numHousePointsGryffindor;
var int numHousePointsSlytherin;
var int numHousePointsHufflepuff;
var int numHousePointsRavenclaw;
var int numLastHousePointsHarry;
var(HousePoints) const int maxPointsPerHouse;
var(HousePoints) const int HarryMultipleForGryffindor;
var(HarryTut) name TriggerToSendOnFirstBean;
var(HarryTut) bool bLockOutForward;
var(HarryTut) bool bLockOutBackward;
var(HarryTut) bool bLockOutStrafeLeft;
var(HarryTut) bool bLockOutStrafeRight;
var Director Director;
var Adv1TutManager Adv1TutManager;
var travel StatusSaveData StatusSave[30];
var travel WCardSaveData BronzeCardSave[50];
var travel WCardSaveData SilverCardSave[40];
var travel WCardSaveData GoldCardSave[11];
var travel int nLastCardTypeSave;
var StatusManager managerStatus;
var FEBook menuBook;
var travel bool bHaveNimbus2001;
var travel bool bHaveQArmor;
var travel Class<baseSpell> SpellBook[32];
var bool bNoSpellBookCheck;
var bool bDuelIsOver;
var bool bInDuelingMode;
var bool bSpellCyclePressed;
var bool bReboundingSpells;
var HPawn DuelOpponent;
var int CurrentDuelSpell;
var Class<baseSpell> DuelSpells[3];
var Sound DuelSpellSwitchSounds[3];
var float fTimeAfterHit;
var int nHealthSave;
var float fTimeAfterShield;
var travel int DuelRankHarry;
var travel int DuelRankOppon;
var travel int DuelRankBeans;
var globalconfig bool bDisableDialog;
var ParticleFX SpongifyFX[2];
var bool ClearMessages;
var int stillDistance;
var int movingDistance;
var int hiddenDistance;
var Actor bustedBy;
var Vector TargetOffset;
var bool bMovingBackwards;
var Actor focusActor;
var HPawn foreachActor;
var bool bVeryAfraid;
var int beansoundCount;
var float LessonScore;
var float LessonPass;
var int iLevelReached;
var int iLessonPoints;
var globalconfig float fDamageMultiplier_Easy;
var globalconfig float fDamageMultiplier_Medium;
var globalconfig float fDamageMultiplier_Hard;
var float fMinDamageScalar;
var SpongifyPad HitSpongifyPad;
var bool bExtendedTargetting;
var BaseCam Cam;
var bool bHarryMovingNotAiming;
var bool bRapidCasting;
var bool bIsAiming;
var bool bIsAimingWithCharge;
var bool bLockedOnTarget;
var HChar BossTarget;
var HPawn HearHarryRecipient;
var bool bCastFastSpells;
var bool bKeepStationary;
var bool bFixedFaceDirection;
var Vector vFixedFaceDirection;
var bool bStationary;
var bool bTargettingError;
var float fLargestAForward;
var Actor CarryingActor;
var Actor ActorToCarry;
var cHarryAnimChannel HarryAnimChannel;
var bool bThrow;
var bool bCanCast;
var float fTimeLastDrank;
var bool bHarryUsingSword;
var bool bMSword;
var EAnimType HarryAnimType;
var name SpongifyFallAnim;
var name AnimFalling;
var() bool bNoFallingDamage;
var float NoFallingDamageTimer;
var cHarryAnims HarryAnims[6];
var enumHarryAnimSet HarryAnimSet;
var float LastAnimFrame;
var Vector vAdditionalAccel;
var bool bTempKillHarry;
var bool bAllowHarryToDie;
var bool bScreenRelativeMovement;
var int ScreenRelativeMovementYaw;
var bool bReverseInput;
var float fTimeWalking;
var bool underAttack;
var Actor attacker;
var Vector lookhere;
var bool bClubDeath;
var bool bInstantDeath;
var bool bSlowDeath;
var bool bConstrainYaw;
var int ConstrainYawVariance;
var name LastState;
var int ShortCutNum;
var float _LastKeyPressTime;
var int _iCurrentStringChar;
var string _CurrentString;
var bool bInSneak;
var bool bIsCrouching;
var bool bIsTurning;
var bool bAnimTransition;
var int WaitingCount;
var byte LastbLook;
var bool bFallingMount;
var bool bIsPickingUpWizardCard;
var bool bPlayedFallSound;
var float fTimeToStop;
var bool bOldStrafingState;
var float fOldGroundSpeed;
var bool bEndedWizCardPickup;
var Vector ChessTargetLocation;
var float fTimeInAir;
var EPhysics eLastPhysState;
var float fFallingZ;
var(Movement) float GroundJumpSpeed;
var Vector MountDelta;
var Actor MountBase;
var int iEctoRefCount;
var float GroundEctoSpeed;
var bool bPlayedEctoKnockBack;
var int iEctoHurtSoundCount;
var bool bEctoFlashed;
var int iSleepyAnimTimer;
var int iMaxSleepyAnim;
var float fSleepySpeed;
var int iWebAnimRefCount;
var float fWebSpeed;
var float fTimeSinceLastAcidHit;
var float fStirSoundDuration;
var Sound soundStirPotion;
var bool bE3DemoLockout;
var travel string PreviousLevelName;
var SpellLessonTrigger CurrSpellLesson;
var VendorManager CurrVendorManager;
var float FootOffsetZ;
var bool bFraserMode;
var bool bFinishPickBitOfGoyle;
var bool bIsGoyle;
var name CurrFidgetAnimName;
var name CurrIdleAnimName;
var int FidgetNums;
var int IdleNums;
var float fHighestZ;
var travel string strObjectiveId;
var travel bool bHub9CeremonyFlag;
var SpellSelector HudSpellSelector;
var bool bDisplayedFirstErrorMessages;
var travel bool bSaidVendorInstructions;
var int nCelebrateProgress;
var bool bCelebrateBronze;
var int nPlayerCaptureCount;
var travel int curQuidMatchNum;
var travel QuidGameResult quidGameResults[6];
var travel int curWizardDuel;
var travel int curWizardDuelRank;
var travel int lastUnlockedDuelist;
var travel ChallengeScoreType ChallengeScores[4];
var bool bForceBlackScreen;
var travel bool bHarryKilled;
var int iMinHealthAfterDeath;

/*
event PreBeginPlay ()
{
  Super.PreBeginPlay();
  foreach AllActors(Class'Director',Director)
  {
    //goto JL001A;
	break;
  }
  SpellCursor = Spawn(Class'SpellCursor');
  if ( managerStatus == None )
  {
    managerStatus = Spawn(Class'StatusManager');
    managerStatus.PlayerHarry = self;
    managerStatus.CreateStartupItems();
  }
  AddToSpellBook(Class'spellFlipendo');
  AddToSpellBook(Class'spellLumos');
  AddToSpellBook(Class'spellAlohomora');
  bNoSpellBookCheck = False;
  menuBook = HPConsole(Player.Console).menuBook;
}
*/

event PreBeginPlay()
{
	// Initialize
	Super.PreBeginPlay();

/*
	//If collision values are true, spawn will fail cause it tries to spawn HarryPawn where Harry is standing.
	// Something somewhere will set these to true again, but we set them to false again in PlayerWalking::BeginState.
	SetCollision(false,false,false);

	foreach AllActors(class'HarryPawn', HarryPawn)
		break;

	if( HarryPawn == none )
	{
		HarryPawn = spawn( class'HarryPawn' );

		if( HarryPawn == none )
			ClientMessage("Error:  Couldn't make a HarryPawn puppet.");
	}
	else
	{
		ClientMessage("HarryPawn already in map");
	}
*/	

	// Find mini-game director, if any
	foreach AllActors( class'Director', Director )
		break;

	// Create the Spell Cursor
	SpellCursor = spawn(class'SpellCursor');

	// Create StatusManager
	if(managerStatus == None)
	{
		managerStatus = spawn(class'StatusManager');

		// Save off reference to harry in status manager
		managerStatus.PlayerHarry = self;

		// Create status items that need to exist at startup. Other status items
		// will get created as an attempt to access them is made.  
		managerStatus.CreateStartupItems();
	}

	// Make sure Harry has the default spells
	AddToSpellBook( class'spellFlipendo'		); // 1 - pushes things
	AddToSpellBook( class'spellLumos'			); // 2 - lights up your wand
	AddToSpellBook( class'spellAlohomora'		); // 3 - unlock doors, secret areas
	
	// Reset our NoSpellBookCheck
	bNoSpellBookCheck = false;
	
	menuBook = HPConsole(Player.Console).menuBook;
}

/*
function PostBeginPlay ()
{
  local Pawn p;
  local Actor A;
  local Actor a2;
  local Duellist D;
  local string AnimName;
  local int I;
  local name nm;

  Super.PostBeginPlay();
  FidgetNums = 0;
  I = 1;
  JL0014:
  if ( I <= 16 )
  {
    AnimName = "fidget_" $ string(I);
    nm = StringToAnimName(AnimName);
    if ( nm == 'None' )
    {
      FidgetNums = I - 1;
    } else {
      I++;
      goto JL0014;
    }
  }
  IdleNums = 0;
  I = 1;
  JL0080:
  if ( I <= 16 )
  {
    AnimName = "idle_" $ string(I);
    nm = StringToAnimName(AnimName);
    if ( nm == 'None' )
    {
      IdleNums = I - 1;
    } else {
      I++;
      goto JL0080;
    }
  }
  bShowMenu = False;
  HUDType = Class'HPHud';
  foreach AllActors(Class'BaseCam',Cam)
  {
    //goto JL0103;
	break;
  }
  if ( Cam == None )
  {
    Cam = Spawn(Class'BaseCam');
  }
  ViewClass(Class'BaseCam',True);
  b3DSound = bool(ConsoleCommand("get ini:Engine.Engine.AudioDevice Use3dHardware"));
  Shadow = Spawn(ShadowClass,self);
  Log(string(self) $ " ShadowClass=" $ string(ShadowClass) $ " shadow=" $ string(Shadow) $ " tex=" $ string(Shadow.Texture));
  HarryAnimChannel = cHarryAnimChannel(CreateAnimChannel(Class'cHarryAnimChannel',AT_Replace,'bip01 Spine1'));
  HarryAnimChannel.SetOwner(self);
  fTimeLastDrank = -1.0;
  SetTimer(1.0,True);
  CopyAllStatusFromHarryToManager();
}
*/

function PostBeginPlay()
{
    local Pawn p;
	local actor a, a2;
	local Duellist d;

	local string animName;
	local int	i;
	local name	nm;


	Super.PostBeginPlay();

    //ClientMessage(self $" In PostBeginPlay*******************************");
    //log(self $" In PostBeginPlay*******************************");

	FidgetNums = 0;
	for ( i = 1; i <= 16; i++)
	{
		animName = "fidget_" $i;
		nm = StringToAnimName(animName);
		if(nm == '')
		{
			FidgetNums = i - 1;
			break;
		}
	}

	IdleNums = 0;
	for ( i = 1; i <= 16; i++)
	{
		animName = "idle_" $i;
		nm = StringToAnimName(animName);
		if(nm == '')
		{
			IdleNums = i - 1;
			break;
		}
	}

	bShowMenu=false;

	HUDType=class'HPHud';
	

	//If there's no camera, make one.
	ForEach AllActors( class'BaseCam', cam )
		break;
	if( cam == none )
		cam = spawn( class'BaseCam' );
		
	// Metallicafan212:	Correct the fov
	Cam.SetFOV(90.0);

	viewClass(class'BaseCam', true);

  	// @PAB added new camera target
	// 	makeCamTarget();	

	//ForEach AllActors(class'actor', a)
	//	Log("******* Actor:"$a.name);

	b3DSound = bool(ConsoleCommand("get ini:Engine.Engine.AudioDevice Use3dHardware"));

	//iFireSeedCount = 0;

	// Harry gets a shadow, bigger than normal.
	Shadow = Spawn(ShadowClass,self);
	log( self$ " ShadowClass=" $ShadowClass$ " shadow=" $Shadow$ " tex=" $Shadow.Texture );

	// @PAB temp give a spell to Harry
	//	baseWand(weap).addSpell(Class'spellDud');
	//	baseWand(weap).addSpell(Class'spellflip');
	//	baseWand(weap).addSpell(Class'spellALOho');
	//	baseWand(weap).SelectSpell(Class'spellFlip');

	HarryAnimChannel = cHarryAnimChannel( CreateAnimChannel(class'cHarryAnimChannel', AT_Replace, 'bip01 spine1') );
	HarryAnimChannel.SetOwner( self );

	fTimeLastDrank = -1.0;
	
	// Adding a timer to Harry. 
	// Looping timer with a duration of 1 sec. Leave this as is. 
	SetTimer(1.0, true);



    // Fill in status manager stuff from save game
    CopyAllStatusFromHarryToManager();
}

event Possess ()
{
  Super.Possess();
  if ( Director != None )
  {
    Director.OnPlayerPossessed();
  }
}

function DisablePlayerInput ()
{
  SendPlayerCaptureMessages(True);
  bIsCaptured = True;
  myHUD.StartCutScene();
  bKeepStationary = True;
}

function EnablePlayerInput ()
{
  bIsCaptured = False;
  myHUD.EndCutScene();
  bKeepStationary = False;
  SendPlayerCaptureMessages(False);
}

function bool InputIsDisabled ()
{
  return bKeepStationary;
}

function OnEvent (name EventName)
{
  if ( EventName == 'LumosOff' )
  {
    baseWand(Weapon).TheLumosLight.TurnOff();
  }
  Super.OnEvent(EventName);
}

function PlayPeevesHack ()
{
}

/*
function AddToSpellBook (Class<baseSpell> spellClass)
{
  if ( spellClass.Default.SpellType < 32) && (SpellBook[spellClass.Default.SpellType] == None) )
  {
    SpellBook[spellClass.Default.SpellType] = spellClass;
  }
}
*/
function AddToSpellBook( class<baseSpell> spellClass )
{
	if( spellClass.default.spellType < MAX_NUM_SPELLS && 
		SpellBook[ spellClass.default.spellType ] == None )
	{
		// Add this spell
		SpellBook[ spellClass.default.spellType ] = spellClass;
	}
}

function bool IsInSpellBook (ESpellType ESpellType)
{
  if ( ESpellType >= 32 )
  {
    return False;
  }
  if ( bNoSpellBookCheck )
  {
    return True;
  }
  return SpellBook[ESpellType] != None;
}

function AddAllSpellsToSpellBook ()
{
  AddToSpellBook(Class'spellFlipendo');
  AddToSpellBook(Class'spellLumos');
  AddToSpellBook(Class'spellAlohomora');
  AddToSpellBook(Class'spellSkurge');
  AddToSpellBook(Class'spellRictusempra');
  AddToSpellBook(Class'spellDiffindo');
  AddToSpellBook(Class'spellSpongify');
  AddToSpellBook(Class'spellDuelRictusempra');
  AddToSpellBook(Class'spellDuelMimblewimble');
  AddToSpellBook(Class'spellDuelExpelliarmus');
}

function AddToSpellBookByString (string SpellName)
{
  switch (SpellName)
  {
    case "Flipendo":
    AddToSpellBook(Class'spellFlipendo');
    break;
    case "Lumos":
    AddToSpellBook(Class'spellLumos');
    break;
    case "Alohomora":
    AddToSpellBook(Class'spellAlohomora');
    break;
    case "Skurge":
    AddToSpellBook(Class'spellSkurge');
    break;
    case "Rictusempra":
    AddToSpellBook(Class'spellRictusempra');
    break;
    case "Diffindo":
    AddToSpellBook(Class'spellDiffindo');
    break;
    case "Spongify":
    AddToSpellBook(Class'spellSpongify');
    break;
    case "DuelRictusempra":
    AddToSpellBook(Class'spellDuelRictusempra');
    break;
    case "DuelMimblewimble":
    AddToSpellBook(Class'spellDuelMimblewimble');
    break;
    case "DuelExpelliarmus":
    AddToSpellBook(Class'spellDuelExpelliarmus');
    break;
    default:
  }
}

/*
function ClearSpellBook ()
{
  local int I;

  I = 0;
  JL0007:
  if ( I < 32 - 1 )
  {
    SpellBook[I] = None;
    ++I;
    goto JL0007;
  }
}
*/
function ClearSpellBook()
{
	local int i;
	for(i=0; i < MAX_NUM_SPELLS-1; ++i)
		SpellBook[i] = None;
}

function TurnOnDuelingMode (HPawn PawnOpponent)
{
  local Rotator R;
  local int nMaxHealth;

  bDuelIsOver = False;
  bInDuelingMode = True;
  DuelOpponent = PawnOpponent;
  Cam.SetCameraMode(Cam.ECamMode.CM_Dueling);
  Cam.SetYaw(0.0);
  Cam.SetPitch(-3500.0);
  Cam.SetFOV(50.0);
  R = Rotation;
  R.Yaw = 0;
  SetRotation(R);
  DesiredRotation = R;
  nHealthSave = managerStatus.GetHealthCount();
  nMaxHealth = managerStatus.GetHealthPotentialCount();
  managerStatus.SetHealthCount(nMaxHealth);
  Duellist(DuelOpponent).nMaxHealth = nMaxHealth;
  DuelOpponent.Health = nMaxHealth;
  HarryAnimSet = HARRY_ANIM_SET_DUEL;
  SpellCursor.bInvisibleCursor = True;
  baseWand(Weapon).StartGlowingWand(DuelSpells[CurrentDuelSpell]);
  if ( HudSpellSelector == None )
  {
    HudSpellSelector = SpellSelector(FancySpawn(Class'SpellSelector'));
  }
  Duellist(DuelOpponent).SetHealthBar();
}

function TurnOffDuelingMode ()
{
  bInDuelingMode = False;
  Duellist(DuelOpponent).TurnOffSpellCursor();
  DuelOpponent.GotoState('stateIdle');
  DuelOpponent.Health = 0;
  Cam.SetCameraMode(Cam.ECamMode.CM_Standard);
  Cam.SetFOV(90.0);
  managerStatus.SetHealthCount(nHealthSave);
  HarryAnimSet = HARRY_ANIM_SET_MAIN;
  SpellCursor.bInvisibleCursor = False;
  baseWand(Weapon).StopGlowingWand();
  HudSpellSelector.Destroy();
  HudSpellSelector = None;
}

function HandleDuelPlayerInput ()
{
  if ( bDuelCycleSpell == 1 )
  {
    bSpellCyclePressed = True;
  } else //{
    if ( bSpellCyclePressed )
    {
      bSpellCyclePressed = False;
      CurrentDuelSpell = CurrentDuelSpell + 1;
      if ( CurrentDuelSpell > 3 - 1 )
      {
        CurrentDuelSpell = 0;
      }
      baseWand(Weapon).StartGlowingWand(DuelSpells[CurrentDuelSpell]);
      PlaySound(DuelSpellSwitchSounds[CurrentDuelSpell]);
    } else //{
      if ( bDuelRictusempra == 1 )
      {
        CurrentDuelSpell = 0;
        baseWand(Weapon).StartGlowingWand(DuelSpells[CurrentDuelSpell]);
        PlaySound(Sound'Dueling_switch2RIC');
      } else //{
        if ( bDuelMimblewimble == 1 )
        {
          CurrentDuelSpell = 1;
          baseWand(Weapon).StartGlowingWand(DuelSpells[CurrentDuelSpell]);
          PlaySound(Sound'Dueling_switch2MIM');
        } else //{
          if ( bDuelExpelliarmus == 1 )
          {
            CurrentDuelSpell = 2;
            baseWand(Weapon).StartGlowingWand(DuelSpells[CurrentDuelSpell]);
            PlaySound(Sound'Dueling_switch2EXP');
          }
        //}
      //}
    //}
  //}
  switch (CurrentDuelSpell)
  {
  /*
    case 0:
    HudSpellSelector.SetSelection(HudSpellSelector.0);
    break;
    case 1:
    HudSpellSelector.SetSelection(HudSpellSelector.1);
    break;
    case 2:
    HudSpellSelector.SetSelection(HudSpellSelector.2);
    break;
	*/
	case (0): HudSpellSelector.SetSelection(HudSpellSelector.ESpellSelection.SSelection_Rictusempra); break;
    case (1): HudSpellSelector.SetSelection(HudSpellSelector.ESpellSelection.SSelection_Mimblewimble); break;
    case (2): HudSpellSelector.SetSelection(HudSpellSelector.ESpellSelection.SSelection_Expelliarmus); break;
    default:
    Log("ERROR: Unrecognized spell for hud spell selector");
    break;
  }
}

function EctoRefAdd ()
{
  if ( iEctoRefCount == 0 )
  {
    GroundSpeed = GroundEctoSpeed;
    HarryAnimSet = HARRY_ANIM_SET_ECTO;
    PlaySound(Sound'HPSounds.Ch2Skurge.ecto_damage',SLOT_Interact,0.75f,,,,,True);
  }
  iEctoRefCount++;
}

function EctoRefSub ()
{
  if ( iEctoRefCount > 0 )
  {
    if ( iEctoRefCount == 1 )
    {
      GroundSpeed = GroundRunSpeed;
      HarryAnimSet = HARRY_ANIM_SET_MAIN;
      LeaveEcto();
      bEctoFlashed = False;
      StopSound(Sound'HPSounds.Ch2Skurge.ecto_damage',SLOT_Interact);
    }
    iEctoRefCount--;
  }
}

function SleepyAnimTimerAdd (int t)
{
  if ( iSleepyAnimTimer == 0 )
  {
    GroundSpeed = fSleepySpeed;
    HarryAnimSet = HARRY_ANIM_SET_SLEEPY;
  }
  iSleepyAnimTimer += t;
  if ( iSleepyAnimTimer > iMaxSleepyAnim )
  {
    iSleepyAnimTimer = iMaxSleepyAnim;
  }
}

function SleepyAnimTimerSub ()
{
  if ( iSleepyAnimTimer > 0 )
  {
    if ( iSleepyAnimTimer == 1 )
    {
      GroundSpeed = GroundRunSpeed;
      HarryAnimSet = HARRY_ANIM_SET_MAIN;
    }
    iSleepyAnimTimer--;
  }
}

function SetMaxSleepyAnim (float t)
{
  iMaxSleepyAnim = t;
  return;
}

function WebAnimRefCountAdd ()
{
  if ( iWebAnimRefCount == 0 )
  {
    GroundSpeed = fWebSpeed;
  }
  iWebAnimRefCount++;
}

function WebAnimRefCountSub ()
{
  if ( iWebAnimRefCount > 0 )
  {
    if ( iWebAnimRefCount == 1 )
    {
      GroundSpeed = GroundRunSpeed;
      LeaveEcto();
    }
    iWebAnimRefCount--;
  } else //{
    if ( iWebAnimRefCount < 0 )
    {
      iWebAnimRefCount = 0;
    }
  //}
}

function LeaveEcto ()
{
  bPlayedEctoKnockBack = False;
}

function DestroyClass (string sInput)
{
  local name cname;
  local Actor Act;

  cname = name(sInput);
  foreach AllActors(Class'Actor',Act)
  {
    if ( Act.IsA(cname) )
    {
      ClientMessage("Destroying:" $ string(Act));
      Act.Destroy();
    }
  }
}

function ListGroups ()
{
  local name cname;
  local Actor Act;

  foreach AllActors(Class'Actor',Act)
  {
    ClientMessage(string(Act) $ " " $ string(Act.Group));
  }
}

event PreSaveGame ()
{    
  PreviousLevelName = "";
  SloMo(1.0);
  CopyAllStatusFromManagerToHarry();
}

event PostSaveGame ()
{
  bShowLoadingScreen = False;
}

function LoadLevel (string LevelName)
{
	local Characters A;

	foreach AllActors(Class'Characters',A)
	{
		if ( A.bPersistent )
		{
			A.PersistentState = A.GetStateName();
			A.PersistentLeadingActor = A.LeadingActor.Name;
			A.PersistentNavPName = A.navP.Name;
			Log("*!* " $ string(A) $ " P_SAVING: PersistentState: " $ string(A.PersistentState) $ " for " $ string(A));
			Log("*!* " $ string(A) $ " P_SAVING: LeadingActor: " $ string(A.PersistentLeadingActor) $ " AnimSequence: " $ string(A.AnimSequence) $ " navP:" $ string(A.navP));
		}
	}
	StopAllMusic(1.0);
	ConsoleCommand("SavePActors");
	HPConsole(Player.Console).ChangeLevel(LevelName,True);
  
	if ( InStr(Caps(LevelName),"STARTUP") > -1 )
	{
		HPConsole(Player.Console).menuBook.bGamePlaying = False;
		HPConsole(Player.Console).menuBook.OpenBook("Main");
		HPConsole(Player.Console).LaunchUWindow();
	}
}

event PreClientTravel ()
{
  local string TS;
  local int TI;

  TI = InStr(Level.LevelEnterText,".");
  if ( TI == -1 )
  {
    TS = Level.LevelEnterText;
  } else {
    TS = Left(Level.LevelEnterText,TI);
  }
  Log("PreClientTravel: Cur Level Name:" $ Level.LevelEnterText);
  if (  !bQueuedToSaveGame )
  {
    Log("PreClientTravel: Setting Previous Level Name:" $ PreviousLevelName);
    cm("PreClientTravel: Setting Previous Level Name:" $ PreviousLevelName);
    PreviousLevelName = TS;
  }
  ClearNonTravelStatus();
  CopyAllStatusFromManagerToHarry();
  if ( bHarryKilled && (GetHealthCount() < iMinHealthAfterDeath) )
  {
    cm("***Setting health to iMinHealthAfterDeath(" $ string(iMinHealthAfterDeath) $ ") because harry died before we loaded this level.");
    SetHealth(iMinHealthAfterDeath);
  }
  bHarryKilled = False;
}

event TravelPostAccept()
{
  local SmartStart StartPoint;
  local Characters Ch;
  local Weapon weap;
  local bool bFoundSmartStart;

	Super.TravelPostAccept();
	Log("weapon is" $ string(Weapon));
	if ( Inventory == None )
	{
		weap = Spawn(Class'baseWand',self);
		weap.BecomeItem();
		AddInventory(weap);
		weap.WeaponSet(self);
		weap.GiveAmmo(self);
		Log(string(self) $ " spawning weap " $ string(weap));
	} 
	else 
	{
		Log("not spawning weap");
	}
	CopyAllStatusFromHarryToManager();
	StatusGroupWizardCards(managerStatus.GetStatusGroup(Class'StatusGroupWizardCards')).RemoveHarryOwnedCardsFromLevel(None);
	if ( Director != None )
	{
		Director.OnPlayerTravelPostAccept();
	}
	foreach AllActors(Class'Characters',Ch)
	{
		Ch.SetEverythingForTheDuel();
	}
	if ( PreviousLevelName != "" )
	{
		bFoundSmartStart = False;
		foreach AllActors(Class'SmartStart',StartPoint)
		{
			if ( (StartPoint.PreviousLevelName != "") && (StartPoint.PreviousLevelName ~= PreviousLevelName) )
			{
				SetLocation(StartPoint.Location);
				SetRotation(StartPoint.Rotation);
				if ( StartPoint.bDoLevelSave )
				{
					harry(Level.PlayerHarryActor).SaveGame();
				}
				cm("***Found SmartStart from:" $ PreviousLevelName);
				Log("***Found SmartStart from:" $ PreviousLevelName);
				bFoundSmartStart = True;
			} 
		}
		
		// Metallicafan212:	I do it in cpp now, more reliable
		/*
		// Metallicafan212:	Find the portal
		if(Level.StartPortal != '')
		{
			foreach AllActors(Class'SmartStart', StartPoint, Level.StartPortal)
			{
				SetLocation(StartPoint.Location);
				SetRotation(StartPoint.Rotation);
				if ( StartPoint.bDoLevelSave )
				{
					harry(Level.PlayerHarryActor).SaveGame();
				}
				bFoundSmartStart = True;
			}
		}
		*/
	}
	if (  !bFoundSmartStart )
	{
		cm("***Failed to find SmartStart from:" $ PreviousLevelName);
		Log("***Failed to find SmartStart from:" $ PreviousLevelName);
	}
	if ( bQueuedToSaveGame )
	{
		cm(" *-*-* Keep the loading screen ON because we *ARE* QueuedToSaveGame. At least until we are done saving.");
		Log(" *-*-* Keep the loading screen ON because we *ARE* QueuedToSaveGame. At least until we are done saving.");
		bShowLoadingScreen = True;
	} 
	else 
	{
		cm(" *-*-* Turn OFF the loading screen because we are *NOT* QueuedToSaveGame.");
		Log(" *-*-* Turn OFF the loading screen because we are *NOT* QueuedToSaveGame.");
		bShowLoadingScreen = False;
	}
}

function CopyAllStatusFromHarryToManager ()
{
  CopyGenericStatusFromHarryToManager();
  CopyCardCardStatusFromHarryToManager();
}

/*
function CopyGenericStatusFromHarryToManager ()
{
  local StatusItem siCurr;
  local int nStatusIdx;

  nStatusIdx = 0;
  if ( nStatusIdx < 30 )
  {
    if ( StatusSave[nStatusIdx].classGroup == None )
    {
      goto JL00C8;
    }
    siCurr = managerStatus.GetStatusItem(StatusSave[nStatusIdx].classGroup,StatusSave[nStatusIdx].classItem);
    siCurr.nCount = StatusSave[nStatusIdx].nCount;
    siCurr.nCurrCountPotential = StatusSave[nStatusIdx].nPotential;
    siCurr.nMaxCount = StatusSave[nStatusIdx].nMaxCount;
    nStatusIdx++;
    goto JL0007;
  }
}
*/

function CopyGenericStatusFromHarryToManager()
{
	local StatusItem  siCurr;
	local int         nStatusIdx;

	// Repopulate status manager items from info we saved off before traveling or saving.
	for (nStatusIdx=0; nStatusIdx<ArrayCount(StatusSave); nStatusIdx++)
	{
		// Nothing more in our list.  Stop looping.
		if (StatusSave[nStatusIdx].classGroup == None)
			break;

		// GetStatusItem will get the status item if it exists or create a new one if not.
		// In either case, set the count and potential count for the desired status item.
		siCurr = managerStatus.GetStatusItem(StatusSave[nStatusIdx].classGroup, StatusSave[nStatusIdx].classItem); 
		siCurr.nCount = StatusSave[nStatusIdx].nCount;
		siCurr.nCurrCountPotential = StatusSave[nStatusIdx].nPotential;
        siCurr.nMaxCount = StatusSave[nStatusIdx].nMaxCount;
	}
}

/*
function CopyCardCardStatusFromHarryToManager ()
{
  local StatusGroupWizardCards sgCards;
  local StatusItemWizardCards siCards;
  local int I;

  sgCards = StatusGroupWizardCards(managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
  I = 0;
  if ( I < 50 )
  {
    siCards.SetCardData(I,BronzeCardSave[I].nCardId,BronzeCardSave[I].nCardOwner);
    I++;
    goto JL0045;
  }
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
  I = 0;
  if ( I < 40 )
  {
    siCards.SetCardData(I,SilverCardSave[I].nCardId,SilverCardSave[I].nCardOwner);
    I++;
    goto JL00B5;
  }
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemGoldCards'));
  I = 0;
  if ( I < 11 )
  {
    siCards.SetCardData(I,GoldCardSave[I].nCardId,GoldCardSave[I].nCardOwner);
    I++;
    goto JL0125;
  }
  sgCards.SetLastObtainedCardTypeAsInt(nLastCardTypeSave);
}
*/
function CopyCardCardStatusFromHarryToManager()
{
	local StatusGroupWizardCards sgCards;
	local StatusItemWizardCards  siCards;
	local int                    i;

	// Restore bronze card data.
	sgCards = StatusGroupWizardCards(managerStatus.GetStatusGroup(class'StatusGroupWizardCards'));
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(class'StatusItemBronzeCards'));
	for (i=0; i<ArrayCount(BronzeCardSave); i++)
		siCards.SetCardData(i, BronzeCardSave[i].nCardId, BronzeCardSave[i].nCardOwner);

	// Restore silver card data.
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(class'StatusItemSilverCards'));
	for (i=0; i<ArrayCount(SilverCardSave); i++)
		siCards.SetCardData(i, SilverCardSave[i].nCardId, SilverCardSave[i].nCardOwner);

	// Restore gold card data.
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(class'StatusItemGoldCards'));
	for (i=0; i<ArrayCount(GoldCardSave); i++)
		siCards.SetCardData(i, GoldCardSave[i].nCardId, GoldCardSave[i].nCardOwner);

	// Restore last card group picked up
	sgCards.SetLastObtainedCardTypeAsInt(nLastCardTypeSave);

	// For debugging, display wizard card data to the console.
	//sgCards.ShowCardData();		
}



function int getnumHousePointsHarry ()
{
  return numHousePointsHarry;
}

function int getLastHousePointsHarry ()
{
  return numLastHousePointsHarry;
}

function int getNumHousePointsGryffindor ()
{
  return numHousePointsGryffindor;
}

function int getNumHousePointsSlytherin ()
{
  return numHousePointsSlytherin;
}

function int getNumHousePointsHufflePuff ()
{
  return numHousePointsHufflepuff;
}

function int getNumHousePointsRavenclaw ()
{
  return numHousePointsRavenclaw;
}

function SaveStateName ()
{
  ClientMessage("Harry state " $ string(GetStateName()) $ " " $ string(LastState));
  if ( GetStateName() != 'PickingUpWizardCard' )
  {
    LastState = GetStateName();
  }
}

function RestoreStateName ()
{
  GotoState(LastState);
}

function SetCarryingActor (Actor A, optional name nameBone)
{
  if ( nameBone == 'None' )
  {
    nameBone = 'WeaponRight';
  }
  CarryingActor = A;
  if ( CarryingActor != None )
  {
    if ( nameBone == 'WeaponRight' )
    {
      Weapon.bHidden = True;
    }
    HarryAnimType = AT_Combine;
    CarryingActor.SetCollision(False,False,False);
    CarryingActor.SetOwner(self);
    CarryingActor.AttachToOwner(nameBone);
    CarryingActor.bRotateToDesired = False;
  } else {
    ClientMessage("******* Dont allow this case   SetCarryingActor *******");
    Weapon.bHidden = False;
  }
  bThrow = False;
}

function bool InFrontOfHarry (Actor A)
{
  local Vector cdir;
  local Vector adir;
  //local float Cos;
  local float fCos;
  local float cdirsize;
  local float adirsize;

  if ( VSize(Location - A.Location) > 512 )
  {
    return False;
  }
  if ( Abs(Location.Z - A.Location.Z) > 128 )
  {
    return False;
  }
  cdir = Cam.vForward;
  cdir.Z = 0.0;
  adir = A.Location - Location;
  adir.Z = 0.0;
  cdirsize = VSize2D(cdir);
  adirsize = VSize2D(adir);
  // Cos = cdir Dot adir / cdirsize * adirsize; 
  fCos = (cdir Dot adir) / (cdirsize * adirsize); //UTPT forgot to add brackets -AdamJD
  if ( fCos > 0.5 )
  {
    return True;
  }
  return False;
}

function Actor FindClosestTargetPoint ()
{
  local TargetPoint ClosestTP;
  local TargetPoint CurrTP;
  local float fClosestDist;
  local float fDist;

  ClosestTP = None;
  fClosestDist = 999999.0;
  foreach AllActors(Class'TargetPoint',CurrTP)
  {
    if ( InFrontOfHarry(CurrTP) )
    {
      fDist = VSize(CurrTP.Location - Location);
      if ( fDist < fClosestDist )
      {
        ClosestTP = CurrTP;
        fClosestDist = fDist;
      }
    }
  }
  return ClosestTP;
}

function Actor AccurateThrowing (Actor A)
{
  //local Actor Target;
  local Actor aTarget;

  if (  !HPawn(A).bAccurateThrowing )
  {
    return None;
  }
  aTarget = FindClosestTargetPoint();
  return aTarget;
}

function HarryAccurateThrowObject (Actor A, Actor Target, bool bCollideActors, bool bCollideWorld)
{
  local Vector Vel;

  A.SetPhysics(PHYS_Falling);
  A.SetCollision(bCollideActors);
  A.bCollideWorld = bCollideWorld;
  Vel = ComputeTrajectoryByTime(A.Location,Target.Location,0.5);
  A.Velocity = Vel;
  A.GotoState('stateBeingThrown');
}

function ThrowCarryingActor ()
{
  local Vector V;
  local Vector v2;
  local Rotator R;
  local Actor A;
  //local Actor Target;
  local Actor aTarget;
  local float ThrowVelocity;

  if ( bThrow && (CarryingActor != None) )
  {
    bThrow = False;
    A = CarryingActor;
    DropCarryingActor(True);
    aTarget = AccurateThrowing(A);
    if ( aTarget != None )
    {
      HarryAccurateThrowObject(A,aTarget,True,True);
    } else {
      V = Normal(Cam.vForward + vect(0.00,0.00,0.50));
      if ( HPawn(A) != None )
      {
        ThrowVelocity = HPawn(A).fThrowVelocity;
        A.GotoState('stateBeingThrown');
      } else {
        ThrowVelocity = 400.0;
      }
      V *= ThrowVelocity;
      A.Velocity = V;
    }
  }
}

function AttachCarryActor (optional name nameBone)
{
  if ( ActorToCarry != None )
  {
    SetCarryingActor(ActorToCarry,nameBone);
  } else {
    DropCarryingActor();
  }
}

function PickupActor (Actor Other)
{
  if ( Physics == PHYS_Walking && IsInState('PlayerWalking') && CarryingActor == None && HPawn(Other) != None && HPawn(Other).bObjectCanBePickedUp && HarryAnimChannel.CanPickSomethingUp() )
  {
    ClientMessage("Do Pickup");
    ActorToCarry = Other;
    GotoState('statePickupItem');
  }
}

function DropCarryingActor (optional bool bLatentDrop)
{
  ClientMessage("** DropCarryingActor");
  if ( CarryingActor != None )
  {
    CarryingActor.SetPhysics(PHYS_Falling);
    CarryingActor.SetOwner(None);
    CarryingActor.Velocity = vect(0.00,0.00,125.00);
    CarryingActor.Instigator = self;
    CarryingActor.bRotateToDesired = True;
    CarryingActor.SetCollision(True,True,True);
    CarryingActor = None;
  }
  if ( IsInState('statePickupItem') )
  {
    GotoState('PlayerWalking');
  }
  if (  !bLatentDrop )
  {
    HarryAnimChannel.GotoState('stateIdle');
    HarryAnimType = AT_Replace;
  }
  Weapon.bHidden = False;
}

state statePickupItem
{
  function BeginState ()
  {
    Velocity *= vect(0.00,0.00,1.00);
    Acceleration *= vect(0.00,0.00,1.00);
  }
  
  begin:
  CurrIdleAnimName = GetCurrIdleAnimName();
  PlayAnim(CurrIdleAnimName,,[TweenTime]0.4,[Type]HarryAnimType);
  if ( ActorToCarry != None )
  {
    TurnTo(ActorToCarry.Location * vect(1.00,1.00,0.00) + Location * vect(0.00,0.00,1.00));
  }
  HarryAnimType = AT_Combine;
  HarryAnimChannel.GotoState('statePickupItem');
  PlayAnim('Pickup',1.0,0.151,[Type]HarryAnimType);
  FinishAnim();
  Sleep(0.5);
  GotoState('PlayerWalking');
}

function DoPotionMixingBegin ()
{
  bKeepStationary = True;
  GotoState('statePotionMixingBegin');
}

function DoPotionMixingStir ()
{
  GotoState('statePotionMixingStir');
}

function DoPotionMixingIdle ()
{
  GotoState('statePotionMixingIdle');
}

function DoPotionMixingEnd ()
{
  CutCue("MixingCauldronDone");
  bKeepStationary = False;
  if (  !bIsCaptured )
  {
    GotoState('PlayerWalking');
  }
}

function bool IsMixingPotion ()
{
  return IsInState('statePotionMixingBegin') || IsInState('statePotionMixingStir') || IsInState('statePotionMixingIdle');
}

function CauldronMixing GetNearestMixingCauldron ()
{
  local CauldronMixing cauldronTest;
  local CauldronMixing cauldronClosest;

  foreach AllActors(Class'CauldronMixing',cauldronTest)
  {
    if ( cauldronClosest == None )
    {
      cauldronClosest = cauldronTest;
    } else //{
      if ( VSize2D(cauldronTest.Location - Location) < VSize2D(cauldronClosest.Location - Location) )
      {
        cauldronClosest = cauldronTest;
      }
    //}
  }
  ClientMessage("closest " $ string(cauldronClosest.Name));
  return cauldronClosest;
}

state statePotionMixingBegin
{
  function BeginState ()
  {
    Velocity *= vect(0.00,0.00,1.00);
    Acceleration *= vect(0.00,0.00,1.00);
  }
  
  begin:
  CurrIdleAnimName = GetCurrIdleAnimName();
  LoopAnim(CurrIdleAnimName,,[TweenTime]0.41,,[Type]HarryAnimType);
}

state statePotionMixingStir
{
  function EndState ()
  {
    StopSound(soundStirPotion,SLOT_Interact);
  }
  
  begin:
  TurnToward(GetNearestMixingCauldron());
  LoopAnim('MixPotion',,,,[Type]HarryAnimType);
  switch (Rand(4))
  {
    case 0:
    soundStirPotion = Sound'cauldron_stir_loop';
    break;
    case 1:
    soundStirPotion = Sound'cauldron_stir_loop2';
    break;
    case 2:
    soundStirPotion = Sound'cauldron_stir_loop3';
    break;
    case 3:
    soundStirPotion = Sound'cauldron_stir_loop4';
    break;
    default:
  }
  fStirSoundDuration = GetSoundDuration(soundStirPotion);
  loop:
  PlaySound(soundStirPotion,SLOT_Interact);
  Sleep(fStirSoundDuration);
  goto ('Loop');
}

state statePotionMixingIdle
{
begin:
  CurrIdleAnimName = GetCurrIdleAnimName();
  LoopAnim(CurrIdleAnimName,,[TweenTime]0.41,, [Type]HarryAnimType);
}

function GotoLocation (Vector newLoc)
{
  newLoc.Z = newLoc.Z + CollisionHeight;
  SetLocation(newLoc);
  fHighestZ = Location.Z;
}

function GotoShortcut (int Num)
{
  local navShortcut sc;
  local int Count;
  local Vector newLoc;

  if ( Num < 0 )
  {
    Num = ShortCutNum++ ;
  }
  Count = 0;
  foreach AllActors(Class'navShortcut',sc)
  {
    if ( Count == Num )
    {
      newLoc = sc.Location;
      newLoc.Z = newLoc.Z + CollisionHeight;
      SetLocation(newLoc);
      fHighestZ = Location.Z;
    }
    Count++;
  }
  if ( ShortCutNum >= Count )
  {
    ShortCutNum = 0;
  }
}

function int FindNearestSavePointID ()
{
  local Actor SavePointInstance;
  local int ReturnID;
  local string Str;
  local int SearchStrLen;  

  ReturnID = -1;
  SearchStrLen = Len("savepoint");
  foreach RadiusActors(Class'Actor',SavePointInstance,50.0,Location)
  {
    Log("Found Actor In Radius = " $ string(SavePointInstance.Name));
    if ( SavePointInstance.IsA('SavePoint') )
    {
      Log("Found Savepoint = " $ string(SavePointInstance.Name));
      Str = Mid(string(SavePointInstance.Name),SearchStrLen);
      Log("Found ID Str = " $ Str);
      ReturnID = int(Str);
	  
    } //else {
    //}
  }
  return ReturnID;
}

function KillHarry (bool bImmediateDeath)
{
  ClientMessage("argghhh I'm Dead!!!!   in KillHarry");
  if ( Director != None )
  {
    Director.OnPlayerDying();
  }
  if ( baseBoss(BossTarget) != None )
  {
    StopBossEncounter();
  }
  if ( (baseBoss(BossTarget) != None) && (baseBoss(BossTarget).TrigEventWhenVictor != '') )
  {
    baseBoss(BossTarget).SendVictoriousTrigger();
  } else {
    bAllowHarryToDie = bImmediateDeath;
    GotoState('stateDead');
  }
}

function KillHarryWithClub (bool bImmediateDeath, Actor A)
{
  local int Yaw;
  local Rotator R;

  bClubDeath = True;
  KillHarry(bImmediateDeath);
  Yaw = A.Rotation.Yaw;
  Yaw += 65536 / 4;
  R = Rotation;
  R.Yaw = Yaw;
  SetRotation(R);
  DesiredRotation = R;
}

function Died (Pawn Killer, name DamageType, Vector HitLocation)
{
  cm("Harry 'Died' function called by '" $ string(Killer) $ "' routing to TakeDamage...");
  TakeDamage(10000,None,Location,vect(0.00,0.00,0.00),'Crushed');
}

state stateDead
{
  ignores  TakeDamage, AltFire, Tick, Fire;
  
  function BeginState ()
  {
    local float fAnimRate;
  
    if ( Director != None )
    {
      Director.OnPlayersDeath();
    }
    fAnimRate = 1.0;
    if ( bClubDeath )
    {
      fAnimRate = 1.5;
    }
    Velocity.X = 0.0;
    Velocity.Y = 0.0;
    Acceleration = vect(0.00,0.00,0.00);
    PlayAnim('faint',fAnimRate,0.2);
    if ( bClubDeath )
    {
      AnimFrame = 36.0 / 151.0;
    }
  }
  
  function vector FindFaintLocation()
	{
		local float  d;
		local vector n;
		local vector v, vLast, vSave, vDest;
		local float  CheckDist;

		CheckDist = 70;  //70 seems to keep his head snug against the wall...
		d = CheckDist;
		//ClientMessage("********* Location:"$Location);
		//ClientMessage("*********        n:"$vector(rotation));

		vSave = Location;

		n = -vector(rotation);

		vDest = Location + n * CheckDist;

		v = Location;

		do
		{
			vLast = v;
			v += n*10;
			MoveSmooth( n*10 );

			if( Location != v )
			{
				v = vLast;
				break;
			}

			d -= 10;

		}until( d <= 0 );

		if( d <= 0 )
		{
			d = 0;
			v = vDest;
		}

		SetLocation( vSave );

		//ClientMessage("*********        d1:"$d);

		//If d is 0, then there's full room to fall down, return where we're at
		//Actually, lets make it at least 20, so he falls more in place.
		if( d < 20 )
			d = 20;
		//if( d == 0 )
		//	return Location;

		//No see if there's room to move away from the obstruction.  We need to move away only as far as we have to.
		// d is already set to the amount we need to move.
		n = -n;
		v = Location;

		do
		{
			vLast = v;
			v += n*10;
			MoveSmooth( n*10 );

			if( Location != v )
			{
				v = vLast;
				break;
			}


			//See if we can go down.  We dont want to fall off a ledge.
			MoveSmooth( vect(0,0,-20) );
			//ClientMessage("********** d:"$d$" trye zdelt");

			if( v.z - Location.z > 19 )
			{
				//ClientMessage("********** d:"$d$" zdelt was over 19");
				v = vLast;
				break;
			}

			SetLocation( v );


			d -= 10;

		}until( d <= 0 );
		//ClientMessage("*********        d2:"$d$" v:"$v);

		SetLocation( vSave );

		//v should now be where we're moving to...
		return v;
	}
  
  /*
  function Vector FindFaintLocation ()
  {
    local float D;
    local Vector N;
    local Vector V;
    local Vector vLast;
    local Vector vSave;
    local Vector vDest;
    local float CheckDist;
  
    CheckDist = 70.0;
    D = CheckDist;
    vSave = Location;
    N =  -Vector(Rotation);
    vDest = Location + N * CheckDist;
    V = Location;
    vLast = V;
  JL0053:
    V += N * byte(10);
    MoveSmooth(N * byte(10));
    if ( Location != V )
    {
      V = vLast;
    } else {
      D -= byte(10);
      if (! (D <= byte(0)) ) goto JL0053;
    }
    if ( D <= byte(0) )
    {
      D = 0.0;
      V = vDest;
    }
    SetLocation(vSave);
    if ( D < byte(20) )
    {
      D = 20.0;
    }
    N =  -N;
    V = Location;
    vLast = V;
    V += N * byte(10);
    MoveSmooth(N * byte(10));
    if ( Location != V )
    {
      V = vLast;
    } else {
      MoveSmooth(vect(0.00,0.00,-20.00));
      if ( V.Z - Location.Z > byte(19) )
      {
        V = vLast;
      } else {
        SetLocation(V);
        D -= byte(10);
        if (! (D <= byte(0)) ) break;
      }
    }
    SetLocation(vSave);
    return V;
  }
  */
  begin:
  RotationRate.Yaw = 0;
  AccelRate = 70.0;
  if (  !bInstantDeath )
  {
    PlayDeathEmoteSound();
    Sleep(0.6661);
    MoveTo(FindFaintLocation());
  }
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  if ( bInstantDeath )
  {
    Sleep(0.5);
  } else {
    FinishAnim();
    Sleep(0.5);
  }
  if ( bSlowDeath )
  {
    Sleep(1.5);
  }
  loop:
  if ( bAllowHarryToDie )
  {
    ConsoleCommand("LoadGame 0");
  }
  Sleep(0.1);
  goto ('Loop');
}

state stateInactive
{
  ignores  DoJump, AltFire, Fire, TakeDamage;
}

function StatusItem GetHealthStatusItem ()
{
  return (managerStatus.GetStatusItem(Class'StatusGroupHealth',Class'StatusItemHealth'));
}

function SetHealth (int iHealth)
{
  local StatusItem siHealth;

  siHealth = GetHealthStatusItem();
  if ( siHealth != None )
  {
    siHealth.SetCount(iHealth);
  } else {
    Log("Error getting health status item");
  }
}

function AddHealth (int iHealth)
{
  local StatusItem siHealth;

  siHealth = GetHealthStatusItem();
  if ( siHealth != None )
  {
    siHealth.IncrementCount(iHealth);
  } else {
    Log("Error getting health status item");
  }
}

function int GetHealthCount ()
{
  local StatusItem siHealth;

  siHealth = GetHealthStatusItem();
  if ( siHealth != None )
  {
    return siHealth.nCount;
  } else {
    Log("Error getting health status item");
    return 0;
  }
}

function float GetHealth ()
{
  return (GetHealthStatusItem().GetCountToCurrPotentialRatio());
}

function AddGryffindorPoints (int iPoints)
{
  managerStatus.IncrementCount(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts',iPoints);
}

function int JellyBeansCount ()
{
  local StatusGroup sg;
  local int Count;

  sg = managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
  Count = sg.GetStatusItem(Class'StatusItemJellybeans').nCount;
  return Count;
}

function int PotionsCount ()
{
  local StatusGroup sg;
  local int Count;

  sg = managerStatus.GetStatusGroup(Class'StatusGroupPotions');
  Count = sg.GetStatusItem(Class'StatusItemWiggenwell').nCount;
  return Count;
}

function managerStatus_PickupItem (HProp Item)
{
  if ( Item.IsA('Jellybean') && (TriggerToSendOnFirstBean != '') )
  {
    ClientMessage("slkdjflsdkj sdlkfj sldkfj sldkj fsldkf jsdlkf jsdlfk j");
    TriggerEvent(TriggerToSendOnFirstBean,self,self);
    TriggerToSendOnFirstBean = '';
  }
  managerStatus.PickupItem(Item);
}

function AddJellyBeansPoints (int iPoints)
{
  ClientMessage("ajbp:" $ string(iPoints));
  if ( iPoints == 0 )
  {
    return;
  }
  if ( (iPoints < 0) && (JellyBeansCount() == 0) )
  {
    return;
  }
  managerStatus.IncrementCount(Class'StatusGroupJellybeans',Class'StatusItemJellybeans',iPoints);
}

function AddPotionsPoints (int iPoints)
{
  if ( iPoints == 0 )
  {
    return;
  }
  if ( (iPoints < 0) && (PotionsCount() == 0) )
  {
    return;
  }
  managerStatus.IncrementCount(Class'StatusGroupPotions',Class'StatusItemWiggenwell',iPoints);
}

function forceHarryLook (Actor Other)
{
  focusActor = Other;
  GotoState('LookAtActor');
}

function forceHarrywing (Actor Other)
{
  focusActor = Other;
  SetPhysics(PHYS_Rotating);
  GotoState('wingspell');
}

function freeHarry ()
{
  GotoState('PlayerWalking');
}

function MovementMode (bool bLockTarget)
{
  if ( bLockTarget )
  {
    bStrafe = 1;
    bLook = 1;
    bLockedOnTarget = True;
  } else {
    bStrafe = 0;
    bLook = 0;
    bLockedOnTarget = False;
  }
}

state LookAtActor
{
  ignores  AltFire, Fire;
  
  begin:
  Enable('Tick');
Loop:
  CurrIdleAnimName = GetCurrIdleAnimName();
  LoopAnim(CurrIdleAnimName);
  Sleep(0.1);
  goto ('Loop');
}

state wingspell
{
  function Tick (float DeltaTime)
  {
  }
  
  exec function AltFire (optional float f)
  {
    if (  !HProp(focusActor).lockSpell )
    {
      HProp(focusActor).bStopLevitating = True;
    }
  }
  
  function Fire (optional float f)
  {
    if (  !HProp(focusActor).lockSpell )
    {
      HProp(focusActor).bStopLevitating = True;
    }
  }
  
  function EndState ()
  {
    HProp(focusActor).bStopLevitating = True;
  }
  
  begin:
  Enable('Tick');
  CurrIdleAnimName = GetCurrIdleAnimName();
  LoopAnim(CurrIdleAnimName);
  SetPhysics(PHYS_Rotating);
  Sleep(0.1);
  
  loop:
  lookhere = focusActor.Location;
  lookhere.Z = Location.Z;
  TurnTo(lookhere);
  ViewRotation = Rotation;
  if ( bSkipKeyPressed )
  {
    HProp(focusActor).bStopLevitating = True;
  }
  PlayAnim('Cast');
  Sleep(0.31);
  goto 'Loop';
}

function KeyDownEvent (int Key)
{
  local Characters Chars;

  if (  !HPConsole(Player.Console).bDebugMode )
  {
    return;
  }
  if ( (Level.TimeSeconds - _LastKeyPressTime > 1.0) || (_iCurrentStringChar > 20) )
  {
    _iCurrentStringChar = 0;
    _CurrentString = "";
  }
  _LastKeyPressTime = Level.TimeSeconds;
  _CurrentString = _CurrentString $ Chr(Key);
  _iCurrentStringChar++;
  if ( _CurrentString ~= "ChadModeOn" )
  {
    TurnDebugModeOn();
  }
  if ( _CurrentString ~= "EricGetsFullHealth" )
  {
    GetHealthStatusItem().SetCountToMaxPotential();
  } else //{
    if ( _CurrentString ~= "EliJump" )
    {
      DoJump(0.0);
      Velocity = (vector(Rotation) + vect(0.00,0.00,1.00)) * 800;
    } else //{
      if ( _CurrentString ~= "PhillipsJump" )
      {
        DoJump(0.0);
        Velocity = (vector(Rotation) + vect(0.00,0.00,1.00)) * 500;
      } else //{
        if ( _CurrentString ~= "MelanieSword" )
        {
          ToggleUseSword();
          if ( bHarryUsingSword )
          {
            bMSword = True;
            makeTarget();
            SpellCursor.bSpellCursorAlwaysOn = True;
          } else {
            bMSword = False;
            SpellCursor.bSpellCursorAlwaysOn = False;
            SpellCursor.EnableEmission(False);
            TurnOffSpellCursor();
          }
        } else //{
          if ( _CurrentString ~= "GoyleMode" )
          {
            ConsoleCommand("GoyleMode");
            if ( bIsGoyle )
            {
              PlaySound(Sound'Pig_snort02',SLOT_None);
              Fatness = 210;
            } else {
              Fatness = 128;
            }
          }
        // }
      // }
    // }
  // }
  else if ( _CurrentString ~= "ChrisMode" )
  {
    if ( Opacity == 1.0 )
    {
      Opacity = 0.5;
    } else //{
      if ( Opacity == 0.5 )
      {
        Opacity = 0.0;
      } else {
        Opacity = 1.0;
      }
    //}
  } 
	else //{
    if ( _CurrentString ~= "FraserIsGod" )
    {
      bFraserMode =  !bFraserMode;
      if ( bFraserMode )
      {
        ClientMessage("Indeed, Fraser IS God...");
      } else {
        ClientMessage("Sad, Fraser is now NOT God.");
      }
    } else //{
      if ( _CurrentString ~= "BeatBoss" )
      {
        baseBoss(BossTarget).BeatBoss();
      } else //{
        if ( _CurrentString ~= "Quit" )
        {
          ConsoleCommand("exit");
        }
      // }
    // }
  // }
}

function SpawnAndAttach (name Bone)
{
  local Actor E;

  E = Spawn(Class'TorchFire03',[SpawnOwner]self);
  E.AttachToOwner(Bone);
}

function StartBossEncounter (baseBoss Boss, bool in_bHarryShouldLockOntoBoss, bool in_bReverseInput, bool in_bKeepHarryFixed, bool in_bCanCast, Vector in_vFixedFaceDirection, ESpellType ForceSpellType, bool in_bExtendedTargetting, bool in_bDontShowBossMeter)
{
  local EnemyHealthManager EHealth;

  BossTarget = Boss;
  bLockedOnTarget = in_bHarryShouldLockOntoBoss;
  if ( in_vFixedFaceDirection.X != 0 || in_vFixedFaceDirection.Y != 0 || in_vFixedFaceDirection.Z != 0 )
  {
    bFixedFaceDirection = True;
    vFixedFaceDirection = Normal(in_vFixedFaceDirection);
  }
  if ( in_bHarryShouldLockOntoBoss )
  {
    bStrafe = 1;
  } else {
    bStrafe = 0;
  }
  if ( in_bReverseInput )
  {
    bReverseInput = True;
    bConstrainYaw = True;
  }
  if ( in_bKeepHarryFixed )
  {
    bKeepStationary = True;
  }
  bCanCast = in_bCanCast;
  bTargettingError = False;
  if ( ForceSpellType != SPELL_None )
  {
    baseWand(Weapon).ChooseSpell(ForceSpellType,True);
    baseWand(Weapon).bAutoSelectSpell = False;
  }
  bExtendedTargetting = in_bExtendedTargetting;
  if ( bExtendedTargetting )
  {
    SpellCursor.SetLOSDistance(1000.0);
  } else {
    SpellCursor.SetLOSDistance(0.0);
  }
  // if (!(bStrafe == 0 )) goto JL014A;
  if ( in_bHarryShouldLockOntoBoss && Boss != None )
  {
    if (  !Boss.SetCamMode() )
    {
      Cam.SetCameraMode(Cam.ECamMode.CM_Boss);
    }
  }
  if ( Boss != None )
  {
// JL014A:
    Boss.StartBossEncounter();
    if (  !in_bDontShowBossMeter )
    {
      EHealth = EnemyHealthManager(FancySpawn(Class'EnemyHealthManager'));
      EHealth.Start(Boss);
    } else {
      Cam.SetDistance(100.0);
      Cam.SetZOffset(250.0);
      Cam.SetXOffset(-50.0);
    }
  }
}

function StopBossEncounter ()
{
  BossTarget = None;
  bLockedOnTarget = False;
  bFixedFaceDirection = False;
  bStrafe = 0;
  bKeepStationary = False;
  bReverseInput = False;
  bConstrainYaw = False;
  ClientMessage("baseHarry.StopBossEncounter()");
  baseWand(Weapon).ChooseSpell(SPELL_None);
  baseWand(Weapon).bAutoSelectSpell = True;
  bCanCast = True;
  bCastFastSpells = False;
  bTargettingError = True;
  bExtendedTargetting = False;
  SpellCursor.SetLOSDistance(0.0);
  GroundRunSpeed = Default.GroundRunSpeed;
  GroundSpeed = GroundRunSpeed;
  Cam.SetCameraMode(Cam.ECamMode.CM_Standard);
}

function name HarryAtMapMarker ()
{
  local MenuMapLocationMarker A;
  local name closestAtag;
  local float closestD;
  local float D;

  closestD = 1000000.0;
  foreach AllActors(Class'MenuMapLocationMarker',A)
  {
    D = VSize2D(A.Location - Location);
    if ( D < CollisionRadius + A.CollisionRadius && Location.Z > A.Location.Z - A.CollisionHeight - 80 && Location.Z < A.Location.Z + A.CollisionHeight + 80 )
    {
      if ( D < closestD )
      {
        closestD = D;
        closestAtag = A.Tag;
      }
    }
  }
  return closestAtag;
}

function InvertBroomPitch (bool Value)
{
  bInvertBroomPitch = Value;
  SaveConfig();
}

simulated function ClientPlaySound (Sound ASound, optional bool bInterrupt, optional bool bVolumeControl)
{
  local Actor SoundPlayer;
  local int Volume;

  if ( b3DSound )
  {
    if ( bVolumeControl && (AnnouncerVolume == 0) )
    {
      Volume = 0;
    } else {
      Volume = 1;
    }
  } else //{
    if ( bVolumeControl )
    {
      Volume = AnnouncerVolume;
    } else {
      Volume = 4;
    }
  //}
  LastPlaySound = Level.TimeSeconds;
  if ( ViewTarget != None )
  {
    SoundPlayer = ViewTarget;
  } else {
    SoundPlayer = self;
  }
  if ( Volume == 0 )
  {
    return;
  }
  SoundPlayer.PlaySound(ASound,SLOT_None,16.0,bInterrupt);
  if ( Volume == 1 )
  {
    return;
  }
  SoundPlayer.PlaySound(ASound,SLOT_Interface,16.0,bInterrupt);
  if ( Volume == 2 )
  {
    return;
  }
  SoundPlayer.PlaySound(ASound,SLOT_Misc,16.0,bInterrupt);
  if ( Volume == 3 )
  {
    return;
  }
  SoundPlayer.PlaySound(ASound,SLOT_Talk,16.0,bInterrupt);
}

function DebugState ()
{
}

function TurnDebugModeOn ()
{
  HPConsole(Player.Console).bDebugMode = True;
}

function PreSetMovement ()
{
  bCanJump = True;
  bCanWalk = True;
  bCanSwim = True;
  bCanFly = False;
  bCanOpenDoors = True;
  bCanDoSpecial = True;
}

function HarryKnockBack ()
{
  PlayHurtEmoteSound();
  if ( CarryingActor != None )
  {
    DropCarryingActor();
  }
  HarryAnimChannel.DoKnockBack();
  Acceleration *= vect(0.00,0.00,1.00);
}

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
  local Sound snd;
  local bool bPlayKnockBack;
  local bool bPlayHurtSound;
  local float fFlashScale;
  local StatusItem siWiggenPotion;
  local bool bFallDamage;
  local float fDamageScaled;
  local int FinalDamage;
  
  if ( (CarryingActor != None) && (CarryingActor == InstigatedBy) )
  {
    return;
  }
  
  bPlayHurtSound = True;
  fDamageScaled = Damage;
  switch (Difficulty)
  {
    case DifficultyEasy:
    fDamageScaled = (fDamageScaled * fDamageMultiplier_Easy);
    break;
    case DifficultyMedium:
    fDamageScaled = (fDamageScaled * fDamageMultiplier_Medium);
    break;
    case DifficultyHard:
    fDamageScaled = (fDamageScaled * fDamageMultiplier_Hard);
    break;
    default:
  }
  FinalDamage = FMax(fDamageScaled,fMinDamageScalar); 
  fFlashScale = FClamp(FinalDamage,20.0,60.0);
  switch (DamageType)
  {
    case 'Falling':
    ClientFlash(-0.02 * fFlashScale,fFlashScale * vect(20.00,20.00,20.00));
    break;
    case 'Ectoplasma':
    if (  !bEctoFlashed )
    {
      bEctoFlashed = True;
      ClientFlash(-0.03 * fFlashScale,fFlashScale * vect(9.38,14.06,4.69));
    }
    break;
    case 'PoisonCloud':
    ClientFlash(-0.01171875 * fFlashScale,fFlashScale * vect(7.80,11.72,11.72));
    break;
    default:
  }
  if (  !HarryIsDead() )
  {
    if ( CarryingActor != None )
    {
      DropCarryingActor();
    }
    bThrow = False;
    if ( (DamageType == 'ZonePain') || (DamageType == 'pit') || (DamageType == 'Crushed') || (DamageType == 'RolledOver') )
    {
      bPlayHurtSound = False;
      if ( ((DamageType == 'Crushed') || (DamageType == 'RolledOver')) && (GetHealthCount() > 0) )
      {
        bPlayHurtSound = True;
      }
      if ( (DamageType == 'ZonePain') || (DamageType == 'pit') )
      {
        bInstantDeath = True;
      }
      if ( (DamageType == 'Crushed') || (DamageType == 'RolledOver') )
      {
        bClubDeath = True;
      }
      if ( DamageType == 'RolledOver' )
      {
        bSlowDeath = True;
      }
      FinalDamage = 1000;
      if ( (DamageType == 'ZonePain') || (DamageType == 'pit') )
      {
        bHidden = True;
      }
    } else {
      if ( (DamageType == 'Falling') && (FinalDamage > 20) )
      {
        bFallDamage = True;
      }
      if ( iEctoRefCount > 0 )
      {
        if (  !bPlayedEctoKnockBack || ( ++iEctoHurtSoundCount >= 6) )
        {
          iEctoHurtSoundCount = 0;
        } else {
          bPlayHurtSound = False;
        }
      }
      if ( DamageType == 'AcidHit' )
      {
        if ( fTimeSinceLastAcidHit < 0.333 )
        {
          FinalDamage = 0;
        } else {
          fTimeSinceLastAcidHit = 0.0;
        }
      }
      if ( iWebAnimRefCount > 0 )
      {
        if (  !bPlayedEctoKnockBack || ( ++iEctoHurtSoundCount >= 6) )
        {
          iEctoHurtSoundCount = 0;
        } else {
          bPlayHurtSound = False;
        }
      }
      bPlayKnockBack = True;
      if ( iEctoRefCount > 0 )
      {
        if ( bPlayedEctoKnockBack )
        {
          bPlayKnockBack = False;
        }
        bPlayedEctoKnockBack = True;
      }
      if ( iEctoRefCount > 0 )
      {
        if ( bPlayedEctoKnockBack )
        {
          bPlayKnockBack = False;
        }
        bPlayedEctoKnockBack = True;
      }
      if ( bPlayKnockBack )
      {
        HarryAnimChannel.DoKnockBack();
      }
      Acceleration *= vect(0.00,0.00,1.00);
    }
    if ( bPlayHurtSound )
    {
      PlayHurtEmoteSound();
    }
  }
  if ( (GetHealthCount() > 0) &&  !bFraserMode )
  {
    ClientMessage("baseHarry: argghhh I'm HIT!!!!  " $ string(FinalDamage) $ " Difficulty:" $ string(Difficulty) $ " Type:" $ string(DamageType) $ " State:" $ string(GetStateName()));
    AddHealth( -FinalDamage);
    if ( GetHealthCount() <= 0.0 )
    {
      siWiggenPotion = managerStatus.GetStatusItem(Class'StatusGroupPotions',Class'StatusItemWiggenwell');
      if ( bAutoQuaff &&  !bFallDamage &&  !bInstantDeath &&  !bClubDeath && siWiggenPotion.nCount >= 1 )
      {
        AddHealth(1);
        DoDrinkWiggenwell();
      } else {
        bHarryKilled = True;
      }
    }
    if ( BossTarget != None )
    {
      if ( bHarryKilled )
      {
        BossTarget.OnEvent('HarryWasKilled');
      } else {
        BossTarget.OnEvent('HarryWasHurt');
      }
    }
    if ( bHarryKilled )
    {
      KillHarry(True);
    }
  } else {
    ClientMessage("baseHarry: argghhh I'm HIT!!!! (no damage) " $ string(FinalDamage) $ " Type:" $ string(DamageType) $ " State:" $ string(GetStateName()));
  }
}

exec function Summon (string ClassName)
{
  Summon(ClassName);
}

event Landed (Vector HitNormal)
{
  GroundSpeed = GroundRunSpeed;
}

function Falling ()
{
  local float S;

  S = VSize2D(Velocity);
  if ( S > GroundJumpSpeed )
  {
    Velocity *= GroundJumpSpeed / S;
  }
  GroundSpeed = GroundJumpSpeed;
}

simulated function PlayFootStep ()
{
  local Sound Step;
  local float decision;
  local Texture HitTexture;
  local int Flags;
  local Sound Footstep1;
  local Sound Footstep2;
  local Sound Footstep3;
  local bool bMakeNoise;
  local float Volume;

  Volume = 1000.0;
  if ( FootRegion.Zone.bWaterZone )
  {
    PlaySound(WaterStep,SLOT_Pain,1.0,False,Volume,1.0);
    return;
  } else //{
    if ( Fatness > 200 )
    {
      PlaySound(Sound'Big_whomp2',SLOT_None,RandRange(0.41,0.69999999),False,500.0,RandRange(0.5,1.0));
      ShakeView(0.22,50.0,50.0);
      return;
    }
  //}
  if ( iEctoRefCount > 0 )
  {
    Footstep1 = Sound'HAR_foot_ecto1';
    Footstep2 = Sound'HAR_foot_ecto2';
    Footstep3 = Sound'HAR_foot_ecto3';
  } else //{
    if ( iWebAnimRefCount > 0 )
    {
      Footstep1 = Sound'HAR_foot_ecto1';
      Footstep2 = Sound'HAR_foot_ecto2';
      Footstep3 = Sound'HAR_foot_ecto3';
    } else {
      HitTexture = TraceTexture(Location + vect(0.00,0.00,-128.00),Location,Flags);
      Footstep1 = Sound'HAR_foot_wood1';
      Footstep2 = Sound'HAR_foot_wood2';
      Footstep3 = Sound'HAR_foot_wood3';
      bMakeNoise = True;
      if ( HitTexture != None )
      {
        switch (HitTexture.FootstepSound)
        {
          case FOOTSTEP_Rug:
          Footstep1 = Sound'HAR_foot_rug1';
          Footstep2 = Sound'HAR_foot_rug2';
          Footstep3 = Sound'HAR_foot_rug3';
          bMakeNoise = False;
          break;
          case FOOTSTEP_Wood:
          Footstep1 = Sound'HAR_foot_wood1';
          Footstep2 = Sound'HAR_foot_wood2';
          Footstep3 = Sound'HAR_foot_wood3';
          break;
          case FOOTSTEP_Stone:
          Footstep1 = Sound'HAR_foot_stone1';
          Footstep2 = Sound'HAR_foot_stone2';
          Footstep3 = Sound'HAR_foot_stone3';
          break;
          case FOOTSTEP_Cave:
          Footstep1 = Sound'HAR_foot_cave1';
          Footstep2 = Sound'HAR_foot_cave2';
          Footstep3 = Sound'HAR_foot_cave3';
          break;
          case FOOTSTEP_Cloud:
          Footstep1 = Sound'HAR_foot_cloud1';
          Footstep2 = Sound'HAR_foot_cloud2';
          Footstep3 = Sound'HAR_foot_cloud3';
          bMakeNoise = False;
          break;
          case FOOTSTEP_Wet:
          Footstep1 = Sound'HAR_foot_wet1';
          Footstep2 = Sound'HAR_foot_wet2';
          Footstep3 = Sound'HAR_foot_wet3';
          bMakeNoise = False;
          break;
          case FOOTSTEP_Grass:
          Footstep1 = Sound'HAR_foot_grass1';
          Footstep2 = Sound'HAR_foot_grass2';
          Footstep3 = Sound'HAR_foot_grass3';
          bMakeNoise = False;
          break;
          case FOOTSTEP_Metal:
          Footstep1 = Sound'HAR_foot_metal1';
          Footstep2 = Sound'HAR_foot_metal2';
          Footstep3 = Sound'HAR_foot_metal3';
          break;
          default:
        }
      }
    }
  //}
  decision = FRand();
  if ( decision < 0.34 )
  {
    Step = Footstep1;
  } else //{
    if ( decision < 0.672 )
    {
      Step = Footstep2;
    } else {
      Step = Footstep3;
    }
  //}
  PlaySound(Step,SLOT_None,1.0,False,Volume,0.89999998);
  if ( bMakeNoise )
  {
    HearHarryRecipient.PawnHearHarryNoise();
    MakeNoise(10.0);
  }
}

function PlayHit (float Damage, Vector HitLocation, name DamageType, Vector Momentum)
{
}

function DoJump (optional float f)
{
	local float TmpJumpZ;
	local Vector V;
	local float S;
	
	log("CALLED JUMP");

	if ( bKeepStationary || bInDuelingMode )
	{
		return;
	}
	if ( bCorraledByMover )
	{
		return;
	}
	if ( iEctoRefCount > 0 )
	{
		PlayAnim(HarryAnims[HarryAnimSet].Jump,,[TweenTime]0.1,[Type]HarryAnimType);
		HarryAnimChannel.DoEctoJump();
		return;
	} 
	else if ( iSleepyAnimTimer > 0 )
	{
		PlayAnim(HarryAnims[HarryAnimSet].Jump,,[TweenTime]0.1,[Type]HarryAnimType);
		HarryAnimChannel.DoSleepyJump();
		return;
	}
	if ( Physics == PHYS_Walking )
	{
		log("JUMP FROM PHYS_WALKING!");
		PlayJumpEmoteSound(); //decide which jump sound to play -AdamJD
		PlayOwnedSound(JumpSound, SLOT_Talk, 1.5, true, 1200, 1.0 );
		if ( (Level.Game != None) && Level.Game.Difficulty > 0 )
		{
		  MakeNoise(0.1 * Level.Game.Difficulty);
		}
		MountDelta = Location;
		if ( VSize2D(Velocity) > 0 )
		{
		  PlayAnim(HarryAnims[HarryAnimSet].Jump2,,[TweenTime]0.1,[Type]HarryAnimType);
		} 
		else 
		{
		  PlayAnim(HarryAnims[HarryAnimSet].Jump,,[TweenTime]0.1,[Type]HarryAnimType);
		}
		S = VSize2D(Velocity);
		if ( S > GroundJumpSpeed )
		{
		  Velocity *= GroundJumpSpeed / S;
		}
		GroundSpeed = GroundJumpSpeed;
		TmpJumpZ = JumpZ;
		Velocity.Z = Velocity.Z * 0.2 + TmpJumpZ;
		if ( (Base != Level) && (Base != None) )
		{
		  Velocity += Base.Velocity;
		}
		SetPhysics(PHYS_Falling);
	}
}

function PlayHurtEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(26))
    {
      case 0:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_26',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_26a',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_26b',SLOT_Talk);
      break;
      case 3:
      PlaySound(Sound'PC_AsG_Emote_13',SLOT_Talk);
      break;
      case 4:
      PlaySound(Sound'PC_AsG_Emote_13a',SLOT_Talk);
      break;
      case 5:
      PlaySound(Sound'PC_AsG_Emote_13b',SLOT_Talk);
      break;
      case 6:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_25',SLOT_Talk);
      break;
      case 7:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_25a',SLOT_Talk);
      break;
      case 8:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_25b',SLOT_Talk);
      break;
      case 9:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_25c',SLOT_Talk);
      break;
      case 10:
      PlaySound(Sound'PC_AsG_Emote_14',SLOT_Talk);
      break;
      case 11:
      PlaySound(Sound'PC_AsG_Emote_14a',SLOT_Talk);
      break;
      case 12:
      PlaySound(Sound'PC_AsG_Emote_14b',SLOT_Talk);
      break;
      case 13:
      PlaySound(Sound'PC_AsG_Emote_15',SLOT_Talk);
      break;
      case 14:
      PlaySound(Sound'PC_AsG_Emote_15a',SLOT_Talk);
      break;
      case 15:
      PlaySound(Sound'PC_AsG_Emote_15b',SLOT_Talk);
      break;
      case 16:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_27',SLOT_Talk);
      break;
      case 17:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_27a',SLOT_Talk);
      break;
      case 18:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_27b',SLOT_Talk);
      break;
      case 19:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_28',SLOT_Talk);
      break;
      case 20:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_28a',SLOT_Talk);
      break;
      case 21:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_28b',SLOT_Talk);
      break;
      case 22:
      PlaySound(Sound'PC_AsG_Emote_16',SLOT_Talk);
      break;
      case 23:
      PlaySound(Sound'PC_AsG_Emote_16a',SLOT_Talk);
      break;
      case 24:
      PlaySound(Sound'PC_AsG_Emote_16b',SLOT_Talk);
      break;
      case 25:
      PlaySound(Sound'PC_AsG_Emote_17',SLOT_Talk);
      break;
      case 24:
      PlaySound(Sound'PC_AsG_Emote_17a',SLOT_Talk);
      break;
      case 25:
      PlaySound(Sound'PC_AsG_Emote_17b',SLOT_Talk);
      break;
      default:
    }
  } else {
    PlaySound(HurtSound[Rand(15)],SLOT_Talk);
  }
}

function PlayDeathEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(3))
    {
      case 0:
      PlaySound(Sound'AsG_faint_1',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'AsG_faint_2',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'AsG_faint_3',SLOT_Talk);
      break;
      default:
    }
  } else {
    switch (Rand(3))
    {
      case 0:
      PlaySound(Sound'PC_Hry_faint1',SLOT_Talk,0.75);
      break;
      case 1:
      PlaySound(Sound'PC_Hry_faint2',SLOT_Talk,0.75);
      break;
      case 2:
      PlaySound(Sound'PC_Hry_faint3',SLOT_Talk,0.75);
      break;
      default:
    }
  }
}

function PlayLandedEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(5))
    {
      case 0:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_24',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_24a',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_24b',SLOT_Talk);
      break;
      case 3:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_24c',SLOT_Talk);
      break;
      case 4:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_24d',SLOT_Talk);
      break;
      default:
    }
  } else {
    switch (Rand(5))
    {
      case 0:
      PlaySound(Sound'landing1',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'landing2',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'landing3',SLOT_Talk);
      break;
      case 3:
      PlaySound(Sound'landing4',SLOT_Talk);
      break;
      case 4:
      PlaySound(Sound'landing5',SLOT_Talk);
      break;
      default:
    }
  }
}

function PlayFallingPullupEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(3))
    {
      case 0:
      PlaySound(Sound'AsG_pullup_3',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'AsG_pullup_4',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'AsG_pullup_6',SLOT_Talk);
      break;
      default:
    }
  } else {
    PlaySound(Sound'pull_up3',SLOT_Talk);
  }
}

function PlayEasyPullupEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(3))
    {
      case 0:
      PlaySound(Sound'AsG_pullup_1',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'AsG_pullup_2',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'AsG_pullup_5',SLOT_Talk);
      break;
      default:
    }
  } else {
    PlaySound(Sound'EmotiveHarry5_b_pullup6',SLOT_Talk);
  }
}

function PlayHardPullupEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(3))
    {
      case 0:
      PlaySound(Sound'AsG_pullup_3',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'AsG_pullup_4',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'AsG_pullup_6',SLOT_Talk);
      break;
      default:
    }
  } else {
    PlaySound(Sound'EmotiveHarry5_a_pullup5',SLOT_Talk);
  }
}

function PlayFallDeepEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(5))
    {
      case 0:
      PlaySound(Sound'PC_AsG_Adv7aSlyth_29',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'PC_AsG_Emote_19',SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'PC_AsG_Emote_19a',SLOT_Talk);
      break;
      case 3:
      PlaySound(Sound'PC_AsG_Emote_19b',SLOT_Talk);
      break;
      default:
    }
  } else {
    PlaySound(Sound'falldeep2',SLOT_Talk);
  }
}

function PlayJumpEmoteSound ()
{
  if ( bIsGoyle )
  {
    switch (Rand(3))
    {
      case 0:
      PlaySound(Sound'PC_AsG_Emote_20',SLOT_Talk);
      break;
      case 1:
      PlaySound(Sound'PC_AsG_Emote_20a', SLOT_Talk);
      break;
      case 2:
      PlaySound(Sound'PC_AsG_Emote_20b',SLOT_Talk);
      break;
      default:
    }
  } else 
  {
    PlayOwnedSound(JumpSound,SLOT_Talk,1.5,False,1200.0,1.0);
  }
}

function PlayIncantationEmoteSound (ESpellType SpellType)
{
  local string SpellIncantation;

  if ( bIsGoyle )
  {
    switch (SpellType)
    {
      case SPELL_Alohomora:
      switch (Rand(2))
      {
        case 0:
        SpellIncantation = "PC_AsG_Adv7aSlyth_20";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_12";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_12a";
        break;
        default:
      }
      break;
      case SPELL_Flipendo:
      switch (Rand(2))
      {
        case 0:
        SpellIncantation = "PC_AsG_Adv7aSlyth_19";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_08";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_08a";
        break;
        default:
      }
      break;
      case SPELL_Lumos:
      switch (Rand(2))
      {
        case 0:
        SpellIncantation = "PC_AsG_Adv7aSlyth_21";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_09";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_09a";
        break;
        default:
      }
      break;
      case SPELL_Skurge:
      switch (Rand(2))
      {
        case 0:
        SpellIncantation = "PC_AsG_Adv7aSlyth_23";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_10";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_10a";
        break;
        default:
      }
      break;
      case SPELL_Diffindo:
      switch (Rand(2))
      {
        case 0:
        SpellIncantation = "PC_AsG_Adv7aSlyth_22";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_11";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_11a";
        break;
        default:
      }
      break;
      case SPELL_Rictusempra:
      case SPELL_DuelRictusempra:
      switch (Rand(2))
      {
        case 0:
        SpellIncantation = "PC_AsG_Adv7aSlyth_18";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_07";
        break;
        case 1:
        SpellIncantation = "PC_AsG_Emote_07a";
        break;
        default:
      }
      break;
      //case 21:
      //case 26:
      //case SPE:
      default:
      break;
    }
  } else {
    switch (SpellType)
    {
      case SPELL_Alohomora:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_01a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_01b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_01c";
        break;
        default:
      }
      break;
      case SPELL_Flipendo:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_02a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_02b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_02c";
        break;
        default:
      }
      break;
      case SPELL_Lumos:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_03a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_03b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_03c";
        break;
        default:
      }
      break;
      case SPELL_Skurge:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_04a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_04b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_04c";
        break;
        default:
      }
      break;
      case SPELL_Diffindo:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_05a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_05b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_05c";
        break;
        default:
      }
      break;
      case SPELL_Rictusempra:
      case SPELL_DuelRictusempra:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_06a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_06b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_06c";
        break;
        default:
      }
      break;
      case SPELL_Spongify:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_07a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_07b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_07c";
        break;
        default:
      }
      break;
      case SPELL_DuelMimblewimble:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_08a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_08b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_08c";
        break;
        default:
      }
      break;
      case SPELL_DuelExpelliarmus:
      switch (Rand(3))
      {
        case 0:
        SpellIncantation = "PC_Hry_SpellCast_09a";
        break;
        case 1:
        SpellIncantation = "PC_Hry_SpellCast_09b";
        break;
        case 2:
        SpellIncantation = "PC_Hry_SpellCast_09c";
        break;
        default:
      }
      SpellIncantation = "";
      break;
      default:
    }
  }
  if ( SpellIncantation != "" )
  {
    PlaySound(Sound(DynamicLoadObject("AllDialog." $ SpellIncantation,Class'Sound')),SLOT_Talk,0.75,True);
  }
}

function PlaySpellCastSound (ESpellType SpellType)
{
  local Sound SpellSound;

  switch (SpellType)
  {
    case SPELL_Alohomora:
    SpellSound = Sound'cast_Alohomora';
    break;
    case SPELL_Flipendo:
    SpellSound = Sound'cast_Flipendo';
    break;
    case SPELL_Lumos:
    SpellSound = Sound'cast_Lumos';
    break;
    case SPELL_Skurge:
    SpellSound = Sound'cast_Skurge';
    break;
    case SPELL_Diffindo:
    SpellSound = Sound'cast_Diffindo';
    break;
    case SPELL_Spongify:
    SpellSound = Sound'cast_Spongify';
    break;
    case SPELL_Rictusempra:
    case SPELL_DuelRictusempra:
    SpellSound = Sound'cast_Rictusempra';
    break;
    case SPELL_DuelMimblewimble:
    SpellSound = Sound'cast_Mimblewimble';
    break;
    case SPELL_DuelExpelliarmus:
    SpellSound = None;
    break;
    default:
  }
  if ( SpellSound != None )
  {
    PlaySound(SpellSound,SLOT_None);
  }
}

/*
function PlayLandedSound ()
{
  local Sound Step;
  local float decision;
  local Texture HitTexture;
  local int Flags;
  local float vol;

  if ( FootRegion.Zone.bWaterZone )
  {
    PlaySound(WaterStep,SLOT_Interact,1.0,False,1000.0,1.0);
    return;
  }
  HitTexture = TraceTexture(Location + vect(0.00,0.00,-128.00),Location,Flags);
  Step = Sound'HAR_landing_stone';
  switch (HitTexture.FootstepSound)
  {
    case 2:
    break;
    case 4:
    case 6:
    case 1:
    Step = Sound'HAR_landing_rug';
    break;
    case 0:
    case 3:
    Step = Sound'HAR_landing_stone';
    break;
    case 5:
    Step = Sound'HAR_landing_wet';
    break;
    case 7:
    Step = Sound'HAR_landing_metal';
    break;
    default:
  }
  if ( fTimeInAir < 1.0 )
  {
    vol = 0.31 * fTimeInAir;
  } else {
    vol = 0.31 + (fTimeInAir - 1.0) * 0.69999999 / 0.5;
  }
  if ( Location.Z < fFallingZ - byte(40) )
  {
    vol *= byte(2);
  }
  PlaySound(Step,3,vol,False,1000.0,0.89999998);
  HearHarryRecipient.PawnHearHarryNoise();
  MakeNoise(10.0);
}
*/

function PlayLandedSound()
{
	local sound   step;
	local float   decision;
	local Texture HitTexture;
	local int     Flags;
	local float   vol;

	if ( FootRegion.Zone.bWaterZone )
	{
		PlaySound(WaterStep, SLOT_Interact, 1, false, 1000.0, 1.0);
		return;
	}

	HitTexture = TraceTexture(Location + (vect(0,0,-128)), Location, Flags );

	step = Sound'HPSounds.FootSteps.HAR_Landing_stone';

	switch( HitTexture.FootstepSound )
	{
		case FOOTSTEP_Wood:
		//	step = Sound'HPSounds.FootSteps.HAR_Landing_wood';
			break;

		case FOOTSTEP_cloud:
		case FOOTSTEP_grass:
		case FOOTSTEP_Rug:
			step = Sound'HPSounds.FootSteps.HAR_Landing_rug';
			break;

		case FOOTSTEP_Stone:
		case FOOTSTEP_cave:
			step = Sound'HPSounds.FootSteps.HAR_Landing_stone';
			break;

		case FOOTSTEP_wet:
			step = Sound'HPSounds.FootSteps.HAR_Landing_wet';
			break;

		case FOOTSTEP_metal:
			step = Sound'HPSounds.FootSteps.HAR_Landing_metal';
			break;
	}

	if( fTimeInAir < 1.0 )
		vol = 0.3 * fTimeInAir;
	else
		vol = 0.3 + (fTimeInAir - 1.0) * 0.7/0.5;

	//if you fell, rather than jumped, make the sound louder
	if( Location.z < fFallingZ - 40 )
		vol *= 2;

//	PlaySound(step, SLOT_Interact, vol, false, 1000.0, 0.9);
	
	PlayLandedEmoteSound(); //decide which landed sound to play -AdamJD
	
	PlaySound(step, SLOT_Misc, vol, false, 1000.0);

	HearHarryRecipient.PawnHearHarryNoise();
	MakeNoise( 10 );
	
	// Metallicafan212:	Fatness fix
	if(Fatness >= 200)
	{
		PlaySound(Sound'Big_whomp2',SLOT_None,RandRange(0.41,0.69999999),False,500.0,RandRange(0.5,1.0));
		ShakeView(0.22,50.0,50.0);
		AutoHitAreaEffect(256);
	}
}

function PlayTurning ()
{
  PlayAnim(HarryAnims[HarryAnimSet].StrafeLeft,,,[Type]HarryAnimType);
}

function TweenToRunning (float TweenTime)
{
  local Vector X;
  local Vector Y;
  local Vector Z;
  local Vector Dir;

  BaseEyeHeight = Default.BaseEyeHeight;
  if (  !HarryAnimChannel.PlayHarryMovementAnims() )
  {
    return;
  }
  GetAxes(Rotation,X,Y,Z);
  Dir = Normal(Acceleration);
  if ( (Dir Dot X < 0.75) && (Dir != vect(0.00,0.00,0.00)) )
  {
    if ( Dir Dot X < -0.75 )
    {
      LoopAnim(HarryAnims[HarryAnimSet].WalkBack,0.89999998,[TweenTime]TweenTime,,[Type]HarryAnimType);
      bMovingBackwards = True;
    } else //{
      if ( Dir Dot Y > 0 )
      {
        LoopAnim(HarryAnims[HarryAnimSet].StrafeRight,0.89999998,[TweenTime]TweenTime,,[Type]HarryAnimType);
      } else {
        LoopAnim(HarryAnims[HarryAnimSet].StrafeLeft,0.89999998,[TweenTime]TweenTime,,[Type]HarryAnimType);
      }
    //}
  } else {
    LoopAnim(HarryAnims[HarryAnimSet].run,0.89999998,[TweenTime]TweenTime,,[Type]HarryAnimType);
    bMovingBackwards = False;
  }
}

function PlayRunning ()
{
  TweenToRunning(0.0);
}

function PlayInAir ()
{
  LoopAnim(AnimFalling,,[TweenTime]0.41,,[Type]HarryAnimType);
  ClientMessage(" animFalling = " $ string(AnimFalling));
}

function PlayDuck ()
{
  BaseEyeHeight = 0.0;
  TweenAnim('SneakF',0.25);
}

function PlayCrawling ()
{
  BaseEyeHeight = 0.0;
  LoopAnim('SneakF');
}

function PlayIdle ()
{
  if ( Mesh == None )
  {
    return;
  }
  CurrIdleAnimName = GetCurrIdleAnimName();
  LoopAnim(CurrIdleAnimName,0.81,0.25,,HarryAnimType);
}

function PlayWaiting ()
{
  if ( Mesh == None )
  {
    return;
  }
  WaitingCount++;
  if ( WaitingCount < 3 )
  {
    CurrIdleAnimName = GetCurrIdleAnimName();
    LoopAnim(CurrIdleAnimName,0.41 + 0.41 * FRand(),0.25,,HarryAnimType);
    return;
  }
  if ( FRand() < 0.5 )
  {
    CurrIdleAnimName = GetCurrIdleAnimName();
    LoopAnim(CurrIdleAnimName,0.41 + 0.41 * FRand(),0.25,,HarryAnimType);
  } else {
    WaitingCount = 0;
    CurrFidgetAnimName = GetCurrFidgetAnimName();
    if ( bVeryAfraid == True )
    {
      PlayAnim('look_frantic',1.0,0.2,HarryAnimType);
    } else {
      PlayAnim(CurrFidgetAnimName,0.5 + 0.5 * FRand(),0.31,HarryAnimType);
    }
  }
}

function TweenToWaiting (float TweenTime)
{
  if (  !HarryAnimChannel.PlayHarryMovementAnims() )
  {
    return;
  }
  if ( PlayingFidgetAnimation(AnimSequence) )
  {
    return;
  }
  if ( AnimSequence == 'look_frantic' )
  {
    return;
  }
  CurrIdleAnimName = GetCurrIdleAnimName();
  LoopAnim(CurrIdleAnimName,,[TweenTime]TweenTime,,[Type]HarryAnimType);
}

function Cast ()
{
  local Actor BestTarget;
  //local Actor HitActor;
  local Rotator defaultAngle;
  local Rotator checkAngle;
  local Pawn hitPawn;
  local Vector objectDir;
  local int bestYaw;
  local int tempYaw;
  local int defaultYaw;
  local float bestDist;
  local float TempDist;
  local string SpellIncantation;

  //log("Cast!");
  
  if ( fTimeAfterHit > 0 )
  {
    if ( (fTimeAfterHit > 1.0) && bInDuelingMode )
    {
      if ( CurrentDuelSpell == 0 )
      {
        switch (Rand(6))
        {
          case 0:
          SpellIncantation = "PC_Hry_HryDuelMW_04";
          break;
          case 1:
          SpellIncantation = "PC_Hry_HryDuelMW_05";
          break;
          case 2:
          SpellIncantation = "PC_Hry_HryDuelMW_12";
          break;
          case 3:
          SpellIncantation = "PC_Hry_HryDuelMW_13";
          break;
          case 4:
          SpellIncantation = "PC_Hry_HryDuelMW_14";
          break;
          case 5:
          SpellIncantation = "PC_Hry_HryDuelMW_15";
          break;
          default:
        }
      } else //{
        if ( CurrentDuelSpell == 1 )
        {
          switch (Rand(6))
          {
            case 0:
            SpellIncantation = "PC_Hry_HryDuelMW_06";
            break;
            case 1:
            SpellIncantation = "PC_Hry_HryDuelMW_07";
            break;
            case 2:
            SpellIncantation = "PC_Hry_HryDuelMW_08";
            break;
            case 3:
            SpellIncantation = "PC_Hry_HryDuelMW_09";
            break;
            case 4:
            SpellIncantation = "PC_Hry_HryDuelMW_10";
            break;
            case 5:
            SpellIncantation = "PC_Hry_HryDuelMW_11";
            break;
            default:
          }
        } 
		  else //{
          if ( CurrentDuelSpell == 2 )
          {
            switch (Rand(3))
            {
              case 0:
              SpellIncantation = "PC_Hry_HryDuelMW_01";
              break;
              case 1:
              SpellIncantation = "PC_Hry_HryDuelMW_02";
              break;
              case 2:
              SpellIncantation = "PC_Hry_HryDuelMW_03";
              break;
              default:
            }
          }
        //}
      //}
      if ( SpellIncantation != "" )
      {
        PlaySound(Sound(DynamicLoadObject("AllDialog." $ SpellIncantation,Class'Sound')),SLOT_Talk,0.75,True);
      }
    }
    return;
  }
  defaultAngle = Rotation;
  defaultAngle.Pitch = 0;
  defaultYaw = defaultAngle.Yaw;
  defaultYaw = defaultYaw & 65535;
  if ( defaultYaw > 32767 )
  {
    defaultYaw = defaultYaw - 65536;
  }
  BestTarget = None;
  if ( BossTarget != None )
  {
    Target = BossTarget;
  }
  if (  !baseWand(Weapon).bAutoSelectSpell )
  {
    baseWand(Weapon).CastSpell(BossTarget,vect(0.00,0.00,0.00));
    baseWand(Weapon).LastCastedSpell.SeekSpeed *= 0.25;
  } else //{
    if ( bInDuelingMode )
    {
      baseWand(Weapon).CastSpell(DuelOpponent,,DuelSpells[CurrentDuelSpell]);
      baseWand(Weapon).LastCastedSpell.SetSpellDirection(SpellCursor.Location - baseWand(Weapon).LastCastedSpell.Location);
    } else //{
      if ( bHarryUsingSword )
      {
        baseWand(Weapon).CastSpell(None,,Class'spellSwordFire');
      } else //{
        if ( SpellCursor.IsLockedOn() )
        {
          baseWand(Weapon).CastSpell(SpellCursor.aCurrentTarget,SpellCursor.vTargetOffset);
        } else {
          ClientMessage("Harry Can't cast a spell... SpellCursor.IsLockedOn = " $ string(SpellCursor.IsLockedOn()) $ " CurrentSpell = " $ string(baseWand(Weapon).CurrentSpell));
        //}
      //}
    //}
	}
  TurnOffSpellCursor();
}

function Fire (optional float f)
{
  if ( Weapon != None && bJustFired == False )
  {
    Weapon.bPointing = True;
  }
  bJustFired = True;
}

exec function AltFire (optional float f)
{
  local Vector V;
  local Rotator R;

  if ( HarryAnimChannel.IsCarryingActor() )
  {
    if ( bThrow == False && IsInState('PlayerWalking') )
    {
      ClientMessage("Throw!");
      HarryAnimChannel.GotoStateThrow();
      bThrow = True;
    }
  } 
  else 
  {
    if ( (Weapon != None) && (CarryingActor == None) &&  !bIsAiming )
    {
      Weapon.bPointing = True;
      StartAiming(bHarryUsingSword);
    }
  }
}

event Mount (Vector Delta)
{
  DropCarryingActor();
  Destination = Location + Delta;
  MountBase = Base;
  GotoState('Mounting');
}

state Mounting
{
  ignores  ProcessMove, AltFire, Mount;
  
  function BeginState ()
  {
    DebugState();
	// bFallingMount = Physics == PHYS_Walking;
    bFallingMount = Physics != PHYS_Walking; //thanks to Metallicafan212 for finding this -AdamJD
    Velocity = vect(0.00,0.00,0.00);
    Acceleration = vect(0.00,0.00,0.00);
    SetPhysics(PHYS_Projectile);
    SetBase(MountBase);
  }
  begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  DesiredRotation.Yaw = rotator(Vec(Destination.X,Destination.Y,Location.Z) - Location).Yaw;
  DesiredRotation.Pitch = 0;
  MountDelta = Destination - Location;
  MountDelta -= Normal(MountDelta * vect(1.00,1.00,0.00)) * 30;
  if ( bFallingMount && (MountDelta.Z >= 80 * DrawScale) )
  {
    MountDelta.Z -= 82 * DrawScale;
    PlayAnim('climb96end',,0.2,,[RootBone] 'Move');
    PlayFallingPullupEmoteSound();
  } 
  else 
  {
    if ( MountDelta.Z < 48 * DrawScale )
    {
      MountDelta.Z -= 32 * DrawScale;
      PlayAnim('climb32',1.0,,,[RootBone] 'Move');
      PlayEasyPullupEmoteSound();
    } 
	else 
	{
      if ( MountDelta.Z < 80 * DrawScale )
      {
        MountDelta.Z -= 64 * DrawScale;
        PlayAnim('climb64',,,,[RootBone] 'Move');
        PlayHardPullupEmoteSound();
      } 
	  else 
	  {
        MountDelta.Z -= 96 * DrawScale;
        PlayAnim('climb96start',,,,[RootBone] 'Move');
      }
    }
  }
  GotoState('MountFinish');
}

state MountFinish
{
  ignores  ProcessMove, AltFire, Mount;
  
  event PlayerTick (float DeltaTime)
  {
    local Vector V;
  
    Velocity = vect(0.00,0.00,0.00);
    Acceleration = vect(0.00,0.00,0.00);
    V = MountDelta * DeltaTime * AnimRate;
    V *= vect(0.00,0.00,1.00);
    Move(V);
    ViewRotation = Rotation;
  }
  
  function BeginState ()
  {
    DebugState();
    SetCollisionSize(CollisionRadius * 0.5,CollisionHeight * 0.5,CollisionHeight * 0.5);
    PrePivot.Z -= CollisionHeight;
  }
  
  function EndState ()
  {
    PrePivot.Z += CollisionHeight;
    SetCollisionSize(CollisionRadius * 2,CollisionHeight * 2,0.0);
  }
  begin:
  if ( AnimSequence == 'climb96start' )
  {
    MountDelta *= 0.5;
    FinishAnim();
    PlayAnim('climb96end',,,,[RootBone] 'Move');
    PlayHardPullupEmoteSound();
  }
  FinishAnim();
  SetPhysics(PHYS_Walking);
  CurrIdleAnimName = GetCurrIdleAnimName();
  PlayAnim(CurrIdleAnimName,1.0,0.2);
  GotoState('PlayerWalking');
}

state statePickBitOfGoyle
{
	begin:
		Velocity = vect(0.00,0.00,0.00);
		Acceleration = vect(0.00,0.00,0.00);
		StopAllMusic(0.0);
		PlayMusic("sm_Ingredient_Success_Music",0.0);
		PlayAnim('PickBitOfGoyle',1.0,0.2);
		FinishAnim();
		bFinishPickBitOfGoyle = True;
		GotoState('PlayerWalking');
}

state ChessDeath
{
	begin:
		DebugState();
		KillHarry(True);
}

function DoCelebrateCardSet (bool bCelebrateBronzeIn)
{
  bCelebrateBronze = bCelebrateBronzeIn;
  GotoState('CelebrateCardSet');
}

state CelebrateCardSet
{
  event BeginState ()
  {
    nCelebrateProgress = 0;
  }
  
  event EndState ()
  {
    if ( nCelebrateProgress < 1 )
    {
      if ( bCelebrateBronze )
      {
        PlaySound(Sound'health_boost1');
        GetHealthStatusItem().IncrementCountPotential(StatusItemHealth(GetHealthStatusItem()).nUnitsPerIcon);
      }
    }
    if ( nCelebrateProgress < 2 )
    {
      Cam.SetCameraMode(Cam.ECamMode.CM_Transition);
    }
  }
  begin:
	  Cam.SetCameraMode(Cam.ECamMode.CM_CutScene);
	  Cam.CamTarget.SetAttachedTo(self);
	  Cam.SetSyncPosWithTarget(True);
	  Cam.SetSyncRotWithTarget(False);
	  Cam.SetZOffset(25.0);
	  Cam.SetPitch(-6000.0);
	  Cam.SetDistance(100.0);
	  Cam.SetRotStepYaw(-12288.0);
	  PlayAnim('celebrate',1.0,0.2);
	  if ( bCelebrateBronze )
	  {
		Sleep(1.5);
		PlaySound(Sound'health_boost1');
		GetHealthStatusItem().IncrementCountPotential(StatusItemHealth(GetHealthStatusItem()).nUnitsPerIcon);
	  }
	  nCelebrateProgress = 1;
	  FinishAnim();
	  Cam.SetCameraMode(Cam.ECamMode.CM_Transition);
	  nCelebrateProgress = 2;
	  while ( Cam.CameraMode == Cam.ECamMode.CM_CutScene )
	  {
		Sleep(0.1);
		//goto JL011E;
		//goto begin;
		//return;
	  }
	  GotoState('PlayerWalking');
}

function Bump (Actor Other)
{
  Super.Bump(Other);
  PickupActor(Other);
}

//turn on no falling damage if Harry has touched the NoFallingDamageTrigger -AdamJD
function Touch(Actor Other)
{
  Super.Touch(Other);
  
  if(Other.IsA('NoFallingDamageTrigger'))
  {
	bNoFallingDamage = true;
  }
}

function StartAimSoundFX ()
{
  if ( bInDuelingMode && (CurrentDuelSpell == 2) )
  {
    return;
  }
  PlaySound(Sound'Spell_aim',SLOT_Misc);
  if ( bInDuelingMode && (CurrentDuelSpell == 1) )
  {
    PlaySound(Sound'Dueling_MIM_buildup',SLOT_Interact);
  } else {
    PlaySound(Sound'spell_loop_nl',SLOT_Interact);
  }
}

function StopAimSoundFX ()
{
  StopSound(Sound'spell_dud',SLOT_Misc);
  if ( bInDuelingMode && (CurrentDuelSpell == 1) )
  {
    StopSound(Sound'Dueling_MIM_buildup',SLOT_Interact);
  } else {
    StopSound(Sound'spell_loop_nl',SLOT_Interact);
  }
}

function StartAiming (bool in_bHarryUsingSword)
{
}

/*
function StopAiming ()
{
  if ( CarryingActor == None )
  {
    HarryAnimChannel.GotoState('stateIdle');
    HarryAnimType = 0;
    TurnOffCastingVars();
    TurnOffSpellCursor();
    if ( bHarryUsingSword )
    {
      StopSound(Sound'sword_buildup',3);
    }
  }
}
*/
function StopAiming()
{
	//ClientMessage("StopAiming()");

	//Dont even bother trying to do this if you're carrying something.  You wont be aiming FOR SURE.
	if( CarryingActor == none )
	{
		HarryAnimChannel.GotoState( 'stateIdle' );
		HarryAnimType = AT_Replace;
		TurnOffCastingVars();
		TurnOffSpellCursor();
		
		if ( bHarryUsingSword )
		{
		  StopSound(Sound'sword_buildup',SLOT_Interact);
		}
	}
}

function TurnOffCastingVars ()
{
  bIsAiming = False;
  bIsAimingWithCharge = False;
}

function TurnOffSpellCursor ()
{
  bIsAimingWithCharge = False;
  baseWand(Weapon).StopChargingSpell();
  SpellCursor.TurnTargetingOff();
  GroundSpeed = GroundRunSpeed;
}

function TurnOnCastingVars (bool in_bHarryUsingSword)
{
  bIsAiming = True;
  bIsAimingWithCharge = True;
  if ( bInDuelingMode )
  {
    if ( CurrentDuelSpell != 2 )
    {
      baseWand(Weapon).StartChargingSpell(True,in_bHarryUsingSword,DuelSpells[CurrentDuelSpell]);
    } else {
      baseWand(Weapon).StartChargingSpell(False,in_bHarryUsingSword,DuelSpells[CurrentDuelSpell]);
    }
  } else {
    baseWand(Weapon).StartChargingSpell(False,in_bHarryUsingSword);
  }
}

function bool PlayerIsAiming ()
{
  return bIsAiming;
}

function bool PlayerIsAimingWithCharge ()
{
  return bIsAimingWithCharge;
}

function PlayerTick (float dtime)
{

	//cm("Current state is " $ GetStateName());

  if ( fTimeAfterShield > 0 )
  {
    fTimeAfterShield -= dtime;
  }
  if ( bInDuelingMode && (fTimeAfterShield <= 0) && baseWand(Weapon).fxChargeParticles.IsA('Exep_Shield') )
  {
    baseWand(Weapon).StartGlowingWand(DuelSpells[CurrentDuelSpell]);
  }
  if ( fTimeAfterHit > 0 )
  {
    fTimeAfterHit -= dtime;
  }
  fTimeSinceLastAcidHit += dtime;
  if ( CurrentAnimHasFootStepSounds() )
  {
    if ( AnimSequence != 'run' )
    {
      if ( (AnimFrame >= 0.5) && (LastAnimFrame < 0.5) || AnimFrame < LastAnimFrame )
      {
        PlayFootStep();
      }
    } else {
      if ( (AnimFrame < LastAnimFrame) || (AnimFrame >= 0.25) && (LastAnimFrame < 0.25) || (AnimFrame >= 0.5) && (LastAnimFrame < 0.5) || (AnimFrame >= 0.75) && (LastAnimFrame < 0.75) )
      {
        PlayFootStep();
      }
    }
  }
  LastAnimFrame = AnimFrame;
  ViewRotation = BaseCam(ViewTarget).rCurrRotation;
  ViewShake(dtime);
  if ( ViewTarget != None )
  {
    BaseCam(ViewTarget).rExtraRotation = ViewRotation - BaseCam(ViewTarget).rCurrRotation;
  }
  if (  !bDisplayedFirstErrorMessages )
  {
    bDisplayedFirstErrorMessages = True;
    DisplayFirstErrorMessages();
  }
}

function DisplayFirstErrorMessages ()
{
  local Actor A;
  local Actor a2;

  if ( HPConsole(Player.Console).bDebugMode )
  {
    foreach AllActors(Class'Actor',A)
    {
      if ( (A.CutName != "") && (A.IsA('CutScene') || A.IsA('CutCameraPos') || A.IsA('CutMark')) )
      {
        foreach AllActors(Class'Actor',a2)
        {
          if ( (a2.IsA('CutScene') || a2.IsA('CutCameraPos') || a2.IsA('CutMark')) && (a2 != A) && (a2.CutName ~= A.CutName) )
          {
            ClientMessage("**** ERROR: Actor:" $ string(a2.Name) $ " has same CutName as " $ string(A.Name) $ ".  CutName:" $ A.CutName);
          }
        }
      }
    }
  }
}

function bool CurrentAnimHasFootStepSounds ()
{
  switch (AnimSequence)
  {
    case 'run':
    case 'runback':
    case 'StrafeLeft':
    case 'StrafeRight':
    case 'Walk':
    case 'ectowalk':
    case 'EctoWalkback':
    case 'ectostraferight':
    case 'ectostrafeleft':
    case 'SwordRun':
    case 'SwordRunback':
    case 'SwordStrafeRight':
    case 'SwordStrafeLeft':
    case 'duel_run':
    case 'duel_runback':
    case 'duel_strafe_right':
    case 'duel_strafe_left':
    return True;
    default:
  }
  return False;
}

/*
function bool PlayingIdleAnimation (name animseqname)
{
  local string AnimName;
  local int I;
  local name nm;

  I = 1;
  if ( I <= 16 )
  {
    AnimName = "idle_" $ string(I);
    nm = StringToAnimName(AnimName);
    if ( nm == animseqname )
    {
      return True;
    }
    I++;
    goto JL0007;
  }
  return False;
}
*/

function bool PlayingIdleAnimation(name animseqname)
{
	local string animName;
	local int	i;
	local name	nm;

	for ( i = 1; i <= 16; i++)
	{
		animName = "idle_" $i;
		nm = StringToAnimName(animName);
		if(nm == animseqname)
			return true;
	}

	return false;
}

/*
function bool PlayingFidgetAnimation (name animseqname)
{
  local string AnimName;
  local int I;
  local name nm;

  I = 1;
  if ( I <= 16 )
  {
    AnimName = "fidget_" $ string(I);
    nm = StringToAnimName(AnimName);
    if ( nm == animseqname )
    {
      return True;
    }
    I++;
    goto JL0007;
  }
  return False;
}
*/

function bool PlayingFidgetAnimation(name animseqname)
{
	local string animName;
	local int	i;
	local name	nm;

	for ( i = 1; i <= 16; i++)
	{
		animName = "fidget_" $i;
		nm = StringToAnimName(animName);
		if(nm == animseqname)
			return true;
	}

	return false;
}

function name MyGetAnimGroup (name animseqname)
{
  if ( PlayingIdleAnimation(animseqname) )
  {
    return 'Waiting';
  }
  if ( PlayingFidgetAnimation(animseqname) )
  {
    return 'Waiting';
  }
  if ( AnimSequence == 'look_frantic' )
  {
    return 'Waiting';
  }
  return 'None';
}

function SetNewMesh ()
{
  if ( bIsGoyle && (Mesh == SkeletalMesh'skharryMesh') )
  {
    Mesh = SkeletalMesh'skGoyleMesh';
    DrawScale = 1.14999998;
  }
  if (  !bIsGoyle && (Mesh == SkeletalMesh'skGoyleMesh') )
  {
    Mesh = SkeletalMesh'skharryMesh';
    DrawScale = 1.0;
  }
}

function SpawnParticles (Class<ParticleFX> Particles)
{
  Spawn(Particles,,,Location,rot(0,0,0));
}

function AutoHitAreaEffect (float fRadius)
{
	local HPawn Pawn;
	//local spellTrigger Trigger;
	local spellTrigger spTrigger;

	foreach AllActors(Class'HPawn',Pawn)
	{
		if ( VSize(Pawn.Location - Location) < fRadius )
		{
			if ( Pawn.eVulnerableToSpell != 0 )
			{
				Pawn.CallHandleSpellBySpellType(Pawn.eVulnerableToSpell,Pawn.Location);
			}
			if ( (Pawn.Owner == None) && (Pawn.IsA('Jellybean') || Pawn.IsA('WizardCardIcon')) )
			{
				Pawn.SetPhysics(PHYS_Falling);
				Pawn.Velocity = Vec(0.0,0.0,300.0) + Normal(Pawn.Location - Location) * 100 * FRand();
			}
		}	
	}
	foreach AllActors(Class'spellTrigger',spTrigger)
	{
		if ( spTrigger.eVulnerableToSpell != SPELL_None && (VSize(spTrigger.Location - Location) < fRadius) )
		{
			spTrigger.Activate(self,self);
		}
	}
  
	// Metallicafan212: Correct particles?
	SpawnParticles(Class'DustCloud03_med');
}

/*
function CreateSpongifyEffects ()
{
  local int I;

  return;
  if ( SpongifyFX[0] == None )
  {
    SpongifyFX[0] = Spawn(Class'SpellVoldTrackingFX',self);
    SpongifyFX[0].AttachToOwner('bip01 R Foot');
    if ( SpongifyFX[1] == None )
    {
      SpongifyFX[1] = Spawn(Class'SpellVoldTrackingFX',self);
      SpongifyFX[1].AttachToOwner('bip01 L Foot');
    }
  }
  I = 0;
  if ( I < 2 )
  {
    SpongifyFX[I].bEmit = True;
    I++;
    goto JL0071;
  }
}
*/

function CreateSpongifyEffects()
{
	local int   i;

return;

	if( SpongifyFX[0] == none )
		{ SpongifyFX[0] = spawn( class'SpellVoldTrackingFX', self );       SpongifyFX[0].AttachToOwner( 'Bip01 R Foot' );
	if( SpongifyFX[1] == none )
		{ SpongifyFX[1] = spawn( class'SpellVoldTrackingFX', self );       SpongifyFX[1].AttachToOwner( 'Bip01 L Foot' ); }}

	for( i = 0; i < NUM_SPONGIFY_FX; i++ )
		SpongifyFX[i].bEmit = true;
}

/*
function StopSpongifyEffects ()
{
  local int I;

  I = 0;
  if ( I < 2 )
  {
    SpongifyFX[I].bEmit = False;
    I++;
    goto JL0007;
  }
}
*/
function StopSpongifyEffects()
{
	local int   i;

	for( i = 0; i < NUM_SPONGIFY_FX; i++ )
		SpongifyFX[i].bEmit = false;
}

state PlayerWalking
{
  //ignores  PlayerTick, Landed, TakeDamage, HitWall, Bump, UnTouch, Touch;
  ignores SeePlayer, HearNoise;
  
  //UTPT didn't add these events... -AdamJD
  event Touch( Actor Other )
  {
	// Let the director (if any) know when Harry touches things
	if ( Director != None )
		Director.OnTouchEvent( Self, Other );

	Global.Touch( Other );
  }

  event UnTouch( Actor Other )
  {
	// Let the director (if any) know when Harry stops touching things
	if ( Director != None )
		Director.OnUnTouchEvent( Self, Other );

	Global.UnTouch( Other );
  }

  event Bump( Actor Other )
  {
	// Let the director (if any) know when Harry bumps things
	if ( Director != None )
		Director.OnBumpEvent( Self, Other );

	Global.Bump( Other );
  }
  
  event HitWall( vector HitNormal, Actor Wall )
  {
	// Let the director (if any) know when Harry hits things
	if ( Director != None )
		Director.OnHitEvent( Self );

	Global.HitWall( HitNormal, Wall );
  }
  
  //update the director about damage types (UTPT didn't add this) -AdamJD
  event TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
  {
	if ( Director != None )
	{
		Director.OnTakeDamage( Self, Damage, InstigatedBy, DamageType );
	}
	
	Global.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
  }
  
  function ZoneChange (ZoneInfo NewZone)
  {
    if ( NewZone.bWaterZone )
    {
      SetPhysics(PHYS_Swimming);
      GotoState('PlayerSwimming');
    }
  }

  function AnimEnd ()
  {
    local name MyAnimGroup;
  
    bAnimTransition = False;
    bJustFired = False;
    bJustAltFired = False;
    if (Physics == PHYS_Walking )
    {
      MyAnimGroup = MyGetAnimGroup(AnimSequence);
      if ( (Velocity.X * Velocity.X + Velocity.Y * Velocity.Y) < 1000 )
      {
        if ( MyAnimGroup == 'Waiting' )
        {
          PlayWaiting();
        } 
		else 
		{
          bAnimTransition = True;
          TweenToWaiting(0.41);
        }
      } 
	  else 
	  {
        if ( bIsWalking )
        {
          if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing') )
          {
            TweenToWalking(0.41);
            bAnimTransition = True;
          } 
		  else 
		  {
            PlayWalking();
          }
        } 
		else 
		{
          if ( (MyAnimGroup == 'Waiting') || (MyAnimGroup == 'Landing') )
          {
            bAnimTransition = True;
            TweenToRunning(0.41);
          } 
		  else 
		  {
            PlayRunning();
          }
        }
      }
    } 
	else 
	{
      PlayInAir();
    }
  }
  
  function StartAiming (bool in_bHarryUsingSword)
  {
    if (  !bIsAiming && (CarryingActor == None)  )
    {
      TurnOnCastingVars(in_bHarryUsingSword);
      bJustFired = False;
      bJustAltFired = False;
      HPConsole(Player.Console).bSpaceReleased = False;
      HPConsole(Player.Console).bSpacePressed = False;
      if ( in_bHarryUsingSword )
      {
        PlaySound(Sound'sword_buildup',SLOT_Interact);
      } 
	  else 
	  {
        StartAimSoundFX();
        makeTarget();
      }
      HarryAnimChannel.GotoStateCasting(in_bHarryUsingSword);
      HarryAnimType = AT_Combine;
    }
  }
  
  function Landed(vector HitNormal)
  {
	local float fFallDistanceZ;
	local int   i;

	clientMessage("landed: jump dist = " $VSize(Location-MountDelta) $ "   tia="$fTimeInAir);
		
	Global.Landed(HitNormal);

	PlayLandedSound();

	playanim(HarryAnims[HarryAnimSet].land, [TweenTime]0.1, [Type] HarryAnimType);

	//log("PLOG PWalking landed");

	// Set our spell distance to the default if we landed from a spongify jump
	if( !bExtendedTargetting && AnimFalling == SpongifyFallAnim )
		SpellCursor.SetLOSDistance( 0 );
		
	// See if we laneded on spongify!
	for(i=0; i<ArrayCount(Touching); i++)
	{
		if( Touching[i].IsA('SpongifyPad') &&
			SpongifyPad(Touching[i]).IsEnabled() )
		{
			// We landed on a spongifyPad an
			HitSpongifyPad = SpongifyPad(Touching[i]);
				
			// Set our spell distance longer so we can easily target the next spongify pad
			// The spell distance will revert back to normal once we land from a spongify pad
			if( !bExtendedTargetting )
				SpellCursor.SetLOSDistance( 1024 );
		}
	}
		
	//if( AnimFalling == SpongifyFallAnim  &&  HitSpongifyPad == none )
		StopSpongifyEffects();

	// We didn't land on a spongify pad and we are not falling from a spongify pad bounce
	if( AnimFalling != SpongifyFallAnim && HitSpongifyPad == None )
	{
		// we are doing a regular fall animation
		ClientMessage("Z Fall Distance = " $(fHighestZ-location.z) $" TimeInAir = " $fTimeInAir
						$"ZHighest = " $fHighestZ $"ZLoc = " $location.z );
									
		fFallDistanceZ = (fHighestZ-location.z);
			
		// if we fell for a long distance then hurt harry
		if( fFallDistanceZ > FALL_DAMAGE_DISTANCE 
			&& !bNoFallingDamage ) //only take damage if bNoFallingDamage is false -AdamJD
		{
			// The farther you fall the more damage you get
			if( fFallDistanceZ < FALL_DAMAGE_DISTANCE + 32 )	// 512 - 544
				TakeDamage(20, self, location,vec(0,0,0), 'Falling' );
			else
			if( fFallDistanceZ < FALL_DAMAGE_DISTANCE + 64 )	// 
				TakeDamage(30, self, location,vec(0,0,0), 'Falling' );
			else
			if( fFallDistanceZ < FALL_DAMAGE_DISTANCE + 256 )	// 
				TakeDamage(50, self, location,vec(0,0,0), 'Falling' );
			else
			if( fFallDistanceZ < FALL_DAMAGE_DISTANCE + 512 )	// 
				TakeDamage(100, self, location,vec(0,0,0), 'Falling' );
			else
			if( fFallDistanceZ < FALL_DAMAGE_DISTANCE + 1024 )	// 
				TakeDamage(200, self, location,vec(0,0,0), 'Falling' );
			else
			{													// 768 - 
				TakeDamage(99999, self, location,vec(0,0,0), 'Falling' );
			}
		}
	}
		
	// Reset our falling animation
	AnimFalling = HarryAnims[HarryAnimSet].fall;

	// Reset our highestZ position
	fHighestZ = default.fHighestZ;
	
	//turn bNoFallingDamage back off if it was turned on -AdamJD
	if(bNoFallingDamage)
	{
		bNoFallingDamage = false;
	}
  }
  
  event PlayerTick( float DeltaTime )
  {
	local actor a;
	local float d;
	local actor ca;

	Global.PlayerTick( DeltaTime );

	//if(	GetHealthCount() < 5 )
	//	DoDrinkWiggenwell();

	//		d = 1000000;
	//		ForEach AllActors(class'actor', a)
	//		{
	//			if( a == self )
	//				continue;
	//			//if( a.IsA('basewand') )
	//			//	continue;
	//			if( VSize( a.location - Location ) < 500 )
	//			{
	//				Log("*****:"$a$" a.h:"$a.bHidden$" dt:"$a.DrawType);
	//				d = VSize( a.location - Location );
	//				ca = a;
	//			}
	//		}
	//		ClientMessage("ca:"$ca);

	if( bTempKillHarry )// ||  lifePotions <= 0 )
	{
		bTempKillHarry = false;
		KillHarry(true);
	}

	//Weird problem, not sure what's causing it, but sometimes when you touch a painzone, but start your climb
	// you'll end up with no health, but not in the dying state.  This "safely" takes care of that.
	if( GetHealthCount() <= 0 )
	{
		KillHarry(true);
		return;
	}

	//if ( bUpdatePosition )   Might not be able to just remove this.
	//	ClientUpdatePosition();

	if( bIsAiming && HarryAnimChannel.IsInState('stateCasting') && bAltFire == 0 )
	{
		//HarryAnimChannel.

		//if( HarryAnimChannel.AnimSequence == 'castaim' )
		//{
			ClientMessage("LoopAim done");
			//PlaySound(sound'HPSounds.Magic_sfx.spell_loop_nl', [Volume]0);
			StopAimSoundFX();
				
			if( bInDuelingMode )
			{
				if(DuelSpells[CurrentDuelSpell] == class'spellDuelExpelliarmus')
				{
				 	PlaySound( Sound'HPSounds.Magic_sfx.Dueling_EXP_swoosh' );
					HarryAnimChannel.GotoState( 'stateDefenceCast' );
				}
				else
					HarryAnimChannel.GotoState( 'stateDuelingCast' );
				}
			else
			if(   SpellCursor.IsLockedOn() //If harry's locked on, he's in normal aim mode, so cast
			   || bHarryUsingSword && baseWand(weapon).SwordChargedUpEnough() //if using sword, and sword is charged up enough
			   || !baseWand(weapon).bAutoSelectSpell // if you're not in autoselect spell mode
			  )
			{
				HarryAnimChannel.GotoState( 'stateCast' );//PlayAnim('cast', 2.0, 0.1);
				if( bCastFastSpells )  //Old, may not be needed in HP2
				{
					AnimFrame = 0.09;
					AnimRate = 3;
				}
			}
			else
			{
				// We don't have a lock so lets stop casting
				HarryAnimChannel.GotoState( 'stateCancelCasting' );

				// Stop Aiming
				StopAiming();					
			}
		//}
	}

	//Try and save how long you've been falling, and what you're original height was when you started falling
	ProcessFalling( DeltaTime );

	PlayerMove(DeltaTime);

	if( CarryingActor != none )
	{
		//r = weaponRot;
		//v = vect(0,0,1);
		//v = v >> r;
		CarryingActor.setLocation( weaponLoc );//- vect(0,0,1 );
		CarryingActor.SetRotation( weaponRot );

		//Also, look for a spacebar throw
		if( hpconsole(player.console).bSpacePressed )
		{
			hpconsole(player.console).bSpacePressed = false;
			AltFire(0);
		}
	}
		
	// If we landed on a spongify pad then bounce harry
	if( HitSpongifyPad != None && HitSpongifyPad.IsEnabled() )
	{
		DoJump(0);
		HitSpongifyPad.OnBounce( self );
		AnimFalling = SpongifyFallAnim;
		PlayinAir();
		cam.SetPitch(-8000);
		HitSpongifyPad = None;
		CreateSpongifyEffects();
	}
		
	// HP2 cam
	if( cam.IsInState('StateStandardCam') )//|| cam.IsInState('StateBossCam') )
	{
		// Force our desired Yaw to what the camera's yaw is, in this way harry will
		// always "lookAt" what the camera is looking at.
			DesiredRotation.Yaw = cam.rotation.Yaw & 0xFFFF;
	}
  }
  
  /*
  function ProcessFalling (float DeltaTime)
  {
    local float fLastTimeInAir;
	
	log("ProcessFalling!");
  
    if ( Physics == PHYS_Falling )
    {
		log("ProcessFalling when falling!");
      if ( eLastPhysState != PHYS_Falling )
      {
        fFallingZ = Location.Z;
        fHighestZ = Location.Z;
      } 
	  else 
	  {
        if ( fHighestZ < Location.Z )
        {
          fHighestZ = Location.Z;
        }
      }
      fLastTimeInAir = fTimeInAir;
      fTimeInAir += DeltaTime;
      if (  !bPlayedFallSound && (fTimeInAir > 1.5) )
      {
        bPlayedFallSound = True;
        if ( AnimFalling != SpongifyFallAnim )
        {
			log("Playing fall deep sound!");
			PlayFallDeepEmoteSound();
        }
      }
      if ( (fLastTimeInAir <= 0.35) && (fTimeInAir > 0.35) )
      {
		log("Play in air!");
        PlayInAir();
      }
    } 
	else 
	{
      bPlayedFallSound = False;
      fTimeInAir = 0.0;
    }
    eLastPhysState = Physics;
  }
  */
	
  //Try and save how long you've been falling, and what you're original height was when you started falling
  //When you land, it uses this info to set the sound volume.
  function ProcessFalling( float DeltaTime )
  {
	local float fLastTimeInAir;
		
	if( Physics == PHYS_Falling )
	{
		if( eLastPhysState != PHYS_Falling )
		{
			fFallingZ = Location.z;
			fHighestZ = location.z;
		}
		else // Save the highest z location for falling damage
		if( fHighestZ < location.z )
		{
			fHighestZ = location.z;
		}
			
		fLastTimeInAir = fTimeInAir;
		fTimeInAir += DeltaTime;

		if( !bPlayedFallSound  &&  fTimeInAir > 1.5 )
		{
			bPlayedFallSound = true;

			if( AnimFalling != SpongifyFallAnim )
				// PlaySound( sound'HPSounds.HAR_emotes.falldeep2' );
				PlayFallDeepEmoteSound(); //decide which fall deep sound to play -AdamJD
		}

		if( fLastTimeInAir <= 0.35   &&   fTimeInAir > 0.35 )
			PlayInAir();
		}
	else
	{
		bPlayedFallSound = false;
		fTimeInAir = 0;
	}

	eLastPhysState = Physics;
  }
  
  function JumpOffPawn ()
  {
    fTimeInAir = 0.0;
    Super.JumpOffPawn();
  }
  
  function PlayerMove (float DeltaTime)
  {
    local Vector X;
    local Vector Y;
    local Vector Z;
    local Vector NewAccel;
    local EDodgeDir OldDodge;
    local EDodgeDir DodgeMove;
    local Rotator OldRotation;
    local Rotator CamRot;
    local float Speed2D;
    local bool bSaveJump;
    local name AnimGroupName;
  
	//log("Player move!");
  
    if ( bReverseInput )
    {
      aForward = Abs(aForward * 2);
      aTurn =  -aTurn;
      aStrafe =  -aStrafe;
    }
    aForward *= 0.08;
    if ( Physics == PHYS_Falling || bLockedOnTarget || bFixedFaceDirection ) 
    {
      aStrafe *= 0.08;
      aTurn = 0.0;
    } 
	else 
	{
      aStrafe *= 0.08;
      aTurn *= 0.24;
    }
    aLookUp *= 0;
    aSideMove *= 0.1;
    if ( Adv1TutManager != None )
    {
      if ( aForward > 0 )
      {
        Adv1TutManager.ForwardPushed();
      }
      if ( aForward < 0 )
      {
        Adv1TutManager.BackwardPushed();
      }
      if ( aStrafe < 0 )
      {
        Adv1TutManager.StrafeLeftPushed();
      }
      if ( aStrafe > 0 )
      {
        Adv1TutManager.StrafeRightPushed();
      }
    }
    if ( bKeepStationary )
    {
      aForward = 0.0;
      aStrafe = 0.0;
    }
    if ( bLockOutForward && (aForward > 0) || bLockOutBackward && (aForward < 0) )
    {
      aForward = 0.0;
    }
    if ( bLockOutStrafeLeft && (aStrafe < 0) || bLockOutStrafeRight && (aStrafe > 0) )
    {
      aStrafe = 0.0;
    }
    if ( bLockedOnTarget || bFixedFaceDirection )
    {
      NewAccel = ProcessAccel();
    } 
	else 
	{
      GetAxes(Rotation,X,Y,Z);
      if ( bScreenRelativeMovement )
      {
        GetAxes(Cam.Rotation,X,Y,Z);
        NewAccel = aForward * X + aSideMove * Y;
        if ( NewAccel != vect(0.00,0.00,0.00) )
        {
          CamRot = Cam.Rotation;
          CamRot.Pitch = 0;
          ScreenRelativeMovementYaw = (rotator(NewAccel)).Yaw;
        }
      } 
	  else 
	  {
        NewAccel = aForward * X + aStrafe * Y;
        if ( bInDuelingMode )
        {
          NewAccel *= 1000000;
        }
      }
    }
    if ( bHarryUsingSword )
    {
      GroundSpeed = GroundRunSpeed * (1.0 - 0.9 * baseWand(Weapon).ChargingLevel());
    }
    if ( (aForward != 0) &&  !bIsAiming )
    {
      bHarryMovingNotAiming = True;
    } 
	else 
	{
      bHarryMovingNotAiming = False;
    }
    NewAccel.Z = 0.0;
    AnimGroupName = GetAnimGroup(AnimSequence);
    OldRotation = Rotation;
    ProcessMove(DeltaTime,NewAccel,DodgeMove,OldRotation - Rotation);
    if ( Cam.IsInState('StateStandardCam') )
    {
      DesiredRotation.Yaw = Cam.Rotation.Yaw & 0xFFFF;
      if ( bHarryMovingNotAiming && bAutoCenterCamera &&  !bInDuelingMode )
      {
        if ( AnimFalling != SpongifyFallAnim )
        {
          Cam.SetPitch(-1500.0);
        }
      }
    }
  }
  
  /*
  function ProcessMove (float DeltaTime, Vector NewAccel, EDodgeDir DodgeMove, Rotator DeltaRot)
  {
    local Vector OldAccel;
    local float Speed;
  
    OldAccel = Acceleration;
    Acceleration = NewAccel;
    bIsTurning = Abs(byte(DeltaRot.Yaw) / DeltaTime) > byte(5000);
    if ( bJustAltFired || bJustFired )
    {
      Velocity = vect(0.00,0.00,0.00);
      return;
    }
    if ( bPressedJump )
    {
      DoJump();
      bPressedJump = False;
    }
    if ( Physics == 1 )
    {
      Speed = VSize2D(Velocity);
      if ( ( !bAnimTransition || (AnimFrame > byte(0))) &&  !(AnimSequence == HarryAnims[HarryAnimSet].Land) && ((Speed < byte(5)) || (VSize2D(Acceleration) == byte(0))) )
      {
        if ( Speed > byte(5) )
        {
          fTimeWalking += DeltaTime;
        } else {
          fTimeWalking = 0.0;
        }
        if ( (Acceleration != vect(0.00,0.00,0.00)) && (Speed > byte(1)) )
        {
          bAnimTransition = True;
          TweenToRunning(0.41);
        } else {
          bAnimTransition = True;
          TweenToWaiting(0.41);
        }
      }
    }
  }
  */
  function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)	
	{
		local vector OldAccel;
		local float  Speed;
		
		//log("ProcessMove!");

		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );

		if(bJustAltFired || bJustFired)
		{
			Velocity = vect(0,0,0);
			return;
		}

		if ( bPressedJump )
		{
//			ClientMessage("Jump pressed");
			DoJump();			// jumping
			bPressedJump = false;
		}

		if ( (Physics == PHYS_Walking)  )
		{
			Speed = VSize2d( Velocity );

			if(   (!bAnimTransition || (AnimFrame > 0))
			   && !( AnimSequence == HarryAnims[HarryAnimSet].Land && (Speed < 5 || VSize2D(acceleration)==0) )  //You need to NOT be (landing and not-moving)    //(GetAnimGroup(AnimSequence) != 'Landing') )
			  )
			{
				//ClientMessage("AnimSequence:"$AnimSequence$" AnimGroup:"$GetAnimGroup(AnimSequence)$" Speed:"$Speed);

				if( Speed > 5 )
					fTimeWalking += DeltaTime;
				else
					fTimeWalking = 0;

				if(   Acceleration != vect(0,0,0)
				   && Speed > 1 //you need a little bit of motion 
				   //&& (    bMovingBackwards   && Speed > 30
				   //    || !bMovingBackwards   && Speed > 65
				   //    ||  fTimeWalking > 0.5 && Speed > 15
				   //   )
				  )
				{
						bAnimTransition = true;
						TweenToRunning(0.4);
				}
			 	else
			 	{
						bAnimTransition = true;
						TweenToWaiting(0.4);
				}
			}
		}
	}
  
  function BeginState ()
  {
    DebugState();
    if ( Mesh == None )
    {
      SetMesh();
    }
    WalkBob = vect(0.00,0.00,0.00);
    DodgeDir = DODGE_None;
    bIsCrouching = False;
    bIsTurning = False;
    bPressedJump = False;
	DesiredRotation.Pitch = Default.DesiredRotation.Pitch; //sometimes after a cutscene or when Harry has picked something up he tilts, this fixes that -AdamJD 
    if ( Physics != PHYS_Falling )
    {
      SetPhysics(PHYS_WALKING);
    }
    if (  !IsAnimating() )
    {
      PlayWaiting();
    }
    foreach AllActors(Class'BaseCam',Cam)
    {
      //goto JL007F;
	  break;
    }
  }
  
  function EndState ()
  {
    WalkBob = vect(0.00,0.00,0.00);
    bIsCrouching = False;
    StopAiming();
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
    CurrIdleAnimName = GetCurrIdleAnimName();
    LoopAnim(CurrIdleAnimName,,[TweenTime]0.41,,[Type]HarryAnimType);
  }
}

function UpdateRotationToTarget ()
{
  local Rotator R;
  local Vector V;
  local Vector TargetLoc;

  if ( bFixedFaceDirection )
  {
    R = rotator(vFixedFaceDirection);
    R.Pitch = 0;
    R.Roll = 0;
    SetRotation(R);
    ViewRotation = R;
  } else //{
    if ( BossTarget != None )
    {
      if ( baseBoss(BossTarget) != None )
      {
        TargetLoc = baseBoss(BossTarget).GetHarryFaceLocation();
      } else {
        TargetLoc = BossTarget.Location;
      }
      R = rotator(TargetLoc - Location);
      R.Pitch = Rotation.Pitch;
      ViewRotation = R;
      DesiredRotation = R;
    }
  //}
}

function Vector ProcessAccel ()
{
  local float D;
  local Vector V;
  local Vector X;
  local Vector Y;
  local Vector Z;
  local Vector x2;
  local Vector y2;
  local float xMag;
  local float yMag;
  local BossRailMove B;
  local Vector N;

  if ( aForward > fLargestAForward )
  {
    fLargestAForward = aForward;
  }
  UpdateRotationToTarget();
  if ( baseBoss(BossTarget) != None )
  {
    GetAxes(rotator(baseBoss(BossTarget).GetHarryMovementCenter() - Location),X,Y,Z);
  } else {
    GetAxes(Rotation,X,Y,Z);
  }
  if ( bLockedOnTarget && BossRailMove(BossTarget) != None )
  {
	//log("AdamJD: Locked onto Peeves");
    B = BossRailMove(BossTarget);
    xMag = aForward;
    yMag = aStrafe;
    xMag -= Abs(aStrafe) * 0.25;
    V = xMag * X + yMag * Y;
    V = KeepPawnInsidePlane(V,B.v1, -B.n2);
    V = KeepPawnInsidePlane(V,B.v1,B.n1);
    V = KeepPawnInsidePlane(V,B.v2,B.n2);
    V = KeepPawnInsidePlane(V,B.v4, -B.n1);
    // if ( (V.X != 0) || (V.Y != 0) && fLargestAForward != 0 )
	if ( (V.X != 0 || V.Y != 0) && fLargestAForward != 0 ) //removed wrong brackets so Harry can move in the Peeves fight -AdamJD
    {
      V = Normal(V) * fLargestAForward;
    }
  } else {
    V = aForward * X + aStrafe * Y;
  }
  V += vAdditionalAccel;
  vAdditionalAccel = vect(0.00,0.00,0.00);
  return V;
}

function Vector KeepPawnInsidePlane (Vector vAccel, Vector vPlanePoint, Vector vPlaneNormal)
{
  local float D;
  local Vector x2;
  local Vector y2;
  local float xMag;
  local float yMag;

  D = (Location - vPlanePoint) Dot vPlaneNormal;
  if ( D > 0 )
  {
    x2 =  -vPlaneNormal;
    y2 = vect(0.00,0.00,1.00) Cross x2;
    // xMag = vAccel Dot x2;
    // yMag = vAccel Dot y2;
	xMag = (vAccel Dot x2); //added brackets -AdamJD
    yMag = (vAccel Dot y2); //added brackets -AdamJD
    if ( xMag < 0 )
    {
      xMag = D * 10;
    }
    vAccel = x2 * xMag + y2 * yMag;
  }
  return vAccel;
}

state GameEnded
{
  // ignores  Died, TakeDamage, KilledBy;
  ignores SeePlayer, HearNoise, KilledBy, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, TakeDamage, PainTimer, Died; //UTPT forgot to add these... -AdamJD
}

function Rotator AdjustAim (float ProjSpeed, Vector projStart, int AimError, bool bLeadTarget, bool bWarnTarget)
{
  local Vector FireDir;
  local Actor BestTarget;
  //local Actor HitActor;
  local Actor aHitActor;
  local Rotator defaultAngle;
  local Rotator checkAngle;
  local Pawn hitPawn;
  local Vector objectDir;
  local int bestYaw;
  local int tempYaw;
  local int defaultYaw;
  local float bestZ;

  defaultAngle = Rotation;
  defaultAngle.Pitch = 0;
  defaultYaw = defaultAngle.Yaw;
  defaultYaw = defaultYaw & 0xffff;
  FireDir = vector(defaultAngle);
  FireDir = Normal(FireDir);
  BestTarget = None;
  foreach VisibleActors(Class'Actor',aHitActor)
  {
    if ( aHitActor.bProjTarget && PlayerPawn(aHitActor) != self &&  !aHitActor.IsA('BaseCam') )
    {
      objectDir = Normal(aHitActor.Location - projStart);
      checkAngle = rotator(objectDir);
      if ( BestTarget == None )
      {
        bestYaw = checkAngle.Yaw;
        bestYaw = bestYaw & 0xFFFF;
        BestTarget = aHitActor;
        bestZ = objectDir.Z;
      } else {
        tempYaw = checkAngle.Yaw;
        tempYaw = tempYaw & 0xFFFF;
        if ( Abs(tempYaw - defaultYaw) < Abs(bestYaw - defaultYaw) )
        {
          bestYaw = tempYaw;
          BestTarget = aHitActor;
          bestZ = objectDir.Z;
        }
      }
    }
  }
  if ( BestTarget != None )
  {
    if ( Abs(bestYaw - defaultYaw) < 8000 )
    {
      FireDir.Z = bestZ;
    }
  }
  defaultAngle = rotator(FireDir);
  return defaultAngle;
}

function float TurnWhileStrafingMult ()
{
  if ( Basilisk(BossTarget) != None )
  {
	//return 0.01 + 0.14 * 1 - baseWand(Weapon).ChargingLevel();
    return 0.01 + 0.14 * (1 - baseWand(Weapon).ChargingLevel()); //UTPT forgot to add brackets which made Harry walk around in a small 360 circle when fighting basilisk instead of strafing... -AdamJD
  }
  return 0.0;
}

function Vector GetSwordFireTargetLoc ()
{
  return baseBoss(BossTarget).GetTargetLocation();
}

function Timer ()
{
  SleepyAnimTimerSub();
}

function nailed (Actor caller, out int status)
{
  if ( bustedBy == None )
  {
    bustedBy = caller;
    status = 1;
    GotoState('waitForDeath');
  } else {
    status = 0;
  }
}

function displaydemoMessage ()
{
}

state waitForDeath
{
	begin:
		DebugState();
		
	loop:
		if ( Abs(VSize(Location - bustedBy.Location)) < 150 )
		{
			MoveTo(Location);
			CurrFidgetAnimName = GetCurrFidgetAnimName();
			PlayAnim(CurrFidgetAnimName,1.0,0.2);
		} 
		else 
		{
			MoveToward(bustedBy);
			LoopAnim(HarryAnims[HarryAnimSet].run);
		}
		goto ('Loop');
}

function name GetCurrIdleAnimName ()
{
  local string AnimName;
  //local int Index;
  local int iIndex;
  local name nm;

  if ( bInDuelingMode )
  {
    IdleNums = 0;
  }
  if ( IdleNums == 0 )
  {
    return HarryAnims[int(HarryAnimSet)].Idle;
  }
  if ( (HarryAnimSet == HARRY_ANIM_SET_SLEEPY) || (HarryAnimSet == HARRY_ANIM_SET_SWORD) )
  {
    return HarryAnims[int(HarryAnimSet)].Idle;
  }
  iIndex = 1 + Rand(IdleNums);
  AnimName = "idle_" $iIndex;
  nm = StringToAnimName(AnimName);
  return nm;
}

function name GetCurrFidgetAnimName ()
{
  local string AnimName;
  //local int Index;
  local int iIndex;
  local name nm;

  if ( bInDuelingMode )
  {
    FidgetNums = 0;
  }
  if ( FidgetNums == 0 )
  {
    return GetCurrIdleAnimName();
  }
  iIndex = 1 + Rand(FidgetNums);
  AnimName = "fidget_" $iIndex;
  nm = StringToAnimName(AnimName);
  return nm;
}

function ReceiveIconMessage (Texture Icon, string Message, float duration)
{
  baseHUD(myHUD).ReceiveIconMessage(Icon,Message,duration);
}

function bool HarryIsDead ()
{
  return GetHealthCount() <= 0;
}

function startmenu ()
{
  HPConsole(Player.Console).bQuickKeyEnable = False;
  HPConsole(Player.Console).LaunchUWindow();
}

state exittoMenu
{
	begin:
		Level.Game.RestartGame();
		GotoState('harryfrozen');
}

state harryfrozen
{
  // ignores  AltFire, Fire;
  ignores Fire, AltFire, ZoneChange, AnimEnd, Landed, PlayerTick, SeePlayer, HearNoise, Bump; //UTPT forgot to add these... -AdamJD
  
  function BeginState ()
  {
  }
  
  function EndState ()
  {
  }
  
}

event PlayerCalcView (out Actor ViewActor, out Vector CameraLocation, out Rotator CameraRotation)
{
  local Pawn PTarget;

  if ( ViewTarget != None )
  {
    ViewActor = ViewTarget;
    CameraLocation = ViewTarget.Location;
    CameraRotation = ViewTarget.Rotation;
  }
}

function makeTarget ()
{
  local Vector tloc;
  //local Vector TargetOffset;
  local Vector vTargetOffsetMT; 

  vTargetOffsetMT.Y = 0.0;
  vTargetOffsetMT.X = 50.0;
  vTargetOffsetMT.Z = 0.0;
  tloc = vTargetOffsetMT >> ViewRotation;
  tloc = tloc + Location;
  if ( SpellCursor == None )
  {
    GotoState('PlayerWalking');
    ClientMessage("failed targetspawn");
    HPConsole(Player.Console).bSpaceReleased = True;
    HPConsole(Player.Console).bSpacePressed = False;
  } else {
    SpellCursor.TurnTargetingOn();
  }
}

function StartSpellLearning (SpellLessonTrigger SpellLesson)
{
  CurrSpellLesson = SpellLesson;
  GotoState('SpellLearning');
}

function EndSpellLearning ()
{
  CurrSpellLesson = None;
  GotoState('PlayerWalking');
}

state SpellLearning
{
  ignores  AltFire, ProcessMove;
  
  event PlayerInput (float DeltaTime)
  {
    Super.PlayerInput(DeltaTime);
    CurrSpellLesson.PlayerInput(DeltaTime);
  }
  
}

function StartVendorEngagement (VendorManager VManager)
{
  CurrVendorManager = VManager;
  bKeepStationary = True;
}

function EndVendorEngagement ()
{
  CurrVendorManager = None;
  bKeepStationary = False;
}

function bool IsEngagedWithVendor ()
{
  return (CurrVendorManager != None);
}

function Add60HousePointsToGryffindor ()
{
  numHousePointsHarry += 60;
  numHousePointsGryffindor += 60;
  numLastHousePointsHarry = 60;
  if ( numHousePointsSlytherin >= numHousePointsGryffindor )
  {
    numHousePointsSlytherin = numHousePointsGryffindor - 1;
  }
}

function AddHousePoints (int Num)
{
	local int temp;
	local float ftemp;

	numLastHousePointsHarry = Num;
	numHousePointsHarry += Num;
	numHousePointsGryffindor = numHousePointsHarry;
	if ( numHousePointsGryffindor < 58 )
	{
		temp = numHousePointsGryffindor + Rand(numHousePointsGryffindor) + 1;
	} 
	else 
	{
		temp = numHousePointsGryffindor + Rand(58) + 1;
	}
	if ( numHousePointsSlytherin < temp )
	{
		numHousePointsSlytherin = temp;
	}
	  
	ftemp = numHousePointsGryffindor * (0.5 + FRand() * 0.2);
	  
	  
	if ( numHousePointsHufflepuff < ftemp )
	{
		numHousePointsHufflepuff = numHousePointsGryffindor * (0.7 + FRand() * 0.2);
	}
	if ( numHousePointsRavenclaw < ftemp )
	{
		numHousePointsRavenclaw = ftemp;
	}
	Log("###### House Points");
	Log("added" @ string(numLastHousePointsHarry));
	Log("Harry total" @ string(numHousePointsHarry));
	Log("Gryffindor" @ string(numHousePointsGryffindor));
	Log("Slytherin" @ string(numHousePointsSlytherin));
	Log("Hufflepuff" @ string(numHousePointsHufflepuff));
	Log("Ravenclaw" @ string(numHousePointsRavenclaw));
}

state stateCutIdle
{
  function BeginState ()
  {
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
    CurrIdleAnimName = GetCurrIdleAnimName();
    LoopAnim(CurrIdleAnimName,1.0,0.2);
  }
}

/*
function bool CutQuestion (string question)
{
  local ChallengeScoreManager managerChallenge;
  local bool bAnswer;

  CutErrorString = "";
  if ( Director != None )
  {
    bAnswer = Director.CutQuestion(question);
    if (  !(CutErrorString ~= "Unanswered" ) )
    {
      return bAnswer;
    }
    CutErrorString = "";
  }
  question = Caps(question);
  if ( InStr(question,"GSTATE") > -1 )
  {
    cm("CutQuestion about game state:" $ question $ " CurrentGameState is:" $ CurrentGameState);
    if ( CurrentGameState ~= question )
    {
      return True;
    } else {
      return False;
    }
  }
  if ( question ~= "EnoughBeans" )
  {
    return True;
  } else {
    if ( (question ~= "IsGryffindorAhead") || (question ~= "IsSlytherinAhead") || (question ~= "IsHufflepuffAhead") || (question ~= "IsRavenclawAhead") )
    {
      return managerStatus.GetStatusGroup(Class'StatusGroupHousePoints').CutQuestion(question);
    } else {
      if ( (question ~= "ChallengeIsFirstTime") || (question ~= "ChallengePreviouslyBeaten") || (question ~= "ChallengePreviouslyMastered") || (question ~= "ChallengeWorseThanBefore") || (question ~= "ChallengeJustWonFirstTime") || (question ~= "ChallengeJustMastered") || (question ~= "ChallengeMissedStars") || (question ~= "ChallengeNewBestScore") )
      {
        foreach AllActors(Class'ChallengeScoreManager',managerChallenge)
        {
          goto JL02D1;
        }
        if ( managerChallenge != None )
        {
          return managerChallenge.CutQuestion(question);
        } else {
          return Super.CutQuestion(question);
        }
      } else {
        if ( question ~= "ReadyForTransitionE" )
        {
          return (bHub9CeremonyFlag == True) && (managerStatus.GetStatusItem(Class'StatusGroupPolyIngr',Class'StatusItemBoomslang').nCount > 0) && (managerStatus.GetStatusItem(Class'StatusGroupPolyIngr',Class'StatusItemBicorn').nCount > 0);
        } else {
          if ( question ~= "HaveAllSilverCards" )
          {
            return managerStatus.GetStatusItem(Class'StatusGroupWizardCards',Class'StatusItemSilverCards').nCount >= 40;
          } else {
            return Super.CutQuestion(question);
          }
        }
      }
    }
  }
}
*/

function bool CutQuestion(string question)
{
	local ChallengeScoreManager managerChallenge;
	local bool		bAnswer;

	CutErrorString="";	//clear error string.

	// If there is a mini-game director, give it first chance at answering the
	// question; if it reports that it didn't answer it, then let Harry give it
	// a try.
	if ( Director != None )
	{
		bAnswer = Director.CutQuestion( question );
		if ( !(CutErrorString ~= "Unanswered") )
			return bAnswer;
	
		CutErrorString="";	// clear error string and let Harry try
	}

		//see if it is a question about the game state.
	question=caps(question);
	if(instr(question,"GSTATE")>-1)
	{
		cm("CutQuestion about game state:"$question $" CurrentGameState is:" $currentGameState);
		if(CurrentGameState~=question)
			return(true);
		else
			return(false);
	}


//sample question
	if(question~="EnoughBeans")
	{
//		if(beans greater than whatever)
			return true;
//		else
//			return false;
	}
	else if (question ~= "IsGryffindorAhead" ||
		     question ~= "IsSlytherinAhead"  ||
			 question ~= "IsHufflepuffAhead" ||
			 question ~= "IsRavenclawAhead")
	{
		return (managerStatus.GetStatusGroup(class'StatusGroupHousePoints').CutQuestion(question));
	}

	else if (question ~= "ChallengeIsFirstTime" ||
			 question ~= "ChallengePreviouslyBeaten" ||
			 question ~= "ChallengePreviouslyMastered" ||
			 question ~= "ChallengeWorseThanBefore"    ||
			 question ~= "ChallengeJustWonFirstTime"   ||
			 question ~= "ChallengeJustMastered"       ||
			 question ~= "ChallengeMissedStars"       ||
			 question ~= "ChallengeNewBestScore")
	{
		// Get level's challenge score manager.  A level should either have
		// 0 or 1 ChallengeScoreManagers.
		foreach AllActors(class'ChallengeScoreManager', managerChallenge )
			break;

		if (managerChallenge != None)
			return (managerChallenge.CutQuestion(question));		
		else
			return Super.CutQuestion(question);
	}
    else if (question ~= "ReadyForTransitionE")
    {        
        return (bHub9CeremonyFlag == true &&
                (managerStatus.GetStatusItem(class'StatusGroupPolyIngr',class'StatusItemBoomslang').nCount > 0) &&
                (managerStatus.GetStatusItem(class'StatusGroupPolyIngr',class'StatusItemBicorn').nCount > 0));
    }
    else if (question ~= "HaveAllSilverCards")
    {
        return (managerStatus.GetStatusItem(class'StatusGroupWizardCards',class'StatusItemSilverCards').nCount >= 40);
    }
	else
		return Super.CutQuestion(question);
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string sCutName;
  local Actor A;
  local string sSayText;
  local string sSayTextID;
  local Characters CurrCharacter;
  
  ClientMessage(self$" CutCommand:" $command $" Cue:" $cue);

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
	if ( HarryIsDead() )
	{
	  return False;
	}
	foreach AllActors(Class'Characters',CurrCharacter)
	{
	  CurrCharacter.OnHarryCaptured();
	}
	bIsCaptured = True;
	myHUD.StartCutScene();
	SendPlayerCaptureMessages(True);
	GotoState('stateCutIdle');
	return True;
  } 
  else if ( sActualCommand ~= "Release" )
  {
	myHUD.EndCutScene();
	DestroyControllers();
	SendPlayerCaptureMessages(False);
	bIsCaptured = False;
	GotoState('PlayerWalking');
	RotationRate = Default.RotationRate;
		
	CM("M212:	Harry release!");
		
	return True;
  } 
  else if ( sActualCommand ~= "ToggleUseSword" )
  {
	ToggleUseSword();
    CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "ChangeGameState" )
  {
	sActualCommand = ParseDelimitedString(Command," ",2,False);
	if (  !SetGameState(sActualCommand) )
	{
		CutErrorString = "!E!R!R!O!R! GameState " $ sActualCommand $ " is not a valid GameState in the *GameStateMasterList*!!!";
		CutCue(cue);
		return False;
	}
	CutCue(cue);
	return True;
  } 
  else if ( sActualCommand ~= "HideWeapon" )
  {
	Weapon.bHidden = True;
    CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "ShowWeapon" )
  {
	Weapon.bHidden = False;
    CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "SetHub9CeremonyFlag" )
  {
	bHub9CeremonyFlag = True;
	CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "GiveHermioneBicorn" )
  {
	managerStatus.AddBicorn(-1);
    CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "GiveHermioneBoomslang" )
  {
	managerStatus.AddBoomslang(-1);
    CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "RunCredits" )
  {
	menuBook = HPConsole(Player.Console).menuBook;
    if ( menuBook != None )
    {
		menuBook.RunTheCredits();
        CutCue(cue);
        return True;
    }
  } 
  else if ( sActualCommand ~= "ResetLevel" )
  {
	return CutCommand_ResetLevel(Command,cue);
  } 
  else if ( sActualCommand ~= "PutGryffInLead" )
  {
	StatusGroupHousePoints(managerStatus.GetStatusGroup(Class'StatusGroupHousePoints')).PutGryffInLead();
    CutCue(cue);
    return True;
  } 
  else if ( sActualCommand ~= "AddHPointsG" )
  {
	sActualCommand = ParseDelimitedString(Command," ",2,False);
    managerStatus.AddHPointsG(int(sActualCommand));
    CutCue(cue);
    return True;
  }
  return Super.CutCommand(Command,cue,bFastFlag);
}

function bool SetGameState (string strNewGameState)
{
  local bool bRet;
  local int nNewGameState;

  bRet = Super.SetGameState(strNewGameState);
  if ( bRet )
  {
    nNewGameState = ConvertGameStateToNumber();
    if ( nNewGameState >= 180 )
    {
      StatusGroupWizardCards(managerStatus.GetStatusGroup(Class'StatusGroupWizardCards')).AssignAllSilverToVendors();
    }
  }
  return bRet;
}

function SendPlayerCaptureMessages (bool bCapture)
{
  if ( bCapture )
  {
    ++nPlayerCaptureCount;
    if ( nPlayerCaptureCount == 1 )
    {
      foreach AllActors(Class'HPawn',foreachActor)
      {
        foreachActor.PlayerCutCapture();
      }
    }
  } else {
    --nPlayerCaptureCount;
    if ( nPlayerCaptureCount <= 0 )
    {
      nPlayerCaptureCount = 0;
      foreach AllActors(Class'HPawn',foreachActor)
      {
        foreachActor.PlayerCutRelease();
      }
    }
  }
}

function bool CutCommand_ResetLevel (string Command, optional string cue)
{
  local Characters A;

  foreach AllActors(Class'Characters',A)
  {
    if ( A.SavedFirstNavP != None )
    {
      A.RestartPatrol();
    }
  }
  CutCue(cue);
  return True;
}

function ToggleUseSword ()
{
  bHarryUsingSword =  !bHarryUsingSword;
  if ( bHarryUsingSword )
		HarryAnimSet = HARRY_ANIM_SET_SWORD;
	else
		HarryAnimSet = HARRY_ANIM_SET_MAIN;
		
  baseWand(Weapon).ToggleUseSword();
}

function bool MoveWhileCasting ()
{
  if ( bAltFire == 0 )
  {
    return True;
  } else {
    return bMoveWhileCasting;
  }
}

event PlayerInput (float DeltaTime)
{
  if ( bE3DemoLockout )
  {
    if ( myHUD.MainMenu != None )
    {
      myHUD.MainMenu.MenuTick(DeltaTime);
    }
    bEdgeForward = False;
    bEdgeBack = False;
    bEdgeLeft = False;
    bEdgeRight = False;
    bWasForward = False;
    bWasBack = False;
    bWasLeft = False;
    bWasRight = False;
    aStrafe = 0.0;
    aTurn = 0.0;
    aForward = 0.0;
    aLookUp = 0.0;
    return;
  }
  
  if ( bInDuelingMode )
  {
	bStrafe = 1;
  }
  Super.PlayerInput(DeltaTime);
  if ( HPHud(myHUD).bCutSceneMode )
  {
	if (bSkipCutScene == 1)
	{
		HPConsole(Player.Console).StartFastForward();
	}
  } 
  else if ( bInDuelingMode )
  {
	if ( !(baseWand(Weapon).ChargingLevel() > 0 ) )
	{
		HandleDuelPlayerInput();
	}
  } 
  else if ( bAltFire > 0 )
  {
	if ( GetCurrentKeyState(IK_LeftMouse) || GetCurrentKeyState(IK_RightMouse) || GetCurrentKeyState(IK_MiddleMouse) )
	{
		bMoveWhileCasting = True;
		//log("Move while casting!");
	} 
	else 
	{
		bMoveWhileCasting = False;
		//log("No move while casting!");
	}
  }
		
  //this is not really needed, state PlayerWalking and HarryAnimChannel deal with it -AdamJD
  /*
  else if( bIsAiming )
  {
	// Metallicafan212:	Turn off casting
	//					IDK how they did it in the normal game, but this is the only way I know to do it
	// StopAiming();
	// HarryAnimChannel.Cast();
	BaseWand(Weapon).Finish(); 
  }
  */
  
  if ( bOpenMap == 1 &&  !bMapQuickLook )
  {
	bMapQuickLook = True;
  } 
  else if ( bOpenMap == 0 && bMapQuickLook )
  {
    cm("FEBook ToggleMap");
    HPConsole(Player.Console).menuBook.ToggleMap();
    bMapQuickLook = False;
  }
  if ( bDrinkWiggenwell == 1 && IsInState('PlayerWalking') && Physics == PHYS_Walking &&  !IsA('BroomHarry') || (bDrinkWiggenwell == 1 && IsInState('PlayerWalking') && IsA('BroomHarry') ) )
  {
	DoDrinkWiggenwell();
  }
  if ( CurrVendorManager != None )
  {
	CurrVendorManager.PlayerInput(DeltaTime);
  }
}

function DoDrinkWiggenwell ()
{
  local StatusItem siWiggenPotion;
  local StatusGroup sgPotions;

  if ( HPHud(myHUD).bCutSceneMode )
  {
    return;
  }
  if ( managerStatus.GetHealthCount() == managerStatus.GetHealthPotentialCount() )
  {
    return;
  }
  if ( HarryAnimChannel.IsInState('stateDrinkWiggenwell') )
  {
    return;
  }
  siWiggenPotion = managerStatus.GetStatusItem(Class'StatusGroupPotions',Class'StatusItemWiggenwell');
  if ( siWiggenPotion.nCount >= 1 )
  {
    StopAiming();
    DropCarryingActor(False);
    HarryAnimChannel.DoDrinkWiggenwell();
  }
}

function CopyAllStatusFromManagerToHarry ()
{
  CopyGenericStatusFromManagerToHarry();
  CopyCardStatusFromManagerToHarry();
}

/*
function CopyGenericStatusFromManagerToHarry ()
{
  local StatusGroup sgLoop;
  local StatusItem siLoop;
  local int nStatusIdx;

  nStatusIdx = 0;
JL001B:
  sgLoop = managerStatus.sgList;
  if ( sgLoop != None )
  {
    siLoop = sgLoop.siList;
    if ( siLoop != None )
    {
      if ( nStatusIdx >= 30 )
      {
        ClientMessage("ERROR:  Need to increase StatusSaveSize");
        goto JL013F;
      } else {
        StatusSave[nStatusIdx].classGroup = sgLoop.Class;
        StatusSave[nStatusIdx].classItem = siLoop.Class;
        StatusSave[nStatusIdx].nPotential = siLoop.nCurrCountPotential;
        StatusSave[nStatusIdx].nCount = siLoop.nCount;
        StatusSave[nStatusIdx].nMaxCount = siLoop.nMaxCount;
        nStatusIdx++;
      }
      siLoop = siLoop.siNext;
      goto JL003A;
    }
    sgLoop = sgLoop.sgNext;
    goto JL001B;
  }
  nStatusIdx = nStatusIdx;
  if ( nStatusIdx < 30 )
  {
    StatusSave[nStatusIdx].classGroup = None;
    StatusSave[nStatusIdx].classItem = None;
    StatusSave[nStatusIdx].nPotential = 0;
    StatusSave[nStatusIdx].nCount = 0;
    StatusSave[nStatusIdx].nMaxCount = 0;
    nStatusIdx++;
    goto JL0161;
  }
}
*/

// Save off StatusManager data into an array that travels/goes with save games.
function CopyGenericStatusFromManagerToHarry()
{
	local StatusGroup            sgLoop;
	local StatusItem             siLoop;
	local int                    nStatusIdx;

	// Setup StatusSave array with status item information to carry
	// onto next level or into restored game
	nStatusIdx = 0;
	for (sgLoop=managerStatus.sgList; sgLoop!=None; sgLoop=sgLoop.sgNext)
	{
		for (siLoop=sgLoop.siList; siLoop!=None; siLoop=siLoop.siNext)
		{
			// If list isn't big enough to hold everything, throw out a message.
			if (nStatusIdx >= ArrayCount(StatusSave))
			{
				ClientMessage("ERROR:  Need to increase StatusSaveSize");
				break;
			}

			// Save off necessary status information into our array that will travel/save.
			else
			{
				StatusSave[nStatusIdx].classGroup   = sgLoop.class;
				StatusSave[nStatusIdx].classItem    = siLoop.class;
				StatusSave[nStatusIdx].nPotential   = siLoop.nCurrCountPotential;
				StatusSave[nStatusIdx].nCount       = siLoop.nCount;
                StatusSave[nStatusIdx].nMaxCount    = siLoop.nMaxCount;

				nStatusIdx++;
			}
		}
	}

	// Clear out unused portion of StatusSave array.
	for (nStatusIdx=nStatusIdx; nStatusIdx < ArrayCount(StatusSave); nStatusIdx++)
	{
		StatusSave[nStatusIdx].classGroup = None;
		StatusSave[nStatusIdx].classItem  = None;
		StatusSave[nStatusIdx].nPotential = 0;
		StatusSave[nStatusIdx].nCount     = 0;
        StatusSave[nStatusIdx].nMaxCount  = 0;
	}

}

/*
function CopyCardStatusFromManagerToHarry ()
{
  local StatusGroupWizardCards sgCards;
  local StatusItemWizardCards siCards;
  local int I;
  local int nId;
  local int nOwner;

  sgCards = StatusGroupWizardCards(managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
  sgCards.AssignVendorCards();
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
  I = 0;
  if ( I < 50 )
  {
JL0054:
    siCards.GetCardData(I,nId,nOwner);
    BronzeCardSave[I].nCardId = nId;
    BronzeCardSave[I].nCardOwner = nOwner;
    I++;
    goto JL0054;
  }
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
  I = 0;
  if ( I < 40 )
  {
    siCards.GetCardData(I,nId,nOwner);
    SilverCardSave[I].nCardId = nId;
    SilverCardSave[I].nCardOwner = nOwner;
    I++;
    goto JL00DA;
  }
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemGoldCards'));
  I = 0;
  if ( I < 11 )
  {
    siCards.GetCardData(I,nId,nOwner);
    GoldCardSave[I].nCardId = nId;
    GoldCardSave[I].nCardOwner = nOwner;
    I++;
    goto JL0160;
  }
  nLastCardTypeSave = sgCards.GetLastObtainedCardTypeAsInt();
}
*/

// Save off wizard card data in arrays that travel/save to save game.
function CopyCardStatusFromManagerToHarry()
{
	local StatusGroupWizardCards sgCards;
	local StatusItemWizardCards  siCards;
	local int                    i;
	local int                    nId;
	local int                    nOwner;

	// If there are any wizard cards left in the current level that can be sold by vendors,
	// flag them as being owned by vndors.
	sgCards = StatusGroupWizardCards(managerStatus.GetStatusGroup(class'StatusGroupWizardCards'));
	sgCards.AssignVendorCards();
	//sgCards.ShowCardData();   // for debugging

	// Save bronze card data in array that travels/goes to save game.
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(class'StatusItemBronzeCards'));
	for (i=0; i<ArrayCount(BronzeCardSave); i++)
	{
		siCards.GetCardData(i, nId, nOwner);
		BronzeCardSave[i].nCardId    = nId;
		BronzeCardSave[i].nCardOwner = nOwner;
	}

	// Save silver card data in array that travels/goes to save game.
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(class'StatusItemSilverCards'));
	for (i=0; i<ArrayCount(SilverCardSave); i++)
	{
		siCards.GetCardData(i, nId, nOwner);
		SilverCardSave[i].nCardId    = nId;
		SilverCardSave[i].nCardOwner = nOwner;
	}

	// Save gold card data in array that travels/goes to save gaem.
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(class'StatusItemGoldCards'));
	for (i=0; i<ArrayCount(GoldCardSave); i++)
	{
		siCards.GetCardData(i, nId, nOwner);
		GoldCardSave[i].nCardId    = nId;
		GoldCardSave[i].nCardOwner = nOwner;
	}

	// Save off last card type picked up
	nLastCardTypeSave = sgCards.GetLastObtainedCardTypeAsInt();
}


/*
function ClearNonTravelStatus ()
{
  local StatusGroup sgLoop;
  local StatusItem siLoop;
  local int nStatusIdx;

  nStatusIdx = 0;
JL001B:
  sgLoop = managerStatus.sgList;
  if ( sgLoop != None )
  {
    siLoop = sgLoop.siList;
    if ( siLoop != None )
    {
      if (  !siLoop.bTravelStatus )
      {
        siLoop.nCount = 0;
        siLoop.nMaxCount = 0;
        siLoop.nCurrCountPotential = 0;
      }
      siLoop = siLoop.siNext;
      goto JL003A;
    }
    sgLoop = sgLoop.sgNext;
    goto JL001B;
  }
}
*/

function ClearNonTravelStatus()
{
	local StatusGroup            sgLoop;
	local StatusItem             siLoop;
	local int                    nStatusIdx;

	// Setup StatusSave array with status item information to carry
	// onto next level or into restored game
	nStatusIdx = 0;
	for (sgLoop=managerStatus.sgList; sgLoop!=None; sgLoop=sgLoop.sgNext)
	{
		for (siLoop=sgLoop.siList; siLoop!=None; siLoop=siLoop.siNext)
		{
            if (!siLoop.bTravelStatus)
            {
                siLoop.nCount = 0;
                siLoop.nMaxCount = 0;
                siLoop.nCurrCountPotential = 0;
            }
        }
    }
}

function HandleSpellIncantationSound (ESpellType SpellType)
{
  if ( bInDuelingMode )
  {
    if ( Duellist(DuelOpponent).TimeLeftUntilSafeToSayAComment(True) > 0 )
    {
      return;
    }
  }
  PlayIncantationEmoteSound(SpellType);
  PlaySpellCastSound(SpellType);
}

function CheckIfHarryLostDuel ()
{
  if ( (managerStatus.GetHealthCount() <= 0) &&  !bDuelIsOver )
  {
    bDuelIsOver = True;
    UpdateDuelingRanks(False);
    Duellist(DuelOpponent).SayComment(DC_DuelLose,Duellist(DuelOpponent).eHouse,True);
    Duellist(DuelOpponent).SentEvent(Duellist(DuelOpponent).LostEventName);
   } else {
    // Duellist(DuelOpponent).SayComment(DC_DuelWin,Duellist(DuelOpponent).eHouse,True);
	Duellist(DuelOpponent).SayComment( DC_DuelOpp, Duellist(DuelOpponent).eHouse, true ); //the old code by UTPT made Snape say Harry had won when Harry got hit... -AdamJD
 }
}

function bool HandleSpellDuelRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  local float fTimeAfterHitNew;
  local string SpellIncantation;
  local int iDamage;

  if ( bDuelIsOver )
  {
    return False;
  }
  if ( bReboundingSpells )
  {
    switch (Rand(3))
    {
      case 0:
      SpellIncantation = "PC_Hry_SpellCast_09a";
      break;
      case 1:
      SpellIncantation = "PC_Hry_SpellCast_09b";
      break;
      case 2:
      SpellIncantation = "PC_Hry_SpellCast_09c";
      break;
      default:
    }
    PlaySound(Sound(DynamicLoadObject("AllDialog." $ SpellIncantation,Class'Sound')),SLOT_Talk);
    PlaySound(Sound'Dueling_EXP_smack',SLOT_Misc);
    spell.Reflect(self,FMin(5.0,spell.SpellCharge + (5 - spell.SpellCharge) * 0.1),FMin(1000.0,spell.Speed + (1000 - spell.Speed) * 0.25));
    baseWand(Weapon).FlashChargeParticles(Class'Exep_Shield');
    fTimeAfterShield = 1.0;
    return False;
  }
  iDamage = Duellist(DuelOpponent).DeltaHealth(True,0,spell.SpellCharge);
  if ( Difficulty > 0 )
  {
    iDamage *= Difficulty + 1;
  }
  AddHealth( -iDamage);
  CheckIfHarryLostDuel();
  PlayHurtEmoteSound();
  HarryAnimChannel.DoReactRictusempra();
  fTimeAfterHitNew = 1.0 /*UTPT didn't add this bit.. -AdamJD*/ * (1 + Duellist(DuelOpponent).Intellect);
  if ( fTimeAfterHitNew > fTimeAfterHit )
  {
    fTimeAfterHit = fTimeAfterHitNew;
  }
  return True;
}

function bool HandleSpellDuelMimblewimble (optional baseSpell spell, optional Vector vHitLocation)
{
  local string SpellIncantation;
  local int iDamage;

  if ( bDuelIsOver )
  {
    return False;
  }
  if ( bReboundingSpells )
  {
    switch (Rand(3))
    {
      case 0:
      SpellIncantation = "PC_Hry_SpellCast_09a";
      break;
      case 1:
      SpellIncantation = "PC_Hry_SpellCast_09b";
      break;
      case 2:
      SpellIncantation = "PC_Hry_SpellCast_09c";
      break;
      default:
    }
    PlaySound(Sound(DynamicLoadObject("AllDialog." $ SpellIncantation,Class'Sound')),SLOT_Talk);
    PlaySound(Sound'Dueling_EXP_smack',SLOT_Misc);
    spell.Reflect(self,FMin(5.0,spell.SpellCharge + (5 - spell.SpellCharge) * 0.1),FMin(1000.0,spell.Speed + (1000 - spell.Speed) * 0.25));
    baseWand(Weapon).FlashChargeParticles(Class'Exep_Shield');
    fTimeAfterShield = 1.0;
    return False;
  }
  PlaySound(Sound'Dueling_MIM_hit');
  if ( Rand(2) == 0 )
  {
    iDamage = Duellist(DuelOpponent).DeltaHealth(True,1,spell.SpellCharge);
    if(Difficulty > 1)
    {
      iDamage *= Difficulty + 1;
    }
    AddHealth( -iDamage);
    PlaySound(Sound'Dueling_MIM_self_damage',SLOT_Misc);
  } else {
    PlaySound(Sound'Dueling_MIM_self_lucky',SLOT_Misc);
  }
  CheckIfHarryLostDuel();
  HarryAnimChannel.DoReactMimbleWimble();
  fTimeAfterHit = 2.0 + 2 * Duellist(DuelOpponent).Intellect;
  return True;
}

function bool HandleSpellDuelExpelliarmus (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function SetObjectiveTextId (string strId)
{
  strObjectiveId = strId;
}

function bool HaveObjectiveText ()
{
  return strObjectiveId != "";
}

function int ConvertGameStateToNumber ()
{
  local string Num;

  Num = Right(CurrentGameState,3);
  ClientMessage("*********Converting gameState: " $ CurrentGameState $ " - " $ Num);
  return int(Num);
}

function UpdateDuelingRanks (bool bWon)
{
  if ( bWon )
  {
    if ( DuelRankHarry == DuelRankOppon )
    {
      DuelRankHarry++;
      curWizardDuelRank--;
      if ( curWizardDuelRank < 0 )
      {
        curWizardDuelRank = 0;
      }
    }
  }
}

function UpdateChallengeScores (string strLevelURL, int nHighScore, int nMaxScore)
{
  local int nIdx;

  strLevelURL = Caps(strLevelURL);
  if ( InStr(strLevelURL,"CH1RICTUSEMPRA") != -1 )
  {
    nIdx = 0;
  } else //{
    if ( InStr(strLevelURL,"CH2SKURGE") != -1 )
    {
      nIdx = 1;
    } else //{
      if ( InStr(strLevelURL,"CH3DIFFINDO") != -1 )
      {
        nIdx = 2;
      } else //{
        if ( InStr(strLevelURL,"CH4SPONGIFY") != -1 )
        {
          nIdx = 3;
        } else {
          ClientMessage("ERROR: Invalid Challenge Level URL passed in" $ strLevelURL);
          return;
        }
      // }
    // }
  // }
  if ( (nIdx < 0) || (nIdx >= 4) )
  {
    ClientMessage("ERROR: Unrecognized challenge level");
  } else //{
    if ( nHighScore > ChallengeScores[nIdx].nHighScore )
    {
      ChallengeScores[nIdx].nHighScore = nHighScore;
    }
    ChallengeScores[nIdx].nMaxScore = nMaxScore;
  //}
}

function GetRictusempraChallengeScore (out int nHighScore, out int nMaxScore)
{
  nHighScore = ChallengeScores[0].nHighScore;
  nMaxScore = ChallengeScores[0].nMaxScore;
}

function GetSkurgeChallengeScore (out int nHighScore, out int nMaxScore)
{
  nHighScore = ChallengeScores[1].nHighScore;
  nMaxScore = ChallengeScores[1].nMaxScore;
}

function GetDiffindoChallengeScore (out int nHighScore, out int nMaxScore)
{
  nHighScore = ChallengeScores[2].nHighScore;
  nMaxScore = ChallengeScores[2].nMaxScore;
}

function GetSpongifyChallengeScore (out int nHighScore, out int nMaxScore)
{
  nHighScore = ChallengeScores[3].nHighScore;
  nMaxScore = ChallengeScores[3].nMaxScore;
}

event ViewFlash (float DeltaTime)
{
  if ( bForceBlackScreen )
  {
    FlashFog.W = 0.0;
    FlashFog.X = 0.0;
    FlashFog.Y = 0.0;
    FlashFog.Z = 0.0;
    return;
  }
  Super.ViewFlash(DeltaTime);
}

defaultproperties
{
    bAutoCenterCamera=True

    bMoveWhileCasting=True

    bAutoQuaff=True

    ShadowClass=Class'HarryShadow'

    eaid="xa37dd45ffe10EU-0000029655-SD-00807cb3fa231144fe2e33ae4783feead2b8a73ff021fac326df0ef9753ab9cdf6573ddff0312fab0b0ff39779eaff312x"

    HurtSound(0)=Sound'HPSounds.Har_Emotes.ouch1'

    HurtSound(1)=Sound'HPSounds.Har_Emotes.ouch2'

    HurtSound(2)=Sound'HPSounds.Har_Emotes.ouch3'

    HurtSound(3)=Sound'HPSounds.Har_Emotes.ouch4'

    HurtSound(4)=Sound'HPSounds.Har_Emotes.ouch5'

    HurtSound(5)=Sound'HPSounds.Har_Emotes.ouch6'

    HurtSound(6)=Sound'HPSounds.Har_Emotes.ouch7'

    HurtSound(7)=Sound'HPSounds.Har_Emotes.ouch8'

    HurtSound(8)=Sound'HPSounds.Har_Emotes.ouch9'

    HurtSound(9)=Sound'HPSounds.Har_Emotes.ouch10'

    HurtSound(10)=Sound'HPSounds.Har_Emotes.ouch11'

    HurtSound(11)=Sound'HPSounds.Har_Emotes.ouch12'

    HurtSound(12)=Sound'HPSounds.Har_Emotes.ouch13'

    HurtSound(13)=Sound'HPSounds.Har_Emotes.oof1'

    HurtSound(14)=Sound'HPSounds.Har_Emotes.oof2'

    turnRate=1000.00

    maxPointsPerHouse=150

    HarryMultipleForGryffindor=3

    DuelSpells(0)=Class'spellDuelRictusempra'

    DuelSpells(1)=Class'spellDuelMimblewimble'

    DuelSpells(2)=Class'spellDuelExpelliarmus'

    DuelSpellSwitchSounds(0)=Sound'HPSounds.Magic_sfx.Dueling_switch2RIC'

    DuelSpellSwitchSounds(1)=Sound'HPSounds.Magic_sfx.Dueling_switch2MIM'

    DuelSpellSwitchSounds(2)=Sound'HPSounds.Magic_sfx.Dueling_switch2EXP'

    DuelRankHarry=1

    fDamageMultiplier_Easy=1.20

    fDamageMultiplier_Medium=2.00

    fDamageMultiplier_Hard=3.00

    fMinDamageScalar=1.00

    bTargettingError=True

    bCanCast=True

    SpongifyFallAnim=spongify

    AnimFalling=''

    HarryAnims(0)=(Idle=Idle,Walk=Walk,run=run,WalkBack=runback,StrafeRight=StrafeRight,StrafeLeft=StrafeLeft,Jump=Jump,Jump2=Jump2,Fall=Fall,Land=Land)

    HarryAnims(1)=(Idle=Idle,Walk=ectowalk,run=ectowalk,WalkBack=EctoWalkback,StrafeRight=ectostraferight,StrafeLeft=ectostrafeleft,Jump=ectojump,Jump2=Jump2,Fall=Fall,Land=Land)

    HarryAnims(2)=(Idle=idlesleepy,Walk=SleepyWalk,run=SleepyWalk,WalkBack=SleepyWalkBack,StrafeRight=sleepyStrafeRight,StrafeLeft=sleepyStrafeLeft,Jump=sleepyjump,Jump2=Jump2,Fall=Fall,Land=Land)

    HarryAnims(3)=(Idle=SwordIdle,Walk=Walk,run=SwordRun,WalkBack=SwordRunback,StrafeRight=SwordStrafeRight,StrafeLeft=SwordStrafeLeft,Jump=SwordJump,Jump2=SwordJump2,Fall=SwordFall,Land=SwordLand)

    HarryAnims(4)=(Idle=Idle,Walk=webmove,run=webmove,WalkBack=webmove,StrafeRight=webmove,StrafeLeft=webmove,Jump=ectojump,Jump2=ectojump,Fall=Fall,Land=Land)

    HarryAnims(5)=(Idle=duel_idle,Walk=duel_run,run=duel_run,WalkBack=duel_runback,StrafeRight=duel_strafe_right,StrafeLeft=duel_strafe_left,Jump=None,Jump2=None,Fall=None,Land=None)

    bAllowHarryToDie=True

    ConstrainYawVariance=5500

    GroundJumpSpeed=200.00

    GroundEctoSpeed=50.00

    iMaxSleepyAnim=6

    fSleepySpeed=50.00

    fWebSpeed=145.00

    FootOffsetZ=-34.00

    fHighestZ=-999999.00

    quidGameResults(0)=(Opponent="Hufflepuff",myScore=0,OpponentScore=0,HousePoints=0,bLocked=True,bWon=False)

    quidGameResults(1)=(Opponent="Ravenclaw",myScore=0,OpponentScore=0,HousePoints=0,bLocked=True,bWon=False)

    quidGameResults(2)=(Opponent="Slytherin",myScore=0,OpponentScore=0,HousePoints=0,bLocked=True,bWon=False)

    quidGameResults(3)=(Opponent="Hufflepuff",myScore=0,OpponentScore=0,HousePoints=0,bLocked=True,bWon=False)

    quidGameResults(4)=(Opponent="Ravenclaw",myScore=0,OpponentScore=0,HousePoints=0,bLocked=True,bWon=False)

    quidGameResults(5)=(Opponent="Slytherin",myScore=0,OpponentScore=0,HousePoints=0,bLocked=True,bWon=False)

    curWizardDuelRank=10

    lastUnlockedDuelist=8

    iMinHealthAfterDeath=41

    DesiredSpeed=1.00

    GroundSpeed=210.00

    AirSpeed=400.00

    AccelRate=1024.00

    JumpZ=245.00

    MaxMountHeight=96.50

    AirControl=0.25

    BaseEyeHeight=40.75

    EyeHeight=40.75

    MenuName="Harry"

    bDoEyeBlinks=True

    DrawType=DT_Mesh

    Mesh=SkeletalMesh'HPModels.skharryMesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=42.00

    Buoyancy=118.80

    RotationRate=(Pitch=20000,Yaw=70000,Roll=3072)
}
