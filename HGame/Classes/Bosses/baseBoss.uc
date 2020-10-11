//================================================================================
// baseBoss.
//================================================================================

class baseBoss extends HChar;

var Sound peevesVoice;
var int iNumHits;
var() int iNumHitsToBeat;
var() name TrigEventWhenDefeated;
var() name TrigEventWhenVictor;
var() name TrigEventWhenDefeated2;
var() name TrigEventWhenVictor2;
var(Movement) float GroundSpeedEnd;
var() name CamStateName;
var bool bShowBossHealth;

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  if ( bCollideActors && bBlockActors && bBlockPlayers )
  {
    SetCollision(True,True,True);
  }
}

function StartBossEncounter ()
{
  Health = 100;
}

function float GetHealth ()
{
  return 1.0 - iNumHits / iNumHitsToBeat;
}

event TakeDamage (int Damage, Pawn EventInstigator, Vector HitLocation, Vector Momentum, name DamageType)
{
}

function SendDefeatedTrigger ()
{
  if ( TrigEventWhenDefeated != 'None' )
  {
    TriggerEvent(TrigEventWhenDefeated,self,self);
    PlayerHarry.ClientMessage("TrigEventWhenDefeated");
  }
}

function SendVictoriousTrigger ()
{
  if ( TrigEventWhenVictor != 'None' )
  {
    TriggerEvent(TrigEventWhenVictor,self,self);
    PlayerHarry.ClientMessage("TrigEventWhenVictor:" $ string(TrigEventWhenVictor));
    Log("TrigEventWhenVictor:" $ string(TrigEventWhenVictor));
  }
}

function SendDefeatedTrigger2 ()
{
  if ( TrigEventWhenDefeated2 != 'None' )
  {
    TriggerEvent(TrigEventWhenDefeated2,self,self);
    PlayerHarry.ClientMessage("TrigEventWhenDefeated2");
  }
}

function SendVictoriousTrigger2 ()
{
  if ( TrigEventWhenVictor2 != 'None' )
  {
    TriggerEvent(TrigEventWhenVictor2,self,self);
    PlayerHarry.ClientMessage("TrigEventWhenVictor2:" $ string(TrigEventWhenVictor2));
    Log("TrigEventWhenVictor2:" $ string(TrigEventWhenVictor2));
  }
}

function Vector GetCamTargetLoc ()
{
  return Location;
}

function Vector GetTargetLocation ()
{
  return Location;
}

function Vector GetHarryFaceLocation ()
{
  return Location;
}

function Vector GetHarryMovementCenter ()
{
  return Location;
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  GotoState('DoFlip');
}

function Rotator AdjustAim (float ProjSpeed, Vector projStart, int AimError, bool bLeadTarget, bool bWarnTarget)
{
  return Rotation;
}

function Rotator AdjustToss (float ProjSpeed, Vector projStart, int AimError, bool bLeadTarget, bool bWarnTarget)
{
  local Vector Loc;

  if ( self != PlayerHarry )
  {
    Loc = PlayerHarry.Location;
    Loc.Z -= 30;
    return rotator(Loc - Location);
  } else {
    return Rotation;
  }
}

function Vector GetCameraOffset ()
{
  return vect(0.00,0.00,0.00);
}

function name GetCamState ()
{
  return CamStateName;
}

state dieing
{
  function movearound ()
  {
    local Rotator Direction;
  
    Direction.Pitch = 0;
    Direction.Yaw = 2000;
    Direction.Roll = -400;
    DrawScale = DrawScale - 0.01;
    Direction.Yaw = Direction.Yaw + 100;
    Direction.Roll = Direction.Roll - 100;
    if ( DrawScale < 0 )
    {
      Destroy();
    }
  }
  
  function Tick (float DeltaTime)
  {
    movearound();
  }
  
  begin:
  
  spin:
    Sleep(1.5);
    goto ('spin');
}

function Vector AdjustAimLookAhead (Vector vTargetLoc, Vector vTargetVel, Vector vProjLoc, float fProjSpeed)
{
  local Vector Sn;
  local Vector PS;
  local float PSlen;
  local Vector PSn;
  local Vector Pn;
  local float Vs;
  local float A;
  local float B;
  local float C;
  local float t;

  Vs = VSize(vTargetVel);
  if ( Vs == 0 )
  {
    return Normal(vTargetLoc - vProjLoc);
  }
  Sn = vTargetVel / Vs;
  PS = vTargetLoc - vProjLoc;
  PSlen = VSize(PS);
  PSn = PS / PSlen;
  A = fProjSpeed * fProjSpeed - Vs * Vs;
  B = 2.0 * PSlen * Vs * (Sn Dot  -PSn);
  C =  -PSlen * PSlen;
  t = B * B - 4 * A * C;
  if ( t < 0 )
  {
    Log("******** AdjustAimLookAhead : Negative sqrt");
    return Sn;
  }
  t = Sqrt(t);
  if (  -B + t <= 0 )
  {
    Log("******** AdjustAimLookAhead : Negative Time");
  }
  t = ( -B + t) / 2 / A;
  if ( t == 0 )
  {
    Log("******** AdjustAimLookAhead : Final time is zero");
    return Sn;
  }
  Pn = (PS + Sn * Vs * t) / fProjSpeed * t;
  return Pn;
}

function TweakSetting (string S)
{
  PlayerHarry.ClientMessage("Boss unknown TweakSetting:" $ S);
}

function BeatBoss ()
{
}

function bool SetCamMode ()
{
  return False;
}

defaultproperties
{
    iNumHitsToBeat=4

    GroundSpeedEnd=250.00

    CamStateName="BossState"

    bShowBossHealth=True

    GroundSpeed=175.00

    AirSpeed=60.00

    AccelRate=4000.00

    MenuName="baseHalfoy"

    Mesh=SkeletalMesh'HPModels.skfirecrabMesh'
	
	DrawType=DT_Mesh
	
    DrawScale=2.00

    Mass=130.00
	
	Buoyancy=118.800003
	
	//RotationRate=18000
	RotationRate=(Pitch=4096,Yaw=50000,Roll=3072) //taken from the editor to remove "ImportText: Struct missing ('(')" UCC log warning -AdamJD
}
