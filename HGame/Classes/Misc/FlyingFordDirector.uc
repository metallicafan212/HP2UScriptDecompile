//================================================================================
// FlyingFordDirector.
//================================================================================

//this is an unused file -AdamJD

class FlyingFordDirector extends Director;

enum CarLocations {
  LOC_NONE,
  LOC_SAFE,
  LOC_TOWN
};

var FlyingCarHarry PlayerHarry;
var MuggleMeterManager MuggleMeter;
var FlyingFordPathGuide guide;
var FlyingFordHedwig Hedwig;
var Boeing747 Plane;
var DynamicInterpolationPoint Points[2];
var baseConsole Console;
var int SafeRefCount;
var int TownRefCount;
var float fDefaultRandomDialog;
var float fRandomDialog;
var() float fOverTownMeter;
var() float fOverSheepMeter;
var() float fOverPlaneMeter;
var() float fResetMeter;
var() float HedwigMaxDistance;
var() float HedwigPrepivotDistanceFront;
var() float HedwigPrepivotDistanceUp;
var float fWindViolence;
var Vector vDirection;
var float fTurbulence;
var Vector distanceMinusZ;
var FlyingFordLightning lightningZone;
var ThunderLightning lightning;
var bool blightningStrike;
var Vector strikeDirection;
var Vector tempDistance;
var float fLightningViolence;
var int iLightningLoops;
var float fTimeBetweenchanges;
var CarLocations CarLocation;

function PreBeginPlay()
{
  local DynamicInterpolationPoint p;
  local int Counter;

  Super.PreBeginPlay();
// JL001A:
  foreach AllActors(Class'FlyingCarHarry',PlayerHarry)
  {
    // goto JL001A;
	break;
  }
  foreach AllActors(Class'MuggleMeterManager',MuggleMeter)
  {
    // goto JL002F;
	break;
  }
  foreach AllActors(Class'Boeing747',Plane)
  {
    // goto JL0044;
	break;
  }
  PlayerHarry.ClientMessage("Make sure I get here");
  guide = Spawn(Class'FlyingFordPathGuide',,,Location + Vec(200.0,50.0,0.0),Rotation);
  guide.PathName = PlayerHarry.PathName;
  guide.AirSpeedNormal = PlayerHarry.AirSpeedNormal;
  Log("*************What is the pathname for the car  :  " $ string(PlayerHarry.PathName));
  PlayerHarry.guide = guide;
  Hedwig = Spawn(Class'FlyingFordHedwig',,,Location + Vec(50.0,50.0,-50.0),Rotation);
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
  InitialState = 'GameIntro';
  CarLocation = LOC_SAFE;
  Hedwig.SetOwner(guide);
  Hedwig.AttachToOwner();
  Hedwig.bTrailerPrePivot = True;
  Hedwig.PrePivot = Vec(HedwigPrepivotDistanceFront,0.0,HedwigPrepivotDistanceUp);
}

function OnTouchEvent (Pawn Subject, Actor Object)
{
  if ( Object.Tag == 'FlyingFordSafe' )
  {
    IncrementSafeCount();
  } else //{
    if ( Object.Tag == 'FlyingFordTown' )
    {
      IncrementTownCount();
    } else //{
      if ( Object.Tag == 'FlyingFordWind' )
      {
        // goto JL00D7;
		//KW left this empty? -AdamJD
      }
      if ( Object.Tag == 'FlyingFordWindTrigger' )
      {
        PlayerHarry.ClientMessage("The trigger has been touched");
      } else //{
        if ( Object.Tag == 'FlyingFordLightning' )
        {
          lightningZone = FlyingFordLightning(Object);
          GotoState('GameLightning');
        }
      //}
    //}
  //}
  if ( SetCarLocation() )
  {
    UpdateHud();
  }
}

function OnUnTouchEvent (Pawn Subject, Actor Object)
{
  if ( Object.Tag == 'FlyingFordSafe' )
  {
    DecrementSafeCount();
  } else //{
    if ( Object.Tag == 'FlyingFordTown' )
    {
      DecrementTownCount();
    } else //{
      if ( Object.Tag == 'FlyingFordLightning' )
      {
        if ( IsInState('GameLightning') )
        {
          PlayerHarry.ClientMessage("Return to state GamePlay from an UNTouch message  " $ string(GetStateName()));
          GotoState('GamePlay');
        }
      }
    //}
  //}
  if ( SetCarLocation() )
  {
    UpdateHud();
  }
}

