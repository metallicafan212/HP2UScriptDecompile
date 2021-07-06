//================================================================================
// Aragog.
//================================================================================

class Aragog extends baseBoss;

const ATTACK_SPELL= 1;
const ATTACK_BITE= 0;
const CHECK_ROTATION= 5;
enum enumSpellAttackType {
  SPELL_DIRECT,
  SPELL_SPRAY,
  SPELL_LINE
};

struct anchors
{
  var AragogWebAnchor anchor;
  var float HitTime;
};

var Vector vDir;
var int Counter;
var int iterations;
var int cutSceneCounter;
var AragogHome aHome;
var Vector vHome;
var bool bMove;
var Vector vLocation;
var float distanceFromHarry;
var BaseCam Cam;
var Vector vBiteVector;
var bool bOnMyWeb;
var bool bOnStickyWeb;
var Rotator rRotationTowardHarry;
var int AttackType;
var bool bPhaseOneOver;
var float tempDamage;
var bool bCanBiteHarry;
var AragogCenterWeb centerWeb;
var Vector nipLocation;
var bool bBigBite;
var int countI;
var int countJ;
var Rotator vRot;
var float Pitch;
var float changeRotation;
var Rotator moveToRotation;
var float rotationDirection;
var Rotator rLastRotation;
var int numAnchorsAttached;
var AragogWebAnchor fixingAnchor;
var anchors webAnchors[8];
var int aBefore;
var int aAfter;
var float AttackTime;
var AragogSpellWeb webSpell;
var AragogStickyWeb stickyWeb[7];
var int maxWebs;
var Vector spellOrigin;
var AragogSpellAttack attackSpell;
var Vector spellLocation;
var Trigger SpiderTrigger[4];
var SpiderMarker Marker;
var Sound aragogVoice;
var string sSoundID;
var float randDialog;
var float minTimeBetweenHits;
var() int numAnchors;
var() int spiderAnchorRatio;
var() int largeSpiderIncrement;
var() int smallSpiderIncrement;
var() float randDialogInterval;
var() float BiteStartFrame;
var() float BiteEndFrame;
var float RearUpTime;
var() float RearUpTimeStart;
var() float RearUpTimeEnd;
var() int maxAttendentsInLevel;
var() float StompAnimRateStart;
var() float StompAnimRateEnd;
var() float SpitAnimRateStart;
var() float SpitAnimRateEnd;
var() float TimeBetweenSPELL_LINEShotsStart;
var() float TimeBetweenSPELL_LINEShotsEnd;
var() float WebLifetime;
var() float timeBetweenAttacks;
var() float damageVulnerable;
var() float damageNormal;
var() float WebDamageTimer;
var() int WebDamage;
var() float SpellDamage;
var() int SpellSpraySpreadAmount;
var() float BiteDamage;
var() float BigBiteDamage;
var() float webCollisionRadius;
var() int numberOfSpells;
var() int HealthAddSpellTwo;
var() int HealthAddSpellThree;
var enumSpellAttackType SpellType;
var float TempFloat;
var float TempTime;
var int TempInt;
var int TempCount;
var int TempCount2;
var Rotator TempRotator;
var Vector TempVector;

function PostBeginPlay()
{
  local AragogWebAnchor A;
  local int triggerCounter;

  PlayerHarry.bVeryAfraid = True;
  Super.PostBeginPlay();
  changeRotation = 5.0;
  numAnchorsAttached = numAnchors;
  randDialog = randDialogInterval;
  vHome = Location;
  bPhaseOneOver = False;
  // Counter = 0;
  for ( Counter = 0; Counter < maxWebs; Counter++ )
  {
    stickyWeb[Counter] = Spawn(Class'AragogStickyWeb',self,,Location + Vec(50.0 * Counter,0.0,0.0),rot(0,0,0));
    stickyWeb[Counter].fDamageTimer = WebDamageTimer;
    stickyWeb[Counter].iDamage = WebDamage;
    // Counter++;
    // goto JL0052;
  }
  foreach AllActors(Class'AragogHome',aHome)
  {
    // goto JL00FA;
	break;
  }
  vHome = Location;
  foreach AllActors(Class'AragogWebAnchor',A)
  {
    webAnchors[A.iLocation].anchor = A;
    webAnchors[A.iLocation].HitTime = -1.0;
  }
  RearUpTime = RearUpTimeStart;
}

function BeatBoss()
{
  Health = 0;
  HandleSpellRictusempra();
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  local bool bPlayFoiledSound;
  local int LastHealth;

  Super.HandleSpellRictusempra(spell,vHitLocation);
  LastHealth = Health;
  if ( AnimSequence == 'RearsUpLoop' )
  {
    tempDamage = damageVulnerable;
    bPlayFoiledSound = True;
  } else {
    tempDamage = 1.0;
  }
  Health -= tempDamage;
  if( Health > 0) //UTPT didn't add this line -AdamJD
  {
    if ( bPlayFoiledSound )
    {
      PlayFoiledSound();
    } else {
      PlayOuchSound();
    }
  }
  RearUpTime = RearUpTimeStart + (RearUpTimeEnd - RearUpTimeStart) * (1 - GetHealth());
  PlayerHarry.ClientMessage("******* Gog hit by spell.  AnimSequence:" $ string(AnimSequence) $ " tempDamage:" $ string(tempDamage) $ " Health:" $ string(Health));
  if ( Health <= 0 )
  {
    Health = 0;
    if ( LastHealth > 0 )
    {
      GotoState('stateBeatAragog');
    }
  } else {
    if ( Health <= HealthAddSpellThree )
    {
      numberOfSpells = 3;
    } else {
      if ( Health <= HealthAddSpellTwo )
      {
        numberOfSpells = 2;
      }
    }
    if ( tempDamage == damageVulnerable )
    {
      GotoState('stateHitByRictusempra');
    }
  }
  return True;
}

