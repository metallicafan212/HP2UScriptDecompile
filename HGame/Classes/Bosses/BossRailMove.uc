//================================================================================
// BossRailMove.
//================================================================================

class BossRailMove extends baseBoss;

var Sound peevesVoice;
var Vector vMoveDir;
var Vector vMoveTo;
var float MoveSpeed;
var() name NavPoint_MoveTagName;
var() name NavPoint_HarryDistanceTagName;
var NavigationPoint RailEnd1;
var NavigationPoint RailEnd2;
var NavigationPoint HarryDistNavPoint;
var Vector vClosestPointOnRail;
var Vector vNormalToHarryMoveRail;
var float DistToHarryMoveRail;
var bool bMovingLeft;
var Vector v1;
var Vector v2;
var Vector v3;
var Vector v4;
var Vector n1;
var Vector n2;
var int ProjectileCount;
var int MoveCount;
var bool bDoDirectionChange;
var int ThrowNInARow;
var bool bHaveThrownYet;
var() name TriggerToSendOnFirstThrow;
var bool bDidFirstMove;
var() Class<baseSpell> SpellToCast;
var() name StartAnim;
var bool bDoTakeDamageSpeech;
var float PlayHarryHurtTimer;
var float PlayNoSoundsTimer;
var int iCurrentOuchSfx;
var int iHitSfx;
var int iRandomSfx;
var int iMalfoyHitHarrySfx;
var Vector vPosSave;
var bool bFlyBackToVPosSave;
var Sound tempSound;
var float TempTime;
var Rotator TempRotator;

function PostBeginPlay ()
{
  local baseWand weap;
  local NavigationPoint A;
  local Vector V;
  local Vector v0;
  local Actor Act;

  Super.PostBeginPlay();
  vMoveDir.X = 1.0;
  vMoveDir.Y = 0.0;
  vMoveDir.Z = 0.0;
  MoveSpeed = GroundSpeed;
  foreach AllActors(Class'NavigationPoint',A,NavPoint_MoveTagName)
  {
    if ( RailEnd1 == None )
    {
      RailEnd1 = A;
    } else {
      RailEnd2 = A;
      // goto JL007E;
	  break;
    }
  }
  foreach AllActors(Class'NavigationPoint',A,NavPoint_HarryDistanceTagName)
  {
    HarryDistNavPoint = A;
    // goto JL00A3;
	break;
  }
  if ( (RailEnd1 != None) && (RailEnd2 != None) && (HarryDistNavPoint != None) )
  {
    v0 = Normal(RailEnd2.Location - RailEnd1.Location);
    V = v0 * ((HarryDistNavPoint.Location - RailEnd1.Location) Dot v0);
    vClosestPointOnRail = RailEnd1.Location + V;
    vNormalToHarryMoveRail = HarryDistNavPoint.Location - vClosestPointOnRail;
    DistToHarryMoveRail = VSize(vNormalToHarryMoveRail);
    vNormalToHarryMoveRail = Normal(vNormalToHarryMoveRail);
    v1 = RailEnd1.Location + vNormalToHarryMoveRail * 120;
    v2 = RailEnd2.Location + vNormalToHarryMoveRail * 120;
    v3 = v1 + vNormalToHarryMoveRail * (DistToHarryMoveRail - 80);
    v4 = v2 + vNormalToHarryMoveRail * (DistToHarryMoveRail - 80);
    n1 = Normal(v1 - v3);
    n2 = Normal(v2 - v1);
  }
  FindNewMoveToLoc();
  SetTimer(0.2,True);
}

function Timer ()
{
  if ( PlayHarryHurtTimer > 0 )
  {
    PlayHarryHurtTimer -= 0.2;
    if ( PlayHarryHurtTimer <= 0 )
    {
      PlayHarryHurtTimer = 0.0;
      PlayMalfoyHitHarrySfx();
      PlayNoSoundsTimer = 2.0;
    }
  }
  if ( PlayNoSoundsTimer > 0 )
  {
    PlayNoSoundsTimer -= 0.2;
    if ( PlayNoSoundsTimer < 0 )
    {
      PlayNoSoundsTimer = 0.0;
    }
  }
}