function OnHitEvent (Pawn Subject)
{
  PlayerHarry.ClientMessage(string(Subject.Name) $ " hit an obstacle");
}

function OnCutSceneEvent (name CutSceneTag)
{
  PlayerHarry.ClientMessage("CutScene " $ string(CutSceneTag) $ " triggered Director");
}

function OnTriggerEvent (Actor Other, Pawn EventInstigator)
{
  PlayerHarry.ClientMessage(string(Other) $ " triggered Director with " $ string(EventInstigator));
  if ( Other != None )
  {
    PlayerHarry.ClientMessage("We have triggered an airplane");
    GotoState('GameAirplane');
  }
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  local CutScene CutScene;
  local CutScript CutScript;

  CutScene = CutScene(Other);
  CutScript = CutScript(Other);
  if ( (CutScene != None) || (CutScript != None) )
  {
    OnCutSceneEvent(CutScene.Tag);
  } else {
    OnTriggerEvent(Other,EventInstigator);
  }
}

function OnPlayerPossessed()
{
  Super.OnPlayerPossessed();
  Log("Player possessed");
  Console = baseConsole(PlayerHarry.Player.Console);
  TriggerEvent('FlyingFordIntro',self,None);
}

function OnPlayerDying()
{
  PlayerHarry.ClientMessage("Player dying...");
}

function OnPlayersDeath()
{
  PlayerHarry.ClientMessage("Player died; restarting game");
  Level.Game.RestartGame();
}

function OnActionKeyPressed()
{
  PlayerHarry.ClientMessage("Action key pressed");
}

function StartTurbulence (float violence, Vector Direction)
{
  fWindViolence = violence;
  vDirection = Direction;
  GotoState('GameWind');
}

function StartLightning()
{
  local ThunderLightning tempObject;
  local name nameOfStorm;

  PlayerHarry.ClientMessage("StartLightning has been entered");
  nameOfStorm = lightningZone.stormName;
  foreach AllActors(Class'ThunderLightning',tempObject)
  {
    if ( tempObject.stormName == nameOfStorm )
    {
      lightning = tempObject;
    }
  }
  fLightningViolence = lightningZone.fLightningViolence;
  iLightningLoops = lightningZone.iLightningLoops;
  fTimeBetweenchanges = lightningZone.fTimeBetweenchanges;
}

function IncrementSafeCount()
{
  SafeRefCount++;
  Log("Safe Count : " $ string(SafeRefCount));
}

function DecrementSafeCount()
{
  SafeRefCount--;
  if ( SafeRefCount < 0 )
  {
    SafeRefCount = 0;
  }
  Log("Safe Count : " $ string(SafeRefCount));
}

function IncrementTownCount()
{
  TownRefCount++;
  Log("Town Count : " $ string(TownRefCount));
}

function DecrementTownCount()
{
  TownRefCount--;
  if ( TownRefCount < 0 )
  {
    TownRefCount = 0;
  }
  Log("Town Count : " $ string(TownRefCount));
}

function bool SetCarLocation()
{
  local CarLocations currentLocation;

  currentLocation = CarLocation;
  if ( SafeRefCount > 0 )
  {
    CarLocation =  LOC_SAFE;
  } else //{
    if ( TownRefCount > 0 )
    {
      CarLocation =  LOC_TOWN;
    } else {
      CarLocation =  LOC_NONE;
    }
  //}
  if ( currentLocation == CarLocation )
  {
    return False;
  } else {
    return True;
  }
}