function PlayOuchSound()
{
  switch (Rand(6))
  {
    case 0:
    sSoundID = "PC_ARA_ArragogFight_02a";
    break;
    case 1:
    sSoundID = "PC_ARA_ArragogFight_02b";
    break;
    case 2:
    sSoundID = "PC_ARA_ArragogFight_02c";
    break;
    case 3:
    sSoundID = "PC_ARA_ArragogFight_03a";
    break;
    case 4:
    sSoundID = "PC_ARA_ArragogFight_03b";
    break;
    case 5:
    sSoundID = "PC_ARA_ArragogFight_03c";
    break;
    default:
  }
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  // PlaySound(aragogVoice,5,256.0,,1000000.0);
  PlaySound( aragogVoice, SLOT_Talk, 256,, [Radius]1000000); 
}

function PlayRandomSound()
{
  switch (Rand(6))
  {
    case 0:
    sSoundID = "PC_ARA_ArragogFight_04a";
    break;
    case 1:
    sSoundID = "PC_ARA_ArragogFight_04b";
    break;
    case 2:
    sSoundID = "PC_ARA_ArragogFight_04c";
    break;
    case 3:
    sSoundID = "PC_ARA_ArragogFight_05";
    break;
    case 4:
    sSoundID = "PC_ARA_ArragogFight_06";
    break;
    case 5:
    sSoundID = "PC_ARA_ArragogFight_07";
    break;
    default:
  }
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  PlaySound(aragogVoice,Slot_Talk,256.0,,1000000.0);
}

function PlayMinionSound()
{
  switch (Rand(4))
  {
    case 0:
    sSoundID = "PC_ARA_ArragogFight_10";
    break;
    case 1:
    sSoundID = "PC_ARA_ArragogFight_11";
    break;
    case 2:
    sSoundID = "PC_ARA_ArragogFight_12";
    break;
    case 3:
    sSoundID = "PC_ARA_ArragogFight_13";
    break;
    default:
  }
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  // PlaySound(aragogVoice,5,256.0,,1000000.0);
  PlaySound( aragogVoice, SLOT_Talk, 256,, [Radius]1000000); 
}

function PlayAttackingSound()
{
  switch (Rand(6))
  {
    case 0:
    sSoundID = "PC_ARA_ArragogFight_16a";
    break;
    case 1:
    sSoundID = "PC_ARA_ArragogFight_16b";
    break;
    case 2:
    sSoundID = "PC_ARA_ArragogFight_16c";
    break;
    case 3:
    sSoundID = "PC_ARA_ArragogFight_17a";
    break;
    case 4:
    sSoundID = "PC_ARA_ArragogFight_17b";
    break;
    case 5:
    sSoundID = "PC_ARA_ArragogFight_17c";
    break;
    default:
  }
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  // PlaySound(aragogVoice,5,256.0,,1000000.0);
  PlaySound( aragogVoice, SLOT_Talk, 256,, [Radius]1000000); 
}

function PlayFoiledSound()
{
  switch (Rand(3))
  {
    case 0:
    sSoundID = "PC_ARA_ArragogFight_15a";
    break;
    case 1:
    sSoundID = "PC_ARA_ArragogFight_15b";
    break;
    case 2:
    sSoundID = "PC_ARA_ArragogFight_15c";
    break;
    default:
  }
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  // PlaySound(aragogVoice,5,256.0,,1000000.0);
  PlaySound( aragogVoice, SLOT_Talk, 256,, [Radius]1000000); 
}

function PlayConfidentSound()
{
  switch (Rand(3))
  {
    case 0:
    sSoundID = "PC_ARA_ArragogFight_14a";
    break;
    case 1:
    sSoundID = "PC_ARA_ArragogFight_14b";
    break;
    case 2:
    sSoundID = "PC_ARA_ArragogFight_14c";
    break;
    default:
  }
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  // PlaySound(aragogVoice,5,256.0,,1000000.0);
  PlaySound( aragogVoice, SLOT_Talk, 256,, [Radius]1000000); 
}