function float GetHealth ()
{
  return float(iNumHitsToBeat - iNumHits) / float (iNumHitsToBeat);
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  local Actor Act;

  GotoState('PatrolForHarry');
  PlayerHarry.ClientMessage(string(SpellToCast));
  PlayDialogLoud("PC_PVS_happy01fx");
}

function Rotator AdjustAim (float ProjSpeed, Vector projStart, int AimError, bool bLeadTarget, bool bWarnTarget)
{
  local Rotator R;
  local float degrees;
  local float D;

  R = rotator(PlayerHarry.Location - Location);
  degrees = FClamp(VSize2D(PlayerHarry.Location - Location),0.0,DistToHarryMoveRail) / DistToHarryMoveRail;
  degrees = degrees * degrees * 40.0 + 5.0;
  degrees = 90.0 - degrees;
  R.Pitch = degrees * 65536.0 / 360.0;
  return R;
}

function bool HandleSpellSkurge (optional baseSpell spell, optional Vector vHitLocation)
{
  TakeDamage(5,None,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
  return True;
}

function bool FlyBackToVPosSave ()
{
  return False;
}

function bool RespondToDamage ()
{
  return True;
}

event TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
  PlayerHarry.ClientMessage("boss takes damage");
  bFlyBackToVPosSave = FlyBackToVPosSave();
  PlayOuchSfx(False);
  iNumHits++;
  if ( iNumHits >= iNumHitsToBeat )
  {
    if ( iNumHits == iNumHitsToBeat )
    {
      SendDefeatedTrigger();
      PlayerHarry.StopBossEncounter();
      CleanupAfterBoss();
      // SetPhysics(4);
	  SetPhysics( PHYS_Flying );
      GroundSpeed = 300.0;
      GotoState('stateIdle');
    }
  } else {
    if ( RespondToDamage() )
    {
      PlayAnim('prefly',1.0,0.31);
      if ( bFlyBackToVPosSave )
      {
        GotoState('stateHit2');
      } else {
        GotoState('stateHit3');
      }
    }
  }
}

function PlayRunAnim ()
{
  if ( bMovingLeft )
  {
    LoopAnim('Flying',1.0,1.0);
  } else {
    LoopAnim('Flying',1.0,1.0);
  }
}

function FindNewMoveToLoc ()
{
  local int I;
  local float D;

  if ( (RailEnd1 == None) || (RailEnd2 == None) )
  {
    vMoveTo = Location + VRand();
    PlayerHarry.ClientMessage("No rail ends for boss");
  } else {
    if (  !bDidFirstMove )
    {
      bDidFirstMove = True;
      vMoveTo = (RailEnd2.Location + RailEnd1.Location) / 2;
    } else {
      D = VSize2D(RailEnd2.Location - RailEnd1.Location);
      // I = 0;
	  //this is a for loop... -AdamJD
      for ( I = 0; I < 5; I++ )
      {
        vMoveTo = RailEnd1.Location + (RailEnd2.Location - RailEnd1.Location) * FRand();
        if ( VSize2D(vMoveTo - Location) > D / 5 )
        {
          // goto JL0132;
		   break;
        }
        // I++;
        // goto JL00C0;
      }
    }
    if ( (RailEnd2.Location - RailEnd1.Location) Dot (vMoveTo - Location) < 0 )
    {
      bMovingLeft = True;
    } else {
      bMovingLeft = False;
    }
  }
  vMoveDir = Normal(vMoveTo - Location);
}

auto state stateIdle
{
  function bool RespondToDamage ()
  {
    return False;
  }
  
 begin:
  LoopAnim(StartAnim);
}