function UpdateHud()
{
  switch (CarLocation)
  {
    // case 1:
	case LOC_SAFE:
		Log("Resetting the MuggleMeter");
		MuggleMeter.MugglesOutOfRange(fResetMeter);
		break;
	// case 2:
	case LOC_TOWN:
		Log("MuggleMeter going up by fOverTownMeter");
		MuggleMeter.MugglesInRange(fOverTownMeter);
		break;
	// case 0:
	case LOC_NONE:
		Log("MuggleMeter going up by fOverSheepMeter. Look there's a sheep!");
		MuggleMeter.MugglesInRange(fOverSheepMeter);
		break;
	default:
		Log("We are in an unknown location");
		break;
  }
}

state GameIntro
{
  function BeginState()
  {
  }
  
  function OnCutSceneEvent (name CutSceneTag)
  {
    MuggleMeter.BeginDetection();
    GotoState('GamePlay');
  }
  
}

state GamePlay
{
begin:
  PlayerHarry.ClientMessage("We are in GamePlay.");
  Hedwig.LoopAnim('Drop');
}

state GameWon
{
}

state GameRestart
{
begin:
  OnPlayersDeath();
}

state GameAirplane
{
  function BeginState()
  {
    Plane.StartTransPath();
  }
  
  function MovePoints()
  {
    local Vector pos1;
    local Vector pos2;
    local Vector vCarDirection;
    local Vector vUp;
    local Vector vRight;
    local Vector p1Ahead;
    local Vector p1Side;
    local Vector p2Ahead;
    local Vector p2Side;
  
    vCarDirection = vector(PlayerHarry.Rotation);
    vUp = Vec(0.0,0.0,1.0);
    vRight = vCarDirection Cross vUp;
    p1Ahead = PlayerHarry.Location + (vCarDirection * 300);
    p1Side = PlayerHarry.Location + (vRight * 200);
    p2Ahead = PlayerHarry.Location + (vCarDirection * 200);
    p2Side = PlayerHarry.Location + (vCarDirection * 0);
    Points[0].SetLocation(p1Ahead + p1Side);
    Points[1].SetLocation(p2Ahead + p2Side);
  }
  
  function SetPlaneOnPath()
  {
    Plane.StartOnPath();
  }
  
}

state GameWind
{
  function BeginState()
  {
    fTurbulence = 0.0;
    PlayerHarry.LoopAnim('flyingeratic');
    PlayerHarry.ClientMessage("IN the beginning  :  " $ string(PlayerHarry.vCurrentTetherDistance));
  }
  
  function EndState()
  {
    PlayerHarry.LoopAnim('Flying');
    PlayerHarry.ClientMessage("IN the end  :  " $ string(PlayerHarry.vCurrentTetherDistance));
  }
  
  function float windDirectionConst()
  {
    local Vector vRight;
    local Vector vGuideDirection;
    local Vector vUp;
  
    vGuideDirection = vector(guide.Rotation);
    vUp = Vec(0.0,0.0,1.0);
    vRight = vGuideDirection Cross vUp;
    if ( vDirection Dot vRight > 0 )
    {
      return -1.0;
    } else {
      return 1.0;
    }
  }
  
  function Vector windDirectionVector()
  {
    local Vector vRight;
    local Vector vGuideDirection;
    local Vector vUp;
    local Vector vLeft;
  
    vGuideDirection = vector(guide.Rotation);
    vUp = Vec(0.0,0.0,1.0);
    vRight = vGuideDirection Cross vUp;
    vLeft =  -vRight;
    if ( vDirection Dot vRight > 0 )
    {
      vRight.Z = vDirection.Z;
      return vRight;
    } else {
      vLeft.Z = vDirection.Z;
      return vLeft;
    }
  }
  
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    if ( fTurbulence < VSize(fWindViolence * vDirection) )
    {
      fTurbulence += VSize(fWindViolence * vDirection) * DeltaTime;
      PlayerHarry.vTurbulence += fWindViolence * windDirectionVector() * DeltaTime;
    } else {
      distanceMinusZ = windDirectionVector();
      distanceMinusZ.Z = 0.0;
      PlayerHarry.sideDistance += VSize(fWindViolence * distanceMinusZ) * windDirectionConst();
      PlayerHarry.upDistance += PlayerHarry.vTurbulence.Z;
      PlayerHarry.vTurbulence = Vec(0.0,0.0,0.0);
      GotoState('GamePlay');
    }
  }
  
}