function float SetRotationDirection (float Y)
{
  local float currentYaw;
  local float requestedYaw;
  local float newYaw;
  local float temp;
  local float Delta;
  local float Dir;

  currentYaw = Rotation.Yaw;
  currentYaw = currentYaw & 65535;
  requestedYaw = y; //UTPT didn't add this -AdamJD
  requestedYaw = requestedYaw & 65535;
  if ( currentYaw > requestedYaw ) //UTPT didn't add this -AdamJD
  {
    Dir = -1.0;
    newYaw = currentYaw - requestedYaw;
    if ( currentYaw - requestedYaw > 32768 )
    {
      Dir = 1.0;
      newYaw = ( (65536.0 - currentYaw) + requestedYaw );
    }
  } else {
    Dir = 1.0;
    newYaw = requestedYaw - currentYaw;
    if ( requestedYaw - currentYaw > 32768 )
    {
      Dir = -1.0;
      newYaw = ( (65536.0 - requestedYaw) + currentYaw );
    }
  }
  temp = newYaw / 50;
  if ( temp < 50 )
  {
    temp = newYaw / 25;
  }
  Dir = temp * Dir;
  return Dir;
}

function PlayerCutCapture()
{
  GotoState('CutIdle');
}

function PlayerCutRelease()
{
  if ( cutSceneCounter == 1 )
  {
    GotoState('PhaseOne');
  } else {
    if ( cutSceneCounter == 2 )
    {
      bPhaseOneOver = True;
      bOnMyWeb = False;
      AttackTime = timeBetweenAttacks;
      centerWeb = Spawn(Class'AragogCenterWeb',self,,Location + vect(0.00,0.00,-25.00),rot(0,0,0));
      centerWeb.SetLocation(Location + vect(0.00,0.00,-25.00));
      PlayerHarry.GroundRunSpeed = PlayerHarry.Default.GroundRunSpeed * 1.25;
      PlayerHarry.GroundSpeed = PlayerHarry.GroundRunSpeed;
      GotoState('stateHarryHunting');
    }
  }
}

function bool IsAttacking()
{
  local bool ret;

  ret = True;
  if ( IsInState('stateHarryHunting') || IsInState('stateGoHome') )
  {
    ret = False;
  }
  return ret;
}

function Touch (Actor Other)
{
  if ( Other.IsA('harry') && (Health > 0) )
  {
    GotoState('NipHarry');
  }
}

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( Health <= 0 )
  {
    return;
  }
  if ( (bPhaseOneOver == True) && (IsAttacking() == False) )
  {
    if ( bOnMyWeb == True )
    {
      bOnMyWeb = False;
      GotoState('stateTurnToBite');
    }
  }
  if ( IsInState('PhaseOne') )
  {
    randDialog -= DeltaTime;
    if ( randDialog <= 0 )
    {
      PlayMinionSound();
      randDialog = randDialogInterval;
      GotoState('PhaseOne');
    }
  }
  AttackTime -= DeltaTime;
  rRotationTowardHarry = rotator(PlayerHarry.Location - Location);
  if ( IsInState('stateHarryHunting') )
  {
    if ( AttackTime <= 0 )
    {
      AttackTime = timeBetweenAttacks;
      if ( AttackType == 0 )
      {
        AttackType = 1;
      } else {
        AttackType = 0;
      }
      switch (AttackType)
      {
        // case 0:
		case ATTACK_BITE:
          GotoState('statePhysicalAttack');
          break;
        // case 1:
		case ATTACK_SPELL:
          GotoState('stateSpellAttack');
          break;
        default:
          GotoState('statePhysicalAttack');
          break;
      }
    } else {
      if ( (Abs((rRotationTowardHarry.Yaw & 65535) - (Rotation.Yaw & 65535)) > 4096) || (Abs((rRotationTowardHarry.Yaw & 65535) - (Rotation.Yaw & 65535)) > 61439) )
      {
        if ( Rand(3) == 0 )
        {
          PlayRandomSound();
        }
        LoopAnim('rotate',1.0,0.2);
        rRotationTowardHarry.Pitch = 0;
        rRotationTowardHarry.Roll = Rotation.Roll;
        DesiredRotation = rRotationTowardHarry;
        rLastRotation = rRotationTowardHarry;
      }
    }
  }
  if ( rLastRotation != rot(0,0,0) )
  {
    if ( rLastRotation == Rotation )
    {
      LoopAnim('Idle',1.0,0.2);
      rLastRotation = rot(0,0,0);
    } else {
      rLastRotation = Rotation;
    }
  }
  if ( IsInState('stateMovetoAttack') )
  {
    if ( bMove == True )
    {
      MoveSmooth(vDir * GroundSpeed * DeltaTime);
      if ( VSize2D(Location - vHome) > 500 )
      {
        GotoState('stateGoHome');
      }
      if ( VSize2D(Location - PlayerHarry.Location) < 390 + PlayerHarry.CollisionRadius )
      {
        GotoState('stateBiteHarry');
      }
    }
  }
  if ( IsInState('stateBiteHarry') )
  {
    if ( (AnimSequence == 'Bite') && (AnimFrame >= BiteStartFrame) && (AnimFrame <= BiteEndFrame) && (bCanBiteHarry == True) )
    {
      vBiteVector = Location + (vector(Rotation) * 390);
      if ( VSize2D(vBiteVector - PlayerHarry.Location) < 40 )
      {
        bCanBiteHarry = False;
        if ( bBigBite == True )
        {
          bBigBite = False;
          PlayerHarry.TakeDamage(BigBiteDamage, Pawn(Owner),Location,Velocity * 1,'Aragog');
        } else {
          PlayerHarry.TakeDamage(BiteDamage, Pawn(Owner),Location,Velocity * 1,'Aragog');
        }
        PlayerHarry.ClientMessage("BITE HARRY");
      }
    }
  }
  if ( IsInState('stateGoHome') )
  {
    if ( bMove == True )
    {
      MoveSmooth(vDir * GroundSpeed * DeltaTime);
      if ( VSize2D(Location - vHome) < 20 )
      {
        bMove = False;
        LoopAnim('Idle',1.0,0.2);
        GotoState('stateHarryHunting');
      }
    }
  }
}