state PatrolForHarry
{
  function BeginState ()
  {
    FindNewMoveToLoc();
  }
  
  function Touch (Actor Other)
  {
    if ( harry(Other) != None )
    {
      harry(Other).vAdditionalAccel = (RailEnd2.Location - RailEnd1.Location) Cross vect(0.00,0.00,1.00) * 400;
    }
  }
  
  function Bump (Actor Other)
  {
    Touch(Other);
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    SetLocation(OldLocation);
  }
  
  function Tick (float DeltaTime)
  {
    local Vector newLoc;
    local Actor A;
    local float fMoveDist;
    local float D;
    local Rotator R;
  
    fMoveDist = MoveSpeed * DeltaTime;
    vMoveDir = vMoveTo - Location;
    vMoveDir.Z = 0.0;
    D = VSize(vMoveDir);
    vMoveDir = Normal(vMoveDir);
    if ( D < 50 )
    {
      vMoveDir *= (D + 50) / 100;
    }
    MoveSmooth(vMoveDir * fMoveDist);
    R = rotator(PlayerHarry.Location - Location);
    R.Pitch = 0;
    DesiredRotation = R;
    if ( VSize2D(Location - vMoveTo) < fMoveDist )
    {
      if ( bDoDirectionChange && (FRand() < 0.25) )
      {
        bDoDirectionChange = False;
        GotoState('ShortWait');
      } else {
        switch (PlayerHarry.Difficulty)
        {
		  /*
          case 0:
          ThrowNInARow = 2;
          break;
          case 1:
          ThrowNInARow = 4;
          break;
          case 2:
          ThrowNInARow = 6;
          break;
          default:
		  */
		  
		  case DifficultyEasy:    ThrowNInARow = 2;   break;
		  case DifficultyMedium:  ThrowNInARow = 4;   break;
		  case DifficultyHard:    ThrowNInARow = 6;   break;
        }
        bDoDirectionChange = True;
        GotoState('AttackHarry');
      }
    }
  }
  
 begin:
  AirSpeed = 500.0;
  PlayRunAnim();
}

state ShortWait
{
begin:
  PlayAnim('prefly',2.0,0.25);
  PlayDialogLoud("PC_PVS_happy01fx",,,,,RandRange(0.81,1.25));
  DesiredRotation = Rotation;
  FinishAnim();
  PlayRunAnim();
  GotoState('PatrolForHarry');
}

state AttackHarry
{
begin:
  PlayAnim('prefly',2.0,0.2);
  if (  !bHaveThrownYet )
  {
    bHaveThrownYet = True;
    TriggerEvent(TriggerToSendOnFirstThrow,self,self);
  }
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  FinishAnim();
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  GotoState('throwing');
}

state stateTaunt1
{
  function bool FlyBackToVPosSave ()
  {
    return True;
  }
  
  function BeginState ()
  {
    vPosSave = Location;
    // DoFlyTo_Actor(PlayerHarry,vect(30.00,0.00,80.00),4,0.64999998,False,True);
    DoFlyTo_Actor( PlayerHarry, vect(30,0,80), MOVE_TYPE_EASE_FROM_AND_TO, 0.64999998, false, true );
	switch (Rand(3))
    {
      case 0:
      PlayAnim('Taunt',1.0,0.5);
      break;
      case 1:
      PlayAnim('taunt_2',1.0,0.5);
      break;
      case 2:
      PlayAnim('taunt_3',1.0,0.5);
      break;
      default:
    }
    switch (Rand(7))
    {
      case 0:
      PlayDialogLoud("PC_PVS_happy02fx",,,,,RandRange(0.81,1.25));
      break;
      case 1:
      PlayDialogLoud("PC_PVS_happy03fx",,,,,RandRange(0.81,1.25));
      break;
      case 2:
      PlayDialogLoud("PC_PVS_happy04fx",,,,,RandRange(0.81,1.25));
      break;
      case 3:
      PlayDialogLoud("PC_PVS_happy05fx",,,,,RandRange(0.81,1.25));
      break;
      case 4:
      PlayDialogLoud("PC_PVS_happy06fx",,,,,RandRange(0.81,1.25));
      break;
      case 5:
      PlayDialogLoud("PC_PVS_Chal2Skurge_51",,,,,RandRange(0.81,1.25));
      break;
      case 6:
      PlayDialogLoud("PC_PVS_Chal2Skurge_53",,,,,RandRange(0.81,1.25));
      break;
      default:
    }
  }
  
  function EndState ()
  {
    DestroyControllers();
  }
  
  function OnEvent (name EventName)
  {
    if ( EventName == 'ActionDone' ) //goto JL000F;
	{
		GotoState('stateTaunt2');
	}
  }
  
}