state GameLightning
{
  function BeginState()
  {
    StartLightning();
  }
  
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    if ( lightning.bLightningActive == True )
    {
      GotoState('StruckByLightning');
    }
  }
  
}

state StruckByLightning
{
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    tempDistance = strikeDirection;
    tempDistance.Z = 0.0;
    PlayerHarry.sideDistance += VSize(fLightningViolence * tempDistance) * sideDirectionConst();
    tempDistance = strikeDirection;
    tempDistance.X = 0.0;
    tempDistance.Y = 0.0;
    PlayerHarry.upDistance += VSize(fLightningViolence * tempDistance) * upDirectionConst();
    PlayerHarry.vTurbulence = Vec(0.0,0.0,0.0);
  }
  
  function float sideDirectionConst()
  {
    local Vector vRight;
    local Vector vGuideDirection;
    local Vector vUp;
  
    vGuideDirection = vector(guide.Rotation);
    vUp = Vec(0.0,0.0,1.0);
    vRight = vGuideDirection Cross vUp;
    if ( strikeDirection Dot vRight > 0 )
    {
      return -1.0;
    } else {
      return 1.0;
    }
  }
  
  function float upDirectionConst()
  {
    local Vector vGuideDirection;
  
    vGuideDirection = vector(guide.Rotation);
    if ( vGuideDirection Dot strikeDirection > 0 )
    {
      return -1.0;
    } else {
      return 1.0;
    }
  }
  
  function Vector OutofControl()
  {
    local Vector newSideDirection;
    local Vector newUpDirection;
    local Vector vRight;
    local Vector vGuideDirection;
    local Vector vUp;
    local float fRandPercentSide;
    local Vector newVector;
    local float newYaw;
    local float newPitch;
  
    vGuideDirection = vector(guide.Rotation);
    vUp = Vec(0.0,0.0,1.0);
    vRight = vGuideDirection Cross vUp;
    fRandPercentSide = FRand();
    if ( Rand(2) == 0 )
    {
      newSideDirection = vRight * (fLightningViolence * fRandPercentSide);
      newYaw = fLightningViolence * (fRandPercentSide * 500);
    } else {
      newSideDirection =  -vRight * (fLightningViolence * fRandPercentSide);
      newYaw =  -fLightningViolence * (fRandPercentSide * 500);
    }
    if ( Rand(2) == 0 )
    {
      newUpDirection = Vec(0.0,0.0,1.0) * fLightningViolence * (1 - fRandPercentSide);
      if ( fLightningViolence * (1 - fRandPercentSide) * 500 < PlayerHarry.PitchLimitUp )
      {
        newPitch = fLightningViolence * (1 - fRandPercentSide) * 500;
      } else {
        newPitch = PlayerHarry.PitchLimitUp;
      }
    } else {
      newUpDirection = Vec(0.0,0.0,-1.0) * fLightningViolence * (1 - fRandPercentSide);
      if ( fLightningViolence * (1 - fRandPercentSide) * 500 < PlayerHarry.PitchLimitDown )
      {
        newPitch =  -fLightningViolence * (1 - fRandPercentSide) * 500;
      } else {
        newPitch = PlayerHarry.PitchLimitDown;
      }
    }
    PlayerHarry.fLightningYaw = newYaw;
    PlayerHarry.fLightningPitch = newPitch;
    newVector = newSideDirection + newUpDirection;
    return newVector;
  }
  
 begin:
  // if ( iLightningLoops > 0 )
  while ( iLightningLoops > 0 )
  {
    strikeDirection = OutofControl();
    Sleep(fTimeBetweenchanges);
    iLightningLoops--;
    // goto JL0000;
  }
  PlayerHarry.fLightningYaw = 0.0;
  PlayerHarry.fLightningPitch = 0.0;
  GotoState('GamePlay');
}

defaultproperties
{
    fDefaultRandomDialog=5.00

    fOverTownMeter=5.00

    fOverSheepMeter=2.00

    fOverPlaneMeter=5.00

    fResetMeter=10.00

    HedwigMaxDistance=400.00

    HedwigPrepivotDistanceFront=200.00

    HedwigPrepivotDistanceUp=100.00

    Tag=''
}