function float GetHealth()
{
  return float(Health) / 100;
}

function AnchorHitBySpell (int iLocation)
{
  local SpiderMarker sm;
  local AragogAttendentSpawner theSpawner;
  local int totalAttendentsInLevel;
  local SpiderAttendent at;

  PlayerHarry.ClientMessage("Location Hit : " $ string(iLocation));
  PlayOuchSound();
  numAnchorsAttached--;
  if ( numAnchorsAttached <= 0 )
  {
    GotoState('stateFalling');
  } else {
    if (numAnchorsAttached % spiderAnchorRatio == 0 )
    {
      TriggerEvent('WebAnchorHit',self,None);
      // Counter = 0;
      for ( Counter = 0; Counter < smallSpiderIncrement; Counter++ )
      {
        foreach AllActors(Class'SpiderMarker',sm)
        {
          sm.incrementNumSmallSpiders();
        }
        // Counter++;
        // goto JL0073;
      }
    } else {
      TriggerEvent('WebAnchorHit',self,None);
    }
  }
  foreach AllActors(Class'SpiderAttendent',at)
  {
    totalAttendentsInLevel++;
  }
  if ( totalAttendentsInLevel < maxAttendentsInLevel )
  {
    theSpawner = FindClosestSpawner(webAnchors[iLocation].anchor.Location);
    theSpawner.SpawnSpiders(numAnchors - numAnchorsAttached - 1);
  }
}

function AragogAttendentSpawner FindClosestSpawner (Vector Loc)
{
  //local int Counter;
  local float Dist;
  local float farthestDist;
  local AragogAttendentSpawner ss;
  local AragogAttendentSpawner retSpawner;
  local Vector AnchorLocation;

  AnchorLocation = Loc;
  farthestDist = 1215752192.0;
  foreach AllActors(Class'AragogAttendentSpawner',ss)
  {
    if ( VSize(ss.Location - AnchorLocation) < farthestDist )
    {
      retSpawner = ss;
      farthestDist = VSize(ss.Location - AnchorLocation);
    }
  }
  return retSpawner;
}

function destroyAllSpiders()
{
  local SpiderSmall smallSpider;
  local SpiderLarge largeSpider;
  local SpiderAttendent attendentSpider;

  foreach AllActors(Class'SpiderSmall',smallSpider)
  {
    smallSpider.Destroy();
  }
  foreach AllActors(Class'SpiderLarge',largeSpider)
  {
    largeSpider.Destroy();
  }
  foreach AllActors(Class'SpiderAttendent',attendentSpider)
  {
    attendentSpider.Destroy();
  }
}

function MoveAwayFromThePit()
{
  local AragogHarrySafeZone safeZone;
  local Vector TowardHarryDirection;
  local Vector NewLocation;

  foreach AllActors(Class'AragogHarrySafeZone',safeZone)
  {
    // goto JL0014;
	break;
  }
  TowardHarryDirection = Normal(PlayerHarry.Location - vHome);
  NewLocation = vHome + TowardHarryDirection * 650;
  NewLocation.Z = PlayerHarry.Location.Z;
  safeZone.SetLocation(NewLocation);
}

function createWeb (Vector Loc)
{
  local int webCounter;
  local bool isHidden;
  local int webIndex;

  // webCounter = 0;
  //yet again this is a for loop... -AdamJD
  for ( webCounter = 0; webCounter < maxWebs; webCounter++ )
  {
    if ( stickyWeb[webCounter].bHidden == True )
    {
      webIndex = webCounter;
    }
    // webCounter++;
    // goto JL0007;
  }
  stickyWeb[webIndex].SetLocation(Loc);
  stickyWeb[webIndex].BeginToGrow();
  stickyWeb[webIndex].fLifetime = WebLifetime;
}

auto state AragogBegin
{
begin:
}

state CutIdle
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    if ( cutSceneCounter == 1 )
    {
      // goto JL0035;
	  return;
    }
    else if ( cutSceneCounter == 2 )
    {
      MoveAwayFromThePit();
      destroyAllSpiders();
    } else {
      if ( cutSceneCounter == 2 ) 
	  // goto JL0035;
	  return;
    }
  }
  
 begin:
  Velocity = Vec(0.0,0.0,0.0);
  Acceleration = Vec(0.0,0.0,0.0);
  if ( cutSceneCounter == 0 )
  {
    cutSceneCounter = 1;
  } else //{
    if ( cutSceneCounter == 1 )
    {
      vHome = aHome.Location;
      cutSceneCounter = 2;
    } else //{
      if ( cutSceneCounter == 2 )
      {
        cutSceneCounter = 3;
      }
    // }
  // }
}