state stateTaunt2
{
  function bool FlyBackToVPosSave ()
  {
    return True;
  }
  
  function EndState ()
  {
    DestroyControllers();
  }
  
  function OnEvent (name EventName)
  {
    if ( EventName == 'ActionDone' )
    {
      GotoState('PatrolForHarry');
    }
  }
  
 begin:
  Sleep(0.5);
  // DoFlyTo(vPosSave,4,0.64999998);
  DoFlyTo( vPosSave, MOVE_TYPE_EASE_FROM_AND_TO, 0.65 );
}

state throwing
{
begin:
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  PlayAnim('throw',1.0,0.2);
  Sleep(17.0 / 30.0);
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  ShootSpell();
  if ( FRand() < 0.5 )
  {
    tempSound = Sound'peeves_throw';
  } else {
    tempSound = Sound'peeves_throw2';
  }
  // PlaySound(tempSound,0,RandRange(0.62,1.0),,95000.0,RandRange(0.81,1.25),,False);
  PlaySound( TempSound, SLOT_None, [Volume]RandRange(0.62, 1.0),, [Radius]95000, [Pitch]RandRange(0.8, 1.25),, false );
  ProjectileCount++;
  if ( ProjectileCount >= 3 )
  {
    ProjectileCount = 0;
  }
  if ( ThrowNInARow - 1 > 0 )
  {
    ThrowNInARow--;
    DesiredRotation.Yaw = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00)).Yaw;
    Sleep(0.31);
    goto ('Begin');
  }
  FinishAnim();
  DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  GotoState('PatrolForHarry');
}

function ShootSpell ()
{
  local spellEcto A;
  local Rotator R;

  R = Rotation;
  R.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  A = spellEcto(SpawnSpellEx(Class'spellEcto',Location,R,PlayerHarry));
  A.fxFlyParticleEffect.ParticlesPerSec.Base *= 4;
  A.Velocity *= 0.34999999;
}

state stateHit2
{
  function bool RespondToDamage ()
  {
    return False;
  }
  
  function EndState ()
  {
    DestroyControllers();
  }
  
  function OnEvent (name EventName)
  {
    if ( EventName == 'ActionDone' )
    {
      GotoState('stateHit3');
    }
  }
  
 begin:
  // DoFlyTo(vPosSave,4,0.5);
  DoFlyTo( vPosSave, MOVE_TYPE_EASE_FROM_AND_TO, 0.5 );
}

state stateHit3
{
  function bool FlyBackToVPosSave ()
  {
    return True;
  }
  
  function bool RespondToDamage ()
  {
    return False;
  }
  
  function BeginState ()
  {
    TempRotator = Rotation;
    TempRotator.Pitch = 0;
    TempTime = Level.TimeSeconds;
    vPosSave = Location;
  }
  
  function Tick (float dtime)
  {
    local float theta;
    local float Radius;
    local Vector V;
    local Rotator R;
  
    Radius = 100.0;
    theta = (Level.TimeSeconds - TempTime) * 4.5;
    V.X = ( -Cos(theta) + 0.5) * Radius;
    V.Z = Sin(theta) * Radius;
    SetLocation(vPosSave + (V >> TempRotator));
    R = TempRotator;
    R.Pitch =  -theta * 32768.0 / 3.1415925;
	SetRotation(R);
    if ( theta >= 2.0 * 3.1415925 )
    {
      SetRotation(TempRotator);
      MoveSpeed = GroundSpeed + (GroundSpeedEnd - GroundSpeed) * iNumHits / iNumHitsToBeat;
      if ( PlayerHarry.Difficulty == DifficultyMedium )
      {
        MoveSpeed *= 1.29999995;
      } else {
        if ( PlayerHarry.Difficulty == DifficultyHard )
        {
          MoveSpeed *= 1.79999995;
        }
      }
      PlayRunAnim();
      GotoState('PatrolForHarry');
    }
  }
  
 begin:
  PlayHitSfx();
}