state PhaseOne
{
begin:
  Pitch = 0.0;
  LoopAnim('rotate',1.0,0.2);
  vDir = Normal(PlayerHarry.Location - Location);
  vRot = rotator(PlayerHarry.Location - Location);
  vRot.Pitch = Pitch;
  DesiredRotation = vRot;
  sSoundID = "PC_ARA_ArragogFight_13";
  Localize("all",sSoundID,"HPdialog");
  aragogVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
  PlaySound(aragogVoice,SLOT_Talk,256.0,,1000000.0);
  Sleep(1.0);
  LoopAnim('Idle',1.0,0.2);
}

state stateFalling
{
begin:
  PlayerHarry.ClientMessage("Aragog is Falling");
  foreach AllActors(Class'SpiderMarker',Marker)
  {
    Marker.disableMarker();
  }
  Sleep(0.1);
  TriggerEvent('AragogIsFalling',self,None);
}

state stateHarryHunting
{
begin:
  LoopAnim('Idle',1.0,0.2);
}

state statePhysicalAttack
{
begin:
  distanceFromHarry = 450.0;
  LoopAnim('rotate',1.5,0.2);
  TurnToward(PlayerHarry);
  Acceleration = Vec(0.0,0.0,0.0);
  Velocity = Vec(0.0,0.0,0.0);
  PlayAnim('UpToRun',1.0,0.2);
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  Sleep(10.0 / 30.0);
  PlaySound(Sound'whomp01',Slot_None,RandRange(0.81,1.0),,1000000.0,RandRange(0.81,1.25));
  Sleep(5.0 / 30.0);
  DoStomp(True);
  FinishAnim();
  GotoState('stateMovetoAttack');
}

state stateMovetoAttack
{
  function BeginState()
  {
    bMove = False;
  }
  
 begin:
  if ( Rand(3) == 0 )
  {
    PlayAttackingSound();
  }
  LoopAnim('rotate',1.5,0.2);
  TurnToward(PlayerHarry);
  vLocation = PlayerHarry.Location + Normal(Location - PlayerHarry.Location) * distanceFromHarry;
  vDir = Normal((PlayerHarry.Location + Normal(Location - PlayerHarry.Location) * distanceFromHarry - Location) * Vec(1.0,1.0,0.0));
  LoopAnim('run',1.0,0.2);
  bMove = True;
}

state stateBiteHarry
{
begin:
  BiteStartFrame = 15.0 / 36.0;
  BiteEndFrame = 24.0 / 36.0;
  Acceleration = Vec(0.0,0.0,0.0);
  Velocity = Vec(0.0,0.0,0.0);
  bCanBiteHarry = True;
  PlayAnim('Bite',1.0,0.2);
  PlaySound(Sound'Arragog_attack01',Slot_None,,,1000000.0,1.0);
  Sleep(8.0 / 30.0);
  PlaySound(Sound'whomp01',Slot_None,RandRange(0.81,1.0),,1000000.0,RandRange(0.81,1.25));
  FinishAnim();
  if ( GetHealth() < 0.5 )
  {
    TempFloat = StompAnimRateStart + (StompAnimRateEnd - StompAnimRateStart) * (1 - GetHealth());
    PlayAnim('PreAttack1',TempFloat,0.2);
    PlaySound(Sound'Arragog_attack03',Slot_None,,,1000000.0,TempFloat);
    Sleep(15.0 / 30.0 / TempFloat);
    DoStomp(True);
    if ( VSize2D((Location + vector(Rotation - rot(0,9000,0)) * 350) - PlayerHarry.Location) < 200 )
    {
      PlayerHarry.TakeDamage(30,Pawn(Owner),Location,vect(0.00,0.00,0.00),'Aragog');
    }
    PlaySound(Sound'Arragog_attack03',Slot_None,,,1000000.0,TempFloat);
    Sleep(20.0 / 30.0 / TempFloat);
    DoStomp(True);
    if ( VSize2D((Location + vector(Rotation + rot(0,9000,0)) * 350) - PlayerHarry.Location) < 200 )
    {
      PlayerHarry.TakeDamage(30,Pawn(Owner),Location,vect(0.00,0.00,0.00),'Aragog');
    }
  }
  PlayAnim('RearsUp',1.0,0.2);
  PlaySound(Sound'Arragog_attack04',Slot_None,0.41,,1000000.0,0.5);
  FinishAnim();
  LoopAnim('RearsUpLoop',1.0,0.2);
  PlaySound(Sound'Arragog_attack04',Slot_None,1.0,,1000000.0,0.5);
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  Sleep(RearUpTime * 0.75);
  LoopAnim('Idle',1.0,2.0);
  Sleep(1.0);
  GotoState('stateGoHome');
}

state stateGoHome
{
  function BeginState()
  {
    bMove = False;
  }
  
 begin:
  vDir = Normal(vHome - Location);
  LoopAnim('runback',1.0,0.2);
  bMove = True;
}

state stateTurnToBite
{
begin:
  vDir = Normal((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00));
  vRot = rotator(vDir);
  DesiredRotation = vRot;
  GotoState('stateMovetoAttack');
}

state stateSpellAttack
{
begin:
  Acceleration = Vec(0.0,0.0,0.0);
  Velocity = Vec(0.0,0.0,0.0);
  LoopAnim('rotate',,1.5);
  TurnToward(PlayerHarry);
  TempFloat = StompAnimRateStart + (StompAnimRateEnd - StompAnimRateStart) * (1 - GetHealth());
  switch (Rand(3))
  {
    case 0:
		// SpellType = 0;
		spellType = SPELL_DIRECT;
		PlayAnim('PreAttack1',TempFloat,0.2);
		PlaySound(Sound'Arragog_attack03',Slot_None,,,1000000.0,TempFloat);
		Sleep(15.0 / 30.0 / TempFloat);
		DoStomp(True);
		PlaySound(Sound'Arragog_attack03',Slot_None,,,1000000.0,TempFloat);
		Sleep(20.0 / 30.0 / TempFloat);
		DoStomp(True);
		break;
    case 1:
		// SpellType = 1;
		spellType = SPELL_SPRAY;
		PlayAnim('PreAttack2',TempFloat,0.2);
		PlaySound(Sound'Arragog_attack04',Slot_None,,,1000000.0,1.5 * TempFloat);
		Sleep(31.0 / 30.0 / TempFloat);
		PlaySound(Sound'whomp01',Slot_None,RandRange(0.81,1.0),,1000000.0,RandRange(0.81,1.25) * TempFloat);
		Sleep(4.0 / 30.0 / TempFloat);
		DoStomp(True);
		PlaySound(Sound'Arragog_attack04',Slot_None,,,1000000.0,TempFloat);
		break;
    case 2:
		// SpellType = 2;
		spellType = SPELL_LINE;
		PlayAnim('PreAttack3',TempFloat,0.2);
		PlaySound(Sound'Arragog_attack06',Slot_None,,,1000000.0,0.75 * TempFloat);
		Sleep(21.0 / 30.0 / TempFloat);
		PlaySound(Sound'whomp01',Slot_None,RandRange(0.81,1.0),,1000000.0,RandRange(0.81,1.25) * TempFloat);
		Sleep(4.0 / 30.0 / TempFloat);
		DoStomp(True);
		Sleep(12.0 / 30.0 / TempFloat);
		DoStomp(True);
		break;
    default:
  }
  FinishAnim();
  GotoState('stateShootSpell');
}

function DoStomp (bool bBigStomp, optional bool bDeepStomp)
{
  if ( bDeepStomp )
  {
    PlayerHarry.ShakeView(1.75,200.0,200.0);
    PlaySound(Sound'big_block_fall',Slot_None,,,1000000.0,RandRange(0.31,0.5));
    PlaySound(Sound'Big_whomp4',Slot_None,,,1000000.0,RandRange(0.31,0.5));
  } else {
    if ( bBigStomp )
    {
      PlayerHarry.ShakeView(0.69999999,200.0,200.0);
      if ( FRand() < 0.5 )
      {
        PlaySound(Sound'Big_whomp4',Slot_None,,,1000000.0,RandRange(0.5,0.81));
      } else {
        PlaySound(Sound'big_block_fall',Slot_None,,,1000000.0,RandRange(0.5,0.81));
      }
    } else {
      PlayerHarry.ShakeView(0.41,100.0,100.0);
      PlaySound(Sound'lil_whomper_hit1',Slot_None,0.333,,1000000.0,RandRange(0.5,0.81));
    }
  }
}