function PlayOuchSfx (bool bPlayTalkingOuches)
{
  local Sound snd;
  local string Str;

  bDoTakeDamageSpeech = True;
  if (  !bPlayTalkingOuches && (iCurrentOuchSfx == 0) )
  {
    iCurrentOuchSfx++;
  }
  switch (iCurrentOuchSfx)
  {
    case 0:
    Str = "peeves_ow01";
    break;
    case 1:
    Str = "peeves_ow02";
    break;
    case 2:
    Str = "peeves_ow03";
    break;
    default:
  }
  PlayDialogLoud(Str);
  // PlayDialogLoud("peeves_ow_long",0,,,,RandRange(0.81,1.25));
  PlayDialogLoud( "peeves_ow_long", SLOT_None,,,, [Pitch]RandRange(0.81, 1.25) );
  iCurrentOuchSfx++;
  if ( iCurrentOuchSfx > 2 )
  {
    iCurrentOuchSfx = 0;
  }
}

function PlayHitSfx ()
{
  local Sound snd;
  local string Str;

  if ( PlayNoSoundsTimer != 0 )
  {
    return;
  }
  if (  !bDoTakeDamageSpeech )
  {
    return;
  }
  PlaySound(snd);
  iHitSfx++;
  if ( iHitSfx > 2 )
  {
    iHitSfx = 0;
  }
  PlayNoSoundsTimer = 3.0;
}

function PlayRandomSfx ()
{
  local Sound snd;
  local string Str;

  if ( PlayNoSoundsTimer != 0 )
  {
    return;
  }
  if ( FRand() < 0.75 )
  {
    return;
  }
  PlaySound(snd);
  iRandomSfx++;
  if ( iRandomSfx > 4 )
  {
    iRandomSfx = 0;
  }
  PlayNoSoundsTimer = 3.0;
}

function PlayMalfoyHitHarrySfx ()
{
  local Sound snd;
  local string Str;

  if ( PlayNoSoundsTimer != 0 )
  {
    return;
  }
  if ( PlayerHarry.HarryIsDead() )
  {
    return;
  }
  PlayerHarry.ClientMessage("iMalfoyHitHarrySfx:" $ string(iMalfoyHitHarrySfx) $ "  snd:" $ string(snd));
  PlaySound(snd);
  iMalfoyHitHarrySfx++;
  if ( iMalfoyHitHarrySfx > 5 )
  {
    iMalfoyHitHarrySfx = 0;
  }
}

function HarryWasHurt (bool bHarryWasKilled)
{
  if ( PlayHarryHurtTimer == 0 )
  {
    PlayHarryHurtTimer = 1.0;
  }
}

function CleanupAfterBoss ()
{
  local Actor A;

  foreach AllActors(SpellToCast,A)
  {
    A.Destroy();
  }
  foreach AllActors(Class'Actor',A,'EctoBehindPeeves')
  {
    A.GotoState('stateShowing');
  }
}

defaultproperties
{
    SpellToCast=Class'spellEcto'

    StartAnim=Idle

    iNumHitsToBeat=5

    // EnemyHealthBar=3
	EnemyHealthBar=EnemyBar_Peeves

    AirSpeed=150.00

    MenuName="Peeves"

    // Physics=5
	Physics=PHYS_Rotating

    Mesh=SkeletalMesh'HPModels.skpeevesMesh'

    DrawScale=1.00

    AmbientGlow=65

    CollisionRadius=40.00

    CollisionHeight=40.00

    bCollideWorld=False
	
	bCollideActors=True

    bBlockActors=False

    bBlockPlayers=False
	
	bProjTarget=True

    RotationRate=(Pitch=80000,Yaw=80000,Roll=80000)
	
	eVulnerableToSpell=SPELL_Skurge //UTPT forgot to add this which caused the Peeves cutscene to softlock... -AdamJD
}