state stateShootSpell
{
  function BeginState()
  {
    spellLocation = vect(0.00,0.00,0.00);
    TempCount = 0;
  }
  
 begin:
  TempFloat = SpitAnimRateStart + (SpitAnimRateEnd - SpitAnimRateStart) * (1 - GetHealth());
  PlayAnim('UpToSpit',TempFloat,0.2);
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  Sleep(11.0 / 30.0 / TempFloat);
  PlaySound(Sound'whomp01',Slot_None,RandRange(0.81,1.0),,1000000.0,RandRange(0.81,1.25) * TempFloat);
  Sleep(4.0 / 30.0 / TempFloat);
  DoStomp(True);
  Sleep(0.31 / TempFloat);
  switch (SpellType)
  {
    // case 0:
	case SPELL_DIRECT:
    // case 1:
	case SPELL_SPRAY:
		TempFloat = VSize(PlayerHarry.Location - Location);
		TempRotator = rotator(PlayerHarry.Location - Location);
		TempInt = TempRotator.Yaw;
		if ( SpellType == SPELL_SPRAY )
		{
		  TempInt += (Rand(2) * 2 - 1) * SpellSpraySpreadAmount / 2;
		}
		// Counter = 0;
		//a for loop -AdamJD
		for ( Counter = 0; Counter < 5; Counter++ )
		{
		  TempRotator.Yaw = TempInt + (Counter - 2) * SpellSpraySpreadAmount;
		  // spellLocation = Location + = TempRotator * TempFloat;
		  spellLocation = Location + vector(TempRotator) * TempFloat;
		  spellLocation -= vect(0.00,0.00,5.00);
		  // spellOrigin = Location + Rotation * 155;
		  spellOrigin = Location + (vector(Rotation) * 155);
		  spellOrigin = spellOrigin + Vec(0.0,0.0,160.0);
		  attackSpell = AragogSpellAttack(FancySpawn(Class'AragogSpellAttack',self,,spellOrigin,rotator(vDir)));
		  attackSpell.iDamage = SpellDamage;
		  attackSpell.hitTarget = spellLocation;
		  // Counter++;
		  // goto JL015C;
		}
    break;
    // case 2:
	case SPELL_LINE:
		// Counter = 0;
		//another for loop -AdamJD
		for ( Counter = 0; Counter < 4; Counter++ )
		{
		  if ( GetHealth() < 0.5 )
		  {
			TempCount2 = 2;
		  } else {
			TempCount2 = 1;
		  }
		  // TempCount2 = TempCount2;
		  //this looks wrong but it is right -AdamJD
		  for ( TempCount2 = TempCount2; TempCount2 > 0; TempCount2-- )
		  {
			DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
			if ( Counter < 4 - 1 )
			{
			  spellLocation = PlayerHarry.Location - vect(0.00,0.00,5.00) + VRand() * 10;
			  TempVector = spellLocation;
			} else {
			  TempRotator = rotator(PlayerHarry.Location - Location);
			  
			  /*
			  if ( (TempVector - Location) Cross (TempVector - PlayerHarry.Location).Z < byte(0) )
			  {
	JL0290:
				TempRotator.Yaw += byte(SpellSpraySpreadAmount) * 0.94999999 = );
				TempRotator.Yaw -= byte(SpellSpraySpreadAmount) * 0.94999999 = );
				// There are 1 jump destination(s) inside the last statement!
			  }
			  */
			  
			  if ( ((TempVector - Location) Cross (TempVector - PlayerHarry.Location)).Z < 0 )
			  {
				TempRotator.Yaw += SpellSpraySpreadAmount * 0.94999999;
			  }
			  
			  else
			  {
				TempRotator.Yaw -= SpellSpraySpreadAmount * 0.94999999;
			  }
			  
			  spellLocation = Location  +  vector( TempRotator ) * VSize(playerHarry.location - Location); //UTPT didn't add this -AdamJD
			  spellLocation -= vect(0.00,0.00,5.00);
			}
			// spellOrigin = Location + Rotation * 155;
			spellOrigin = Location + (vector(Rotation) * 155);
			spellOrigin = spellOrigin + Vec(0.0,0.0,160.0);
			attackSpell = Spawn(Class'AragogSpellAttack',self,,spellOrigin,rotator(vDir));
			attackSpell.iDamage = SpellDamage;
			attackSpell.hitTarget = spellLocation;
			if ( TempCount2 > 1 )
			{
			  Sleep(0.151);
			} else {
			  Sleep(TimeBetweenSPELL_LINEShotsStart + (TimeBetweenSPELL_LINEShotsEnd - TimeBetweenSPELL_LINEShotsStart) * (1 - GetHealth()));
			}
			// TempCount2--;
			// goto JL0290;
		  }
		  // Counter++;
		  // goto JL0257;
		}
		break;
    default:
  }
  Sleep(0.5);
  TempCount++;
  if ( (TempCount < 2) && (GetHealth() < 0.5) && ((SpellType == SPELL_DIRECT) || (SpellType == SPELL_SPRAY)) )
  {
    goto ('Begin');
  }
  PlayAnim('RearsUp',1.0,1.0);
  PlaySound(Sound'Arragog_attack04',Slot_None,0.41,,1000000.0,0.5);
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  FinishAnim();
  LoopAnim('RearsUpLoop',1.0,0.2);
  PlaySound(Sound'Arragog_attack04',Slot_None,1.0,,1000000.0,0.5);
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  Sleep(RearUpTime * 1.0);
  LoopAnim('Idle',1.0,1.0);
  GotoState('stateHarryHunting');
}

state stateHitByRictusempra
{
  function Timer()
  {
    PlaySound(Sound'Basilisk_attack3',SLOT_None,1.0,,1000000.0,0.69999999);
  }
  
 begin:
  TempFloat = 0.44999999;
  PlayAnim('KnockBack',TempFloat,0.2);
  //UTPT doesn't decompile the PlaySound  function correctly... -AdamJD
  // PlaySound(Sound'pig_squeal1',0,1.0,,1000000.0,0.81);
  PlaySound(Sound'pig_squeal1',Slot_None,1.0,,1000000.0,0.81);
  PlaySound(Sound'Basilisk_attack3',Slot_None,1.0,,1000000.0,0.89999998);
  PlaySound(Sound'BasilAttackWarning00',Slot_None,1.0,,1000000.0,0.81);
  SetTimer(0.5,False);
  Sleep(12.0 / 30.0 / TempFloat);
  PlaySound(Sound'Basilisk_attack3',Slot_None,1.0,,1000000.0,0.81);
// JL00AB:
  DoStomp(True);
  // Sleep(0.01);
  
  //do and until -AdamJD
  do 
  { 
	sleep(0.01); 
  }
  until(AnimFrame >= 17.0 / 46.0);
  
  // if (! AnimFrame >= 17.0 / 46.0 ) goto JL00AB;
  AnimRate = 0.75;
  PlaySound(Sound'Arragog_attack05',Slot_None,1.0,,1000000.0,RandRange(0.81,1.25));
  // Sleep(0.01);
  // if (! AnimFrame >= 24.0 / 46.0 ) goto JL00F6;
  
  //do and until -AdamJD
  do 
  { 
	sleep(0.01); 
  }
  until(AnimFrame >= 24.0 / 46.0);
  
  AnimRate = 1.0;
  FinishAnim();
  PlayAnim('React',1.0,0.2);
  PlaySound(Sound'Arragog_attack02',Slot_None,1.0,,1000000.0,RandRange(0.81,1.0));
  Sleep(7.0 / 30.0);
  PlaySound(Sound'Arragog_attack02',Slot_None,RandRange(0.5,0.69999999),,1000000.0,RandRange(0.5,0.69999999));
  FinishAnim();
  GotoState('stateGoHome');
}

state stateBeatAragog
{
begin:
  PlayAnim('slump',0.69999999,0.2);
  PlaySound(Sound'SS_ARA_Hurtscream_0002',Slot_None,1.0,,1000000.0);
  PlaySound(Sound'pig_squeal1',Slot_None,1.0,,1000000.0,0.69999999);
  PlaySound(Sound'SS_ARA_Growl_0001b',Slot_None,1.0,,1000000.0);
  Sleep(1.0);
  LoopAnim('RearsUpLoop',1.0,0.81);
  PlaySound(Sound'pig_squeal1',Slot_None,1.0,,1000000.0,1.0);
  PlaySound(Sound'ss_ARG_BigDeathScream_05b',Slot_None,1.0,,1000000.0,1.29999995);
  Sleep(0.5);
  PlaySound(Sound'SS_ARA_Growl_0001b',Slot_None,0.5,,1000000.0);
  PlaySound(Sound'pig_squeal1',Slot_None,0.5,,1000000.0,0.41);
  TempFloat = 0.62;
  TempTime = 43.0 / 30.0 / TempFloat;
  PlayAnim('slump',TempFloat,0.2);
  Sleep(30.0 / 30.0);
  TempTime -= 30.0 / 30.0;
  PlaySound(Sound'ss_ARG_BigDeathScream_05b',Slot_None,1.0,,1000000.0,1.29999995);
  Sleep(TempTime);
  DoStomp(True,True);
  Sleep(2.5);
  // eVulnerableToSpell = 0;
  eVulnerableToSpell=SPELL_None;
  bPhaseOneOver = False;
  SendDefeatedTrigger();
  PlayerHarry.StopBossEncounter();
}

state NipHarry
{
//begin, begin, begin... -AdamJD
begin:
  bBigBite = True;
  PlayAnim('KnockBack',1.0,0.2);
  Sleep(0.31);
  nipLocation = Location + Normal(PlayerHarry.Location - Location) * 100;
  SetLocation(nipLocation);
  GotoState('stateMovetoAttack');
}

defaultproperties
{
	Health=100
	
    maxWebs=7

    minTimeBetweenHits=20.00

    numAnchors=8

    randDialogInterval=15.00

    RearUpTimeStart=3.50

    RearUpTimeEnd=2.25

    maxAttendentsInLevel=15

    StompAnimRateStart=1.00

    StompAnimRateEnd=1.50

    SpitAnimRateStart=1.00

    SpitAnimRateEnd=1.25

    TimeBetweenSPELL_LINEShotsStart=0.60

    TimeBetweenSPELL_LINEShotsEnd=0.40

    WebLifetime=3.00

    timeBetweenAttacks=4.00

    damageVulnerable=20.00

    damageNormal=1.00

    WebDamageTimer=1.00

    WebDamage=15

    SpellDamage=25.00

    SpellSpraySpreadAmount=3000

    BiteDamage=120.00

    BigBiteDamage=120.00

    webCollisionRadius=35.00

    numberOfSpells=1

    HealthAddSpellTwo=75

    HealthAddSpellThree=50

    // EnemyHealthBar=0
	EnemyHealthBar=EnemyBar_Aragog

    ShadowClass=None

    GroundSpeed=500.00

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra
	
	Physics=PHYS_Walking

    bGestureFaceHorizOnly=True

    Mesh=SkeletalMesh'HPModels.skAragogMesh'

    DrawScale=3.00

    AmbientGlow=65

    CollisionRadius=100.00

    CollisionHeight=90.00

	bCollideWorld=True
	
	bCollideActors=True
	
    bBlockActors=False

    bBlockPlayers=False
	
	bRotateToDesired=True
	
	bOnMyWeb=False

    RotationRate=(Pitch=40000,Yaw=40000,Roll=40000)
}
