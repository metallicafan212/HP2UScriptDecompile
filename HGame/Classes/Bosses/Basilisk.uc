//================================================================================
// Basilisk.
//================================================================================

class Basilisk extends baseBasilisk;

const HeadAttackCount_2= 4;
const HeadAttackCount= 6;
var BasiliskAnimChannel _AnimChannel;
var GenericColObj _BasiliskHeadColObj;
var GenericColObj _BasiliskHeadColObj2;
var GenericColObj _BasiliskBreastColObj;
var() float BreastHitDamageMult;
var HPawn _BlockPlayer;
var BasilEyeSmoke _BasilSmoke;
var bool bAnimDone;
var bool bIdleState;
var bool bDidFirstBattle;
var bool bTookFirstDeathBlow;
var bool bBasilFinishedForGood;
var ActorChaser aEyeTarget;
var bool bTriggerSelfAtStartup;
var name StateNameSave;
var int NumIdleLoops;
var bool bUseEyeBeam;
var float ActualYaw;
var float startYaw;
var float DesiredYaw;
var float YawTime;
var float YawTimeDest;
var float SlideDistance;
var float SlideSpeed;
var float CamXOffset;
var float CamZOffset;
var() float HeadYawRate;
var() float MaxHeadYaw;
var() float b1_TimeBetweenAttackStart;
var() float b1_TimeBetweenAttackEnd;
var() float b1_EyeShootWarningStart;
var float b1_EyeShootWarningEnd;
var SnakeBeam EyeBeam1;
var SnakeBeam EyeBeam2;
var float BeamGrowTime;
var float BeamGrowTimeSpan;
var float BeamLife;
var float BeamLifeSpan;
var int BeamYawRate_DegreesPerSec;
var int BeamYawStartOffset_Degrees;
var float BeamLength;
var float BeamHurtHarryTimer;
var() float BeamDamage;
var() float BeamChaseSpeed;
var() float BeamChaseAccel;
var() float AttackPeriod2;
var float AttackTimer;
var float HeadSpazSpeed;
var float HarryDamageTimer;
var() float HeadCollisionRadius;
var name MainBoneName;
var name WaitingState;
var name BasilNextState;
var float TempYawSave;
var float TempFloat;
var float TempFloat2;
var Sound tempSound;
var name TempName;
var bool TempBool;
var float LastAnimFrame;
var float TempHarryDist;
var int AttackAttemptCount;
var bool bEyeShootToggle;
var float HeadAttackNearest;
var float HeadAttackFarthest;
var() float HeadAttackAnimRate;
var() float b1_HeadRoarAnimRate_Start;
var() float b1_HeadRoarAnimRate_End;
var float HeadAttackNearest_2;
var float HeadAttackFarthest_2;
var() float b2_SprayWarningAnimRate;
var bool bGotHitDuringIdle;
var bool bGotHitDuringWarmUp;
var int AttackFromHolePart;
var() name HoleMarkerCommonTag;
var Vector vRoomCenter;
var Actor BasilStartPoint;
var int iLastHole;
var int NumHoles;
var Actor HoleMarker[4];
var int CurrentHole;
var bool bBasilCameOutFirstHoleAlready;
var() int OutHoleMaxRandYaw;
var() float BasilSniffDistance;
var bool bListenToHarry;
var bool bHaveHeardHarry;
var bool bAttackAfterBeingHit;
var baseSpell LastDodgedSpell;
var float SpellToHeadProximity;
var float FloorZ;
var float AcidSpitYawSpread;
var float AcidSpitYawRate;
var int AcidSpitCount;
var int AcidSpitCountTemp;
var float AcidSpitFreq;
var float AcidSpitPeriod;
var int AcidSpitCounter;
var float AcidSpitStartYaw;
var float AcidSpitStartYawStepSize;
var float AcidSpitTargetDistributionWidth;
var float AcidSpitChaseHarryYawStart;
var float AcidSpitChaseHarryYawSpread;
var float AcidSpitStartFrame;
var float AcidSpitEndFrame;
var float AcidSpitTimeSinceLastSpit;
var Actor AcidSpitLastActor;
var float BasilSoundRadius;
var float BasilSoundVolume;
var float SpellDamageAmount;
var float SpellInitialDrawScale;
var float SpellEndDrawScale;
var float SpellStartSpeed;
var float SpellEndSpeed;
var BasilEyeGlow EyeGlowL;
var BasilEyeGlow EyeGlowR;
var Vector LastNoiseLoc;
var float TimeSinceLastHearNoise;
var float HarryMakingNoiseTimer;
var float MinDamageToBotherBasil;
var int NumSpellsDodged;
var Actor aLastHole;

function PostBeginPlay ()
{
  local Actor A;
  local int I;

  Super.PostBeginPlay();
  WaitingState = 'stateWait1';
  _AnimChannel = BasiliskAnimChannel(CreateAnimChannel(Class'BasiliskAnimChannel',AT_Replace,MainBoneName));
  _AnimChannel._SetOwner(self);
  MakeBasilHeadObj();
  MakeBasilBreastObj();
  _BlockPlayer = Spawn(Class'HPawn');
  // _BlockPlayer.SetPhysics(0);
  _BlockPlayer.SetPhysics(Phys_None);
  _BlockPlayer.SetCollision(True,False,True);
  _BlockPlayer.SetCollisionSize(40.0,50.0);
  _BlockPlayer.bHidden = True;
  foreach AllActors(Class'Actor',A,'BasiliskFloorMarker')
  {
    // goto JL00B2;
	break;
  }
  FloorZ = A.Location.Z;
  foreach AllActors(Class'Actor',A,HoleMarkerCommonTag)
  {
    if ( VSize2D(A.Location - Location) < 70 )
    {
      BasilStartPoint = A;
    } //else {
    // }
  }
  AttackTimer = b1_TimeBetweenAttackStart;
  EyeGlowL = Spawn(Class'BasilEyeGlow',self);
  EyeGlowL.AttachToOwner('Bone144');
  EyeGlowL.EnableEmission(False);
  EyeGlowR = Spawn(Class'BasilEyeGlow',self);
  EyeGlowR.AttachToOwner('Bone118');
  EyeGlowR.EnableEmission(False);
  NumHoles = 4;
  // I = 0;
  for ( I = 0; I < NumHoles; I++ )
  {
    foreach AllActors(Class'Actor',A,name(string(HoleMarkerCommonTag) $ string(I)))
    {
      HoleMarker[I] = A;
      Log("************** hole:" $ string(A.Name));
    }
    // I++;
    // goto JL0194;
  }
  AcidSpitPeriod = 1.0 / AcidSpitFreq;
}

function MakeBasilHeadObj ()
{
  if ( _BasiliskHeadColObj == None )
  {
    _BasiliskHeadColObj = Spawn(Class'GenericColObj',self);
    _BasiliskHeadColObj.AttachToOwner('ani_Bone26');
    // _BasiliskHeadColObj.eVulnerableToSpell = 0;
	_BasiliskBreastColObj.eVulnerableToSpell = Spell_None;
    _BasiliskHeadColObj.bIsHead = True;
    _BasiliskHeadColObj.SetCollisionSize(HeadCollisionRadius * DrawScale * 0.5,HeadCollisionRadius * DrawScale);
  }
  if ( _BasiliskHeadColObj2 == None )
  {
    _BasiliskHeadColObj2 = Spawn(Class'GenericColObj',self);
    // _BasiliskHeadColObj2.eVulnerableToSpell = 0;
	_BasiliskBreastColObj.eVulnerableToSpell = Spell_None;
    _BasiliskHeadColObj2.bIsHead = True;
    _BasiliskHeadColObj2.SetCollisionSize(HeadCollisionRadius * DrawScale * 0.5,HeadCollisionRadius * DrawScale);
  }
}

function MakeBasilBreastObj ()
{
  if ( _BasiliskBreastColObj == None )
  {
    _BasiliskBreastColObj = Spawn(Class'GenericColObj',self);
    _BasiliskBreastColObj.AttachToOwner('Bone17');
    // _BasiliskBreastColObj.eVulnerableToSpell = 0;
	_BasiliskBreastColObj.eVulnerableToSpell = Spell_None;
    _BasiliskBreastColObj.SetCollisionSize(HeadCollisionRadius * DrawScale * 0.5,HeadCollisionRadius * DrawScale);
  }
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  if ( bBasilFinishedForGood )
  {
    return;
  }
  PlayerHarry.ClientMessage("Basil got triggered");
  if (  !bIdleState )
  {
    bDidFirstBattle = True;
  }
  bIdleState =  !bIdleState;
  if ( bIdleState )
  {
    GotoState('stateIdle');
  } else {
    PlayerHarry.HearHarryRecipient = self;
    if (  !bDidFirstBattle )
    {
      GotoState('stateInitBasil1');
    } else {
      GotoState('stateInitBasil2');
    }
  }
}

function Vector GetCamTargetLoc ()
{
  local Vector V;
  local Vector v1;
  local Vector v2;
  local Vector vH;
  local Vector vLoc;

  if (  !bDidFirstBattle )
  {
    V = Location + (Vec(CamXOffset,0.0,CamZOffset) * DrawScale >> Rotation);
    vH = PlayerHarry.Location + Vec(0.0,0.0,PlayerHarry.EyeHeight);
    vLoc = V;
  } else {
    vLoc = Location * vect(1.00,1.00,0.00) + Vec(0.0,0.0,FloorZ + 50);
  }
  return vLoc;
}

function Vector GetTargetLocation ()
{
  local Vector V;
  local float f;

  f = 15.0;
  if (  !bDidFirstBattle )
  {
    V = _BasiliskHeadColObj.Location + Vec(RandRange( -f,f),RandRange( -f,f),RandRange( -f,f));
  } else {
    if ( bHidden )
    {
      V = Location * vect(1.00,1.00,0.00) + Vec(0.0,0.0,FloorZ + 70) + Vec(RandRange( -f,f),RandRange( -f,f),RandRange( -f,f));
    } else {
      V = _BasiliskHeadColObj.Location * vect(1.00,1.00,0.00) + Vec(0.0,0.0,FloorZ + 70) + Vec(RandRange( -f,f),RandRange( -f,f),RandRange( -f / 4,f / 4));
    }
  }
  return V;
}

function Vector GetHarryFaceLocation ()
{
  if (  !bDidFirstBattle )
  {
    return _BasiliskHeadColObj.Location;
  } else {
    return Location * vect(1.00,1.00,0.00) + Vec(0.0,0.0,FloorZ + 70);
  }
}

function Vector GetHarryMovementCenter ()
{
  return Location * vect(1.00,1.00,0.00) + Vec(0.0,0.0,FloorZ + 50);
}

function bool SetCamMode ()
{
  PlayerHarry.Cam.rDestRotation = rotator(Normal((Location - PlayerHarry.Location) * vect(1.00,1.00,0.00)));
  return True;
}

function SnakePlayAnim (name Sequence, optional float Rate, optional float TweenTime, optional EAnimType Type, optional name RootBone)
{
  _AnimChannel.bAnimDone = False;
  if ( Rate == 0 )
  {
    Rate = 1.0;
  }
  _AnimChannel.PlayAnim(Sequence,Rate,TweenTime,Type,RootBone);
}

function SnakeLoopAnim (name Sequence, optional float Rate, optional float TweenTime, optional float MinRate, optional EAnimType Type, optional name RootBone)
{
  _AnimChannel.bAnimDone = False;
  if ( Rate == 0 )
  {
    Rate = 1.0;
  }
  _AnimChannel.LoopAnim(Sequence,Rate,TweenTime,MinRate,Type,RootBone);
}

function float GetHealth ()
{
	// return byte (Health) / 100; 
  return float (Health) / 100; //this is a return float -AdamJD
}

function bool BasilAcksHit (baseSpell spell)
{
  return True;
}

function float GetBasilDamageScalar ()
{
  return 1.0;
}

function bool ShouldDodgeSpell ()
{
  return VSize2D(PlayerHarry.Location - Location) > 200;
}

function BasilMunchesHarry ()
{
}

function SaveCurrentStateName ()
{
  StateNameSave = GetStateName();
}

auto state StateStartup
{
 begin:
  if ( bTriggerSelfAtStartup )
  {
    bTriggerSelfAtStartup = False;
    Trigger(None,None);
    PlayerHarry.bFraserMode = True;
  }
  PlayAnim('birth',0.0);
  Sleep(2.0);
  goto ('Begin');
}

state stateIdle //extends stateIdle
{
begin:
  Sleep(2.0);
}

state stateHidden
{
  function BeginState ()
  {
    HideBasil();
  }
  
 begin:
  Sleep(2.0);
}

function PawnHearHarryNoise ()
{
  if ( bListenToHarry )
  {
    bHaveHeardHarry = True;
    LastNoiseLoc = PlayerHarry.Location;
    TimeSinceLastHearNoise = 0.0;
  }
}

function HideBasil ()
{
  PlayAnim('birth',0.0);
  SetLocation(Location + vect(0.00,0.00,-1000.00));
  bHidden = True;
  _BasilSmoke.bEmit = False;
}

function RotateTo (float Yaw, optional float Time, optional float Rate)
{
  DesiredYaw = Yaw;
  if ( DesiredYaw <  -MaxHeadYaw )
  {
    DesiredYaw =  -MaxHeadYaw;
  } else {
    if ( DesiredYaw > MaxHeadYaw )
    {
      DesiredYaw = MaxHeadYaw;
    }
  }
  startYaw = ActualYaw;
  YawTime = 0.0;
  if ( Time != 0 )
  {
    YawTimeDest = Time;
  } else {
    if ( Rate != 0 )
    {
      YawTimeDest = Abs(DesiredYaw - startYaw) / Rate;
    } else {
      YawTimeDest = Abs(DesiredYaw - startYaw) / HeadYawRate;
    }
  }
}

function RotateToHarry (optional float Time, optional float Rate)
{
  RotateTo(DegreeRotToHarry(),Time,Rate);
}

function float DegreeRotToHarry (optional bool bReturnAsYaw)
{
  return DegreeRotToActor(PlayerHarry,bReturnAsYaw);
}

function float DegreeRotToActor (Actor A, optional bool bReturnAsYaw)
{
  local int YawToHarry;
  local Vector SnakeLoc;
  local float DegToHarry;

  SnakeLoc = Location + vector(Rotation) * 36;
  if ( bReturnAsYaw )
  {
    return rotator((A.Location - SnakeLoc) * vect(1.00,1.00,0.00)).Yaw & 65535;
  }
  YawToHarry = rotator((A.Location - SnakeLoc) * vect(1.00,1.00,0.00)).Yaw - Rotation.Yaw + 131072 & 65535;
  if ( YawToHarry >= 32768 )
  {
    YawToHarry -= 65536;
  }
  DegToHarry = YawToHarry * 360.0 / 65536;
  return DegToHarry;
}

function Tick (float dtime)
{
  local baseSpell A;
  local float D;
  local Vector V;
  local Vector v2;
  local float theta;
  local Rotator R;

  if ( bIdleState )
  {
    return;
  }
  R = BoneRot('ani_Bone26');
  _BasiliskHeadColObj2.MoveSmooth(_BasiliskHeadColObj.Location + vector(R) * 60 - _BasiliskHeadColObj2.Location);
  TimeSinceLastHearNoise += dtime;
  if ( TimeSinceLastHearNoise < 0.69999999 )
  {
    HarryMakingNoiseTimer += dtime;
  } else {
    HarryMakingNoiseTimer = 0.0;
  }
  if ( bRotateToDesired && (HarryMakingNoiseTimer > 0) )
  {
    DesiredRotation = rotator((LastNoiseLoc - Location) * vect(1.00,1.00,0.00));
  }
  if (  !bDidFirstBattle )
  {
    if ( YawTime < YawTimeDest )
    {
      YawTime += dtime;
      if ( YawTime > YawTimeDest )
      {
        YawTime = YawTimeDest;
      }
      ActualYaw = startYaw + (DesiredYaw - startYaw) * EaseBetween(YawTime / YawTimeDest);
    } else {
      ActualYaw = DesiredYaw;
    }
    AnimFrame = FClamp((ActualYaw + 90.0) / 180.0 * 0.9671,0.0,0.9671);
  } else {
    if ( ShouldDodgeSpell() )
    {
      A = baseWand(PlayerHarry.Weapon).LastCastedSpell;
      if ( (A != None) && (A != LastDodgedSpell) )
      {
        V = baseWand(PlayerHarry.Weapon).LastCastedSpell.Location - _BasiliskHeadColObj.Location;
        D = VSize(V);
        if ( D < 350 )
        {
          theta = Atan(SpellToHeadProximity / D);
          v2 = Normal(baseWand(PlayerHarry.Weapon).LastCastedSpell.Velocity) Cross V / D;
          if ( VSize(v2) < Sin(theta) )
          {
            LastDodgedSpell = A;
            SaveCurrentStateName();
            if ( v2.Z > 0 )
            {
              GotoState('stateDodgeSpell_L');
            } else {
              GotoState('stateDodgeSpell_R');
            }
          }
        }
      }
    }
  }
  if ( PlayerHarry.PlayerIsAiming() )
  {
    PawnHearHarryNoise();
  }
  AttackTimer -= dtime;
  HarryDamageTimer += dtime;
  LastAnimFrame = AnimFrame;
}

function RealAnimEnd ()
{
}

state stateInitBasil1
{
  function BeginState ()
  {
    local BlockPlayer A;
  
    foreach AllActors(Class'BlockPlayer',A)
    {
      if ( VSize(A.Location - PlayerHarry.Location) < 800 )
      {
        A.SetCollision(,,True);
      }
    }
  }
  
 begin:
  PlayAnim('orient');
  AnimFrame = 0.5;
  AnimRate = 0.0;
  SnakePlayAnim('birth');
  FinishAnim();
  AttackTimer = 3.5;
  BasilNextState = 'stateWait1';
  WaitingState = 'stateWait1';
  GotoState(WaitingState);
}

state stateWait1
{
  //UTPT added this for some reason -AdamJD
  // ignores  BasilHitBySpell;
  
  function EndState ()
  {
    SetTimer(0.0,False);
  }
  
  //UTPT didn't add this -AdamJD
  function BasilHitBySpell( baseSpell spell, vector HitLocation )
  {
	Global.BasilHitBySpell( spell, HitLocation );
	bGotHitDuringIdle = true;
	AttackTimer = 0;
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    if ( spell.Damage >= MinDamageToBotherBasil )
    {
      return True;
    } else {
      return False;
    }
  }
  
 begin:
  bGotHitDuringIdle = False;
  AttackAttemptCount = 0;
  if ( bUseEyeBeam )
  {
    GotoState('stateEyeSpell');
  }
  /*
  SnakeLoopAnim('Idle',RandRange(0.5,0.69999999),0.69999999);
  RotateToHarry(,40.0);
  Sleep(0.01);
  if (! ActualYaw == DesiredYaw ) goto JL0048;
  if (! AttackTimer <= byte(0) ) goto JL001F;
  RotateToHarry(,120.0);
  */
  //dos and untils -AdamJD
  do
  {
	  SnakeLoopAnim('Idle',RandRange(0.5,0.69999999),0.69999999);
	  RotateToHarry(,40.0);
	  do 
	  {
		Sleep(0.01);
	  }
	  until (ActualYaw == DesiredYaw);
  }
  until (AttackTimer <= 0);
  
  RotateToHarry(,120.0);
  
// JL0077:
  // Sleep(0.01);
  // if (! ActualYaw == DesiredYaw ) goto JL0077;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until (ActualYaw == DesiredYaw);

  if ( VSize2D(PlayerHarry.Location - Location) < HeadAttackFarthest + 20 )
  {
    PlayerHarry.ClientMessage("Harry in range for lunge");
    bGotHitDuringWarmUp = False;
    AttackAttemptCount = 0;
    GotoState('stateAttack');
  } else {
    GotoState('stateAcidSpit1');
  }
  goto ('Begin');
}

state stateAcidSpit1
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function BeginState ()
  {
    AcidSpitTimeSinceLastSpit = AcidSpitPeriod;
  }
  
  //UTPT didn't add this... -AdamJD
  function Tick(float dtime)
  {
	Global.Tick(dtime);

	if(   _AnimChannel.AnimSequence == 'Spit'
		  && _AnimChannel.AnimFrame >= 10.0/ 46.0  &&  _AnimChannel.AnimFrame <= 38.0/ 46.0
	  )
	{
		AcidSpitTimeSinceLastSpit += dtime;
		if( AcidSpitTimeSinceLastSpit >= AcidSpitPeriod )
		{
			while( AcidSpitTimeSinceLastSpit >= AcidSpitPeriod )
			{
				AcidSpitTimeSinceLastSpit -= AcidSpitPeriod;
			}
			
			CastSpitSpell(true, true);
		}
	}
		RotateToHarry();
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return True;
  }
  
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
 begin:
  SnakePlayAnim('spit',0.75,0.5);
  // if (  !_AnimChannel.bAnimDone )
  while (  !_AnimChannel.bAnimDone ) //while loop -AdamJD
  {
    Sleep(0.01);
    // goto JL0015;
  }
  SetAttackTimer();
  GotoState(WaitingState);
}

state stateInitBasil2
{
begin:
  PlayerHarry.StartBossEncounter(self,False,False,False,True,vect(0.00,0.00,0.00),Spell_None,False,False);
  bRotateToDesired = True;
  // SetPhysics(5);
  SetPhysics(Phys_Rotating);
  HideBasil();
  MakeSmokeEyeEffects();
  WaitingState = 'stateWait2';
  BasilNextState = 'stateRetreat';
  GotoState(WaitingState);
}

function MakeSmokeEyeEffects ()
{
  _BasilSmoke = Spawn(Class'BasilEyeSmoke');
  _BasilSmoke.bEmit = False;
}

state stateWait2
{
begin:
  SetAttackTimer();
  bListenToHarry = True;
  NumSpellsDodged = 0;
  PlayerHarry.PlaySound(Sound'BasilAttackWarning00',Slot_None,BasilSoundVolume,,BasilSoundRadius,0.75);
  TempFloat = GetSoundDuration(Sound'BOW_taunt9') / 0.31;
  PlayerHarry.PlaySound(Sound'BOW_taunt9',Slot_None,BasilSoundVolume,,BasilSoundRadius,0.31);
  Sleep(TempFloat - 0.5);
  TempFloat = GetSoundDuration(Sound'BOW_taunt1') / 0.62;
  PlayerHarry.PlaySound(Sound'BOW_taunt1',Slot_None,BasilSoundVolume,,BasilSoundRadius,0.62);
  Sleep(TempFloat - 0.75);
  MoveToNewHole();
  if ( FindClosestGrate() != None )
  {
    FindClosestGrate().OnEvent('rattle');
    PlayerHarry.ShakeView(0.5,50.0,50.0);
    FindClosestGrate().PlaySound(Sound'floor_grate_warning_rattle',Slot_None,BasilSoundVolume,,BasilSoundRadius,0.89999998);
    Sleep(1.0);
  }
  GotoState('stateComeOutAndSniff1');
}

state stateComeOutAndSniff1
{
  //UTPT added this for some reason
  // ignores  ShouldDodgeSpell;
  
  //UTPT didn't add this... -AdamJD
  function bool ShouldDodgeSpell() 
  { 
    return Global.ShouldDodgeSpell()  &&  AnimFrame >= 5.0/ 85.0; 
  }
  
  function float GetBasilDamageScalar ()
  {
    return 1.0;
  }
  
  function BeginState ()
  {
    bHidden = False;
    bHaveHeardHarry = False;
    bAttackAfterBeingHit = True;
  }
  
 begin:
  if ( BustOffTheGrate() )
  {
    PlayerHarry.ShakeView(1.5,150.0,150.0);
  } else {
    PlayerHarry.ShakeView(0.75,50.0,50.0);
  }
  PlayAnim('OutHole',0.81);
  _BasiliskHeadColObj.PlaySound(Sound'BAS_OutHole',Slot_None,BasilSoundVolume,False,BasilSoundRadius,RandRange(0.81,1.0));
  FinishAnim();
  GotoState('ComeOutAndSniff1a');
}

state ComeOutAndSniff1a
{
 begin:
  if ( bHaveHeardHarry )
  {
    bAttackAfterBeingHit = False;
    GotoState('stateAttackFromHole');
  }
 
  GotoState('stateComeOutAndSniff2');
}

state stateComeOutAndSniff2
{
  //UTPT added this for some reason -AdamJD
  // ignores  PawnHearHarryNoise;
  
  function Timer ()
  {
    if ( VSize2D(PlayerHarry.Location - _BasiliskHeadColObj.Location) < BasilSniffDistance )
    {
      bAttackAfterBeingHit = False;
      GotoState('stateAttackFromHole');
    }
  }
  
  function EndState ()
  {
    SetTimer(0.0,False);
  }
  
  //UTPT didn't add this... -AdamJD
  function PawnHearHarryNoise()
  {
	Global.PawnHearHarryNoise();
	bAttackAfterBeingHit = false;
	GotoState('stateAttackFromHole');
  }
  
  function float GetBasilDamageScalar ()
  {
    return 1.0;
  }
  
 begin:
  SetTimer(0.25,True);
  PlayAnim('sniff',1.0,0.2);
  switch (Rand(3))
  {
    case 0:
    _BasiliskHeadColObj.PlaySound(Sound'Basilisk_sniff1',Slot_None,,False,BasilSoundRadius,RandRange(0.81,1.0));
    break;
    case 1:
    _BasiliskHeadColObj.PlaySound(Sound'Basilisk_sniff2',Slot_None,,False,BasilSoundRadius,RandRange(0.81,1.0));
    break;
    case 2:
    _BasiliskHeadColObj.PlaySound(Sound'Basilisk_sniff3',Slot_None,,False,BasilSoundRadius,RandRange(0.81,1.0));
    break;
    default:
  }
  FinishAnim();
  GotoState('stateComeOutAndSniff3');
}

state stateComeOutAndSniff3
{
begin:
  PlayAnim('GoBack',1.0,0.2);
  FinishAnim();
  SetAttackTimer();
  HideBasil();
  GotoState(WaitingState);
}

function DoAttack2 ()
{
  bListenToHarry = False;
  if ( (PlayerHarry.Difficulty > 0) && (VSize2D(PlayerHarry.Location - Location) < HeadAttackFarthest_2 + 20) )
  {
    GotoState('stateAttack_2_');
  } else {
    GotoState('stateAcidSpit');
  }
}

state stateAttackFromHole
{
  //UTPT added this for some reason -AdamJD
  // ignores  BasilHitBySpell;
  
  function BeginState ()
  {
    bGotHitDuringWarmUp = False;
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
  //UTPT didn't add this... -AdamJD
  function BasilHitBySpell( baseSpell spell, vector HitLocation )
  {
	Global.BasilHitBySpell( spell, HitLocation );
	if( spell.Damage >= MinDamageToBotherBasil )
	{
		bGotHitDuringWarmUp = true;
		GotoState('stateHitThenAttack_2_');
	}
  }
  
 begin:
  PlayAnim('Hiss',1.0,0.2);
  PlayerHarry.ShakeView(1.5,50.0,50.0);
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_scream_blinded',Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.89999998,1.12));
  FinishAnim();
  DoAttack2();
}

state stateHitThenAttack_2_
{
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
 begin:
  PlayAnim('Hiss',b2_SprayWarningAnimRate,1.0);
  PlayerHarry.ShakeView(1.5,50.0,50.0);
  FinishAnim();
  DoAttack2();
}

state stateAttack_2_
{
  //UTPT added this for some reason -AdamJD
  // ignores  BasilHitBySpell;
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
  //UTPT didn't add this... -AdamJD
  function BasilHitBySpell( baseSpell spell, vector HitLocation )
  {
	Global.BasilHitBySpell( spell, HitLocation );
	if( spell.Damage >= MinDamageToBotherBasil )
	{
		bGotHitDuringWarmUp = true;
	}
 }
  
  function BasilMunchesHarry ()
  {
    if ( bGotHitDuringWarmUp )
    {
      GotoState('stateHit_2_');
    }
  }
  
 begin:
  /*
  if ( bGotHitDuringWarmUp )
  {
    PlayerHarry.ClientMessage("####      Miss Harry");
    DesiredRotation.Yaw = byte(rotator(PlayerHarry.Location - Location).Yaw) + DegRotAwayFromHarry(True) * 65536.0 / 360.0 = } else {;
    PlayerHarry.ClientMessage("#### DONT Miss Harry");
    if ( VSize(PlayerHarry.Velocity) <= byte(20) )
    {
      DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
    } else {
      DesiredRotation.Yaw = byte(rotator(PlayerHarry.Location - Location).Yaw) - DegRotAwayFromHarry() * 65536.0 / 360.0 = bGotHitDuringWarmUp = False;
      // There are 2 jump destination(s) inside the last statement!
    }
  }
  */
  if ( bGotHitDuringWarmUp )
  {
    PlayerHarry.ClientMessage("####      Miss Harry");
    DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw + DegRotAwayFromHarry(True) * 65536.0 / 360.0;
  }
  else 
  {
    PlayerHarry.ClientMessage("#### DONT Miss Harry");
    if ( VSize(PlayerHarry.Velocity) <= 20 )
    {
      DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
    } else {
      DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw - DegRotAwayFromHarry() * 65536.0 / 360.0; 
	  bGotHitDuringWarmUp = False;
	}
  }
  PlayLungeAnim_2_();
  PlayerHarry.ShakeView(0.5,100.0,100.0);
  PlayLungeSound();
  FinishAnim();
  PlayAnim('GoBack',1.0,0.1);
  FinishAnim();
  SetAttackTimer();
  HideBasil();
  GotoState(WaitingState);
}

function PlayLungeAnim_2_ ()
{
  local int I;
  local int W;

  W = (HeadAttackFarthest_2 - HeadAttackNearest_2) /*UTPT didn't add this bit... -AdamJD*/ / (HeadAttackCount_2 - 1);
  I = ( VSize2D(playerHarry.Location - Location) - HeadAttackNearest_2 + w/2 + w/4) / w;  //UTPT didn't add this... -AdamJD
  I = Clamp( I, 0, HeadAttackCount_2 - 1 ); //UTPT didn't add this... -AdamJD
  PlayAnim(name("snap" $ string(I + 1)),HeadAttackAnimRate,0.2);
}

state stateAcidSpit
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function BeginState ()
  {
    AcidSpitTimeSinceLastSpit = AcidSpitPeriod;
  }
  
  //UTPT didn't add this... -AdamJD
  function Tick(float dtime)
  {
	Global.Tick(dtime);

	if(   AnimSequence == 'Spray'
		  && AnimFrame >= AcidSpitStartFrame  &&  AnimFrame <= AcidSpitEndFrame
	  )
	{
		AcidSpitTimeSinceLastSpit += dtime;
		if( AcidSpitTimeSinceLastSpit >= AcidSpitPeriod )
		{
			while( AcidSpitTimeSinceLastSpit >= AcidSpitPeriod )
			{
				AcidSpitTimeSinceLastSpit -= AcidSpitPeriod;
			}
			CastSpitSpell(true, true);
		}
	}

	DesiredRotation.Yaw = DegreeRotToHarry(true);
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return True;
  }
  
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
 begin:
  AcidSpitStartFrame = 18.0 / 61.0;
  AcidSpitEndFrame = 53.0 / 61.0;
  AcidSpitChaseHarryYawStart = rotator(PlayerHarry.Location - Location).Yaw - AcidSpitChaseHarryYawSpread / 2;
  LoopAnim('Spray',0.75,0.5);
  FinishAnim();
  PlayAnim('GoBack',1.0,0.5);
  FinishAnim();
  SetAttackTimer();
  HideBasil();
  GotoState(WaitingState);
}

function CastSpitSpell (bool bAimAtHarry, optional bool bUseHeadYaw)
{
  local spellAcidSpit A;
  local Vector V;
  local Rotator R;
  local float M;
  local float Dist2D;
  local float DistributionAngle;
  local float fTimeToHit;

  if ( bAimAtHarry )
  {
    Dist2D = VSize2D(_BasiliskHeadColObj.Location - PlayerHarry.Location);
    Dist2D = FMax(0.01,Dist2D);
    R.Yaw = AcidSpitChaseHarryYawStart + AcidSpitChaseHarryYawSpread * (AnimFrame - AcidSpitStartFrame) / (AcidSpitEndFrame - AcidSpitStartFrame);
	V = _BasiliskHeadColObj.Location + vector(R) * Dist2D;
    V.Z = FloorZ;
    fTimeToHit = 1.29999995;
    if ( PlayerHarry.Difficulty == 1 )
    {
      fTimeToHit = 0.5;
    } else {
      if ( PlayerHarry.Difficulty == 2 )
      {
        fTimeToHit = 0.181;
      }
    }
    V = ComputeTrajectoryByTime(_BasiliskHeadColObj.Location,PlayerHarry.Location,fTimeToHit,-200.0);
    R = rotator(V);
    A = Spawn(Class'spellAcidSpit',,,_BasiliskHeadColObj.Location,R);
    V.Z += 40 * Cos(8.0 * Level.TimeSeconds);
    A.Velocity = V;
  } else {
    R = _BasiliskHeadColObj.Rotation;
    A = Spawn(Class'spellAcidSpit',,,_BasiliskHeadColObj.Location,R);
  }
  Log("*********** spawned spit:" $ string(A.Name) $ " v:" $ string(V) $ " grav:" $ string(Region.Zone.ZoneGravity.Z));
  A.FloorZ = FloorZ;
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_spit_acid',,BasilSoundVolume,,BasilSoundRadius,RandRange(0.81,1.25));
  A.PlaySound(Sound'Basilisk_spit_acid2',,BasilSoundVolume,,BasilSoundRadius,RandRange(0.81,1.25));
  if (  !bDidFirstBattle )
  {
    A.fPoolShrinkTimeMult = 0.2;
  }
}

state stateDodgeSpell_L
{
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
  function SaveCurrentStateName ()
  {
  }
  
  function BeginState ()
  {
    PlayAnim('LeanLeft',1.0,0.5);
    GotoState('stateDodgeSpell');
  }
  
}

state stateDodgeSpell_R
{
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
  function SaveCurrentStateName ()
  {
  }
  
  function BeginState ()
  {
    PlayAnim('LeanRight',1.0,0.5);
    GotoState('stateDodgeSpell');
  }
  
}

state stateDodgeSpell
{
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
  function SaveCurrentStateName ()
  {
  }
  
 begin:
  FinishAnim();
  NumSpellsDodged++;
  if ( NumSpellsDodged >= 1 + Rand(2) )
  {
    PlayAnim('GoBack',1.0,0.1);
    FinishAnim();
    SetAttackTimer();
    HideBasil();
    GotoState(WaitingState);
  } else {
    GotoState(StateNameSave);
  }
}

function bool BustOffTheGrate ()
{
  local Actor A;

  A = FindClosestGrate();
  if ( A != None )
  {
    A.PlaySound(Sound'floor_grate_explode_open',Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.89999998,1.12));
    A.Trigger(self,self);
    return True;
  }
  return False;
}

function CHGrate FindClosestGrate ()
{
  local CHGrate A;

  foreach AllActors(Class'CHGrate',A)
  {
    if ( VSize2D(A.Location - Location) < 64 )
    {
      if (  !A.IsInState('OpenUp') )
      {
        return A;
      }
    }
  }
  return None;
}

function float PlayMovingThroughWallSound (optional float Volume, optional bool bPlayFromHarry)
{
  local Sound snd;
  local float Pitch;
  local Actor A;

  if ( bPlayFromHarry )
  {
    A = PlayerHarry;
  } else {
    A = self;
  }
  switch (Rand(5))
  {
    case 0:
    snd = Sound'Basilisk_hiss_long1';
    break;
    case 1:
    snd = Sound'Basilisk_hiss_long2';
    break;
    case 2:
    snd = Sound'Basilisk_hiss_long3';
    break;
    default:
  }
  if ( Volume == 0 )
  {
    Volume = RandRange(0.81,1.0);
  }
  Pitch = RandRange(0.81,1.0);
  A.PlaySound(snd,Slot_None,Volume * BasilSoundVolume,False,BasilSoundRadius,Pitch);
  return GetSoundDuration(snd) / Pitch - 0.5;
}

function float PlayAboutToAttackSound ()
{
  local float Pitch;
  local Sound snd;

  snd = Sound'BasilAttackWarning00';
  Pitch = RandRange(0.81,1.0);
  PlaySound(snd,Slot_None,RandRange(0.62,1.0) * BasilSoundVolume,False,BasilSoundRadius,Pitch);
  return GetSoundDuration(snd) / Pitch;
}

function MoveToNewHole ()
{
  local int NumVisibleHoles;
  local Vector vDir;
  local Actor A;
  local float ClosestHoleDist;
  local int iClosestHole;
  local int I;
  local Rotator R;

  if ( bTookFirstDeathBlow )
  {
    iClosestHole = 1;
  } else {
    ClosestHoleDist = 1000000.0;
    // I = 0;
	//a for loop -AdamJD
    for ( I = 0;  I < NumHoles; I++ )
    {
      if ( (HoleMarker[I] != aLastHole) && (VSize2D(HoleMarker[I].Location - PlayerHarry.Location) < ClosestHoleDist) )
      {
        ClosestHoleDist = VSize2D(HoleMarker[I].Location - PlayerHarry.Location);
        iClosestHole = I;
      }
      // I++;
      // goto JL0025;
    }
  }
  aLastHole = HoleMarker[iClosestHole];
  CurrentHole = iClosestHole;
  SetLocation(HoleMarker[CurrentHole].Location);
  R = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00));
  R.Yaw += RandRange( -OutHoleMaxRandYaw, OutHoleMaxRandYaw );
  DesiredRotation = R;
  PlayerHarry.ClientMessage("Basil moved to hole:" $ string(CurrentHole));
  _BlockPlayer.SetLocation2(HoleMarker[CurrentHole].Location + vect(0.00,0.00,100.00));
  _BasilSmoke.SetLocation(HoleMarker[CurrentHole].Location + vect(0.00,0.00,10.00));
  _BasilSmoke.bEmit = True;
}

state stateSpaz
{
begin:
  TempYawSave = ActualYaw;
  if ( ActualYaw < 0 )
  {
    PlayHissSound();
    RotateTo(110.0,,HeadSpazSpeed);
    // Sleep(0.01);
    // if (! ActualYaw == DesiredYaw ) goto JL002E;
	
	//do and until -AdamJD
	do
	{
		Sleep(0.01);
	}
	until (ActualYaw == DesiredYaw);
	
    PlayHissSound();
    RotateTo(-110.0,,HeadSpazSpeed);
    // Sleep(0.01);
    // if (! ActualYaw == DesiredYaw ) goto JL005C;
	
	//do and until -AdamJD
	do
	{
		Sleep(0.01);
	}
	until (ActualYaw == DesiredYaw);
  } else {
    PlayHissSound();
    RotateTo(-110.0,,HeadSpazSpeed);
    // Sleep(0.01);
    // if (! ActualYaw == DesiredYaw ) goto JL008D;
	
	//do and until -AdamJD
	do
	{
		Sleep(0.01);
	}
	until (ActualYaw == DesiredYaw);
	
    PlayHissSound();
    RotateTo(110.0,,HeadSpazSpeed);
    // Sleep(0.01);
    // if (! ActualYaw == DesiredYaw ) goto JL00BB;
	
	//do and until -AdamJD
	do
	{
		Sleep(0.01);
	}
	until (ActualYaw == DesiredYaw);
  }
  PlayHissSound();
  RotateTo(TempYawSave,,HeadSpazSpeed);
  // Sleep(0.01);
  // if (! ActualYaw == DesiredYaw ) goto JL00E9;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until (ActualYaw == DesiredYaw);
	
  SetAttackTimer();
  AttackTimer /= 2;
  GotoState(WaitingState);
}

function PlayHissSound ()
{
  local Sound snd;

  if ( bIdleState || bBasilFinishedForGood )
  {
    return;
  }
  switch (Rand(2))
  {
    case 0:
    snd = Sound'Basilisk_hiss_short1';
    break;
    case 1:
    snd = Sound'Basilisk_hiss_short2';
    break;
    default:
  }
  _BasiliskHeadColObj.PlaySound(snd,Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.81,1.25));
}

state stateEyeSpell
{
  //UTPT added this for some reason -AdamJD
  // ignores  BasilHitBySpell;
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  //UTPT didn't add this... -AdamJD
  function BasilHitBySpell( baseSpell spell, vector HitLocation )
  {
	Global.BasilHitBySpell( spell, HitLocation );
	if( AttackAttemptCount < 3 )
	{
		bGotHitDuringWarmUp = true;
		GotoState('stateHitThenEyeSpell');
	}
  }
  
  function BeginState ()
  {
    AttackAttemptCount++;
  }
  
 begin:
  SnakeLoopAnim('stare',1.0,1.0);
  TempFloat = b1_EyeShootWarningStart;
  EyeGlowL.Glow(TempFloat);
  EyeGlowR.Glow(TempFloat);
  switch (Rand(3))
  {
    case 0:
    _BasiliskHeadColObj.PlaySound(Sound'Basilisk_eyes_powerup1',Slot_None,BasilSoundVolume,,BasilSoundRadius);
    break;
    case 1:
    _BasiliskHeadColObj.PlaySound(Sound'Basilisk_eyes_powerup2',Slot_None,BasilSoundVolume,,BasilSoundRadius);
    break;
    case 2:
    _BasiliskHeadColObj.PlaySound(Sound'Basilisk_eyes_powerup3',Slot_None,BasilSoundVolume,,BasilSoundRadius);
    break;
    default:
  }
  AttackTimer = TempFloat / 2;
  RotateTo(DegreeRotToActor(aEyeTarget),,40.0);
  // Sleep(0.01);
// JL00D1:
  // if (! ActualYaw == DesiredYaw ) goto JL00E8;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until (ActualYaw == DesiredYaw);
  
  // if (! AttackTimer <= byte(0) ) goto JL00D1;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until (AttackTimer <= 0);

  GotoState('stateEyeSpellFire');
}

state stateHitThenEyeSpell
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  //UTPT didn't add this... -AdamJD
  function Tick(float dtime)
  {
	local rotator   r;
	local vector    v, n;
	local float     d;

	Global.Tick(dtime);

	if( EyeBeam1 == none )
	{
		return;
	}

	if( EyeBeam1.DrawScale > 0 )
	{
		EyeBeam1.DrawScale -= 0.666 * dtime;
		EyeBeam2.DrawScale -= 0.666 * dtime;

		if( EyeBeam1.DrawScale <= 0 )
		{
			StopEyeGlow();
		}
	}

	if( EyeBeam1 == none )  
	{
		return;
	}

	EyeBeam1.SetLocation( BonePos( 'Bone144' ) );
	EyeBeam2.SetLocation( BonePos( 'Bone118' ) );

	EyeBeam1.SetRotation( _BasiliskHeadColObj.rotation );
	EyeBeam2.SetRotation( _BasiliskHeadColObj.rotation );
  }
  
  function EndState ()
  {
    StopEyeGlow();
  }
  
 begin:
  EyeGlowL.Glow(0.0);
  EyeGlowR.Glow(0.0);
  SnakePlayAnim('InPain',0.75,1.0);
  PlayerHarry.ShakeView(1.5,100.0,100.0);
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_scream_death',Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.89999998,1.12));
  // Sleep(0.01);
  // if (! _AnimChannel.bAnimDone ) goto JL0086;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until (_AnimChannel.bAnimDone);
  
  if ( VSize2D(PlayerHarry.Location - Location) < HeadAttackFarthest + 20 )
  {
    PlayerHarry.ClientMessage("Harry in range for lunge  -  Hit then eye spell");
    bGotHitDuringWarmUp = False;
    AttackAttemptCount = 0;
    StopEyeGlow();
    GotoState('stateAttack');
  }
  GotoState('stateEyeSpell');
}

state stateEyeSpellFire
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick, BasilHitBySpell; 
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  //UTPT didn't add this... -AdamJD
  function Tick(float dtime)
  {
	local rotator   r;
	local vector    v, n;
	local float     d;
	local bool      bHarryInfrontOfBeamEnd;

	Global.Tick(dtime);

	if( EyeBeam1 == none )
	{
		return;
	}

	BeamHurtHarryTimer += dtime;

	if( BeamGrowTime < BeamGrowTimeSpan )
	{
		BeamGrowTime += dtime;
		
		if( BeamGrowTime >= BeamGrowTimeSpan )
		{
			BeamGrowTime = BeamGrowTimeSpan;
		}

		EyeBeam1.DrawScale = 2.0 * BeamGrowTime / BeamGrowTimeSpan;
		EyeBeam1.Wideness = FMin( 255.0, 128.0/EyeBeam1.DrawScale );
		EyeBeam2.DrawScale = EyeBeam1.DrawScale;
		EyeBeam2.Wideness = EyeBeam1.Wideness;
	}

	EyeBeam1.SetLocation( BonePos( 'Bone144' ) );
	EyeBeam2.SetLocation( BonePos( 'Bone118' ) );

	r.Yaw =   ActualYaw * 65536.0 / 360.0  +  Rotation.Yaw; 
	v = Location + vector(r) * TempHarryDist;
	v.Z = playerHarry.Location.Z;
	r.Pitch = rotator(v - EyeBeam1.Location).Pitch;
		
	r = rotator( aEyeTarget.Location - EyeBeam1.Location );

	EyeBeam1.SetRotation( r );
	EyeBeam2.SetRotation( r );
		
	if( BeamHurtHarryTimer > 0.5 )
	{
		d = VSize( playerHarry.Location - EyeBeam1.Location );
		d = d / BeamLength  *  playerHarry.CollisionRadius;
		n = vector(r);
		v = (playerHarry.Location - EyeBeam1.Location) Cross n;
		
		if( (n  Dot  (playerHarry.Location - n * BeamLength * EyeBeam1.DrawScale)) < 0 )
		{
			bHarryInfrontOfBeamEnd = true;
		}
		
		if( VSize(v) < d  &&  bHarryInfrontOfBeamEnd )
		{
			playerHarry.TakeDamage( BeamDamage, self, playerHarry.Location, vect(0,0,0), '');
			BeamHurtHarryTimer = 0;
		}
		
		else
		{
			v = (playerHarry.Location - EyeBeam2.Location) Cross n;
			
			if( VSize(v) < d  &&  bHarryInfrontOfBeamEnd )
			{
				playerHarry.TakeDamage( BeamDamage, self, playerHarry.Location, vect(0,0,0), '');
				BeamHurtHarryTimer = 0;
			}
		}
	}
  }
  
  //UTPT didn't add this... -AdamJD
  function BasilHitBySpell( baseSpell spell, vector HitLocation )
  {
	Global.BasilHitBySpell( spell, HitLocation );
	if( AttackAttemptCount < 3 )
	{
		bGotHitDuringWarmUp = true;
		GotoState('stateHitThenEyeSpell');
	}
  }
  
  function EndState ()
  {
    _BasiliskHeadColObj.StopSound(Sound'BAS_eye_beam_loop',SLOT_Interact,1.0);
  }
  
 begin:
  RotateTo(DegreeRotToActor(aEyeTarget),,40.0);
  EyeBeam1 = Spawn(Class'SnakeBeam',self,,BonePos('Bone144'));
  EyeBeam1.DrawScale = 0.0;
  EyeBeam2 = Spawn(Class'SnakeBeam',self,,BonePos('Bone118'));
  EyeBeam2.DrawScale = 0.0;
  BeamGrowTime = 0.01;
  BeamGrowTimeSpan = 0.5;
  BeamLife = 0.0;
  BeamHurtHarryTimer = 10000.0;
  _BasiliskHeadColObj.PlaySound(Sound'BAS_eye_beam_loop',SLOT_Interact,BasilSoundVolume,,BasilSoundRadius,,,True);
  /*
  SetAttackTimer();
  RotateTo(DegreeRotToActor(aEyeTarget),,40.0);
JL00BC:
  Sleep(0.01);
  if (! ActualYaw == DesiredYaw ) goto JL00D9;
  if (! AttackTimer <= byte(0) ) goto JL00C2;
JL00D9:
  */
  
  //dos and untils -AdamJD
  do
  {
	 SetAttackTimer();
	 
	 do
	 {
		RotateTo(DegreeRotToActor(aEyeTarget),,40.0);
		
		do
		{
			Sleep(0.01);
		}	
		until (AttackTimer <= 0);
	 }
	 
	  if ( VSize2D(PlayerHarry.Location - Location) < HeadAttackFarthest + 20 )
	  {
		PlayerHarry.ClientMessage("Harry in range for lunge  -  eye spell");
		bGotHitDuringWarmUp = False;
		AttackAttemptCount = 0;
		StopEyeGlow();
		GotoState('stateAttack');
	  }
  }
  // if (! False ) goto JL00BC;
  until (False);
  
  //UTPT didn't add these... -AdamJD
  //------------------------------------------------------------------------------------------------
  TempFloat = 0.25;

  TempFloat2 = DegreeRotToHarry();
  TempBool = TempFloat2 < 0;
  TempHarryDist = VSize2d( playerHarry.Location - Location );
	
  if( TempBool )
  {
	RotateTo( TempFloat2 + BeamYawStartOffset_Degrees * 0.5, TempFloat, 0 );
  }
  else
  {
	RotateTo( TempFloat2 - BeamYawStartOffset_Degrees * 0.5, TempFloat, 0 );
  }
	
  Sleep( TempFloat );
	
  if( TempBool )
  {
	RotateTo( TempFloat2 - BeamYawStartOffset_Degrees*1.5, 0, BeamYawRate_DegreesPerSec );
  }
  else
  {
	RotateTo( TempFloat2 + BeamYawStartOffset_Degrees*1.5, 0, BeamYawRate_DegreesPerSec );
  }
	
  Sleep( BeamLifeSpan );

  GotoState('stateEyeSpellFire');
  //------------------------------------------------------------------------------------------------
	
  SetAttackTimer();
  GotoState(WaitingState);
}

function StopEyeGlow ()
{
  if ( EyeBeam1 != None )
  {
    EyeBeam1.Destroy();
    EyeBeam2.Destroy();
    EyeBeam1 = None;
    EyeBeam2 = None;
  }
  EyeGlowL.Glow(0.0);
  EyeGlowR.Glow(0.0);
}

state stateAttack
{
  //UTPT added this for some reason -AdamJD
  // ignores  BasilHitBySpell;
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  //UTPT didn't add this... -AdamJD
  function BasilHitBySpell( baseSpell spell, vector HitLocation )
  {
	Global.BasilHitBySpell( spell, HitLocation );
	if(   spell.Damage >= MinDamageToBotherBasil
		  && AttackAttemptCount < 2
	   )
	{
		bGotHitDuringWarmUp = true;
		GotoState('stateHitThenAttack');
	}
  }

  function BeginState ()
  {
    AttackAttemptCount++;
  }
  
 begin:
  RotateToHarry(1.0);
  TempFloat = b1_HeadRoarAnimRate_Start + (b1_HeadRoarAnimRate_End - b1_HeadRoarAnimRate_Start) * (1.0 - Health / 100.0);
  SnakePlayAnim('Taunt',TempFloat,2.0);
  Sleep(0.2);
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_roar',Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.89999998,1.12));
  PlayerHarry.ShakeView(1.5,50.0,50.0);
  // Sleep(0.01);
// JL00A0:
  // if (! _AnimChannel.bAnimDone ) goto JL00A0;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until	(_AnimChannel.bAnimDone);
  
  GotoState('stateAttackLunge');
}

state stateHitThenAttack
{
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
 begin:
  SnakePlayAnim('InPain',0.75,1.0);
  PlayerHarry.ShakeView(1.5,75.0,75.0);
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_scream_death',Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.89999998,1.12));
  // Sleep(0.01);
  // if (! _AnimChannel.bAnimDone ) goto JL005E;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until	(_AnimChannel.bAnimDone);
  
  GotoState('stateAttackLunge');
}

state stateAttackLunge
{
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
 begin:
  if ( bGotHitDuringWarmUp &&  !bGotHitDuringIdle )
  {
    PlayerHarry.ClientMessage("Miss Harry");
    RotateTo(DegreeRotToHarry() + DegRotAwayFromHarry(True),0.2);
    PlayLungeAnim();
    PlayerHarry.ShakeView(0.5,50.0,50.0);
    PlayLungeSound();
  } else {
    PlayerHarry.ClientMessage("DONT Miss Harry");
    RotateToHarry(0.2);
    PlayLungeAnim();
    PlayerHarry.ShakeView(0.5,50.0,50.0);
    PlayLungeSound();
    Sleep(0.2);
    RotateToHarry(0.2);
  }
  // Sleep(0.01);
  // if (! _AnimChannel.bAnimDone ) goto JL00E0;
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until	(_AnimChannel.bAnimDone);
  
  SetAttackTimer();
  GotoState(WaitingState);
}

function float DegRotAwayFromHarry (optional bool bMissHarry)
{
  local float Z;

  Z = (Normal(PlayerHarry.Location - Location) Cross PlayerHarry.Velocity).Z;
  Z =  -Z * 0.05;
  if ( bMissHarry )
  {
    Z += (Rand(2) * 2 - 1) * 23.0;
  }
  return Z;
}

function bool AnimSequenceIsLunge ()
{
  local int I;
  local bool bWasLunge;

  return True;
  return False;
}

function PlayRoarSound ()
{
  local Sound snd;

}

function PlayLungeSound ()
{
  local Sound tempSound;

  switch (Rand(6))
  {
    case 0:
    tempSound = Sound'Basilisk_attack1';
    break;
    case 1:
    tempSound = Sound'Basilisk_attack2';
    break;
    case 2:
    tempSound = Sound'Basilisk_attack3';
    break;
    case 3:
    tempSound = Sound'Basilisk_attack4';
    break;
    case 4:
    tempSound = Sound'Basilisk_attack5';
    break;
    case 5:
    tempSound = Sound'Basilisk_attack6';
    break;
    default:
  }
  _BasiliskHeadColObj.PlaySound(tempSound,Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.81,1.25));
}

function PlayLungeAnim ()
{
  local int I;
  local int W;
  local name N;

  W = (HeadAttackFarthest - HeadAttackNearest) /*UTPT didn't add this bit... -AdamJD*/ / (HeadAttackCount - 1);
  I = ( VSize2D(playerHarry.Location - Location) - HeadAttackNearest + w/2 + w* 0.3) / w; //UTPT didn't add this... -AdamJD
  I = Clamp( I, 0, HeadAttackCount - 1 ); //UTPT didn't add this... -AdamJD
  N = name("lunge_" $ string(I + 1));
  PlayerHarry.ClientMessage("Play LungeAnim:" $ string(N));
  SnakePlayAnim(N,HeadAttackAnimRate,0.2);
}

function PlayLungeFromHoleAnim (int part)
{
  local int I;
  local int W;
  local string S;

  W = (HeadAttackFarthest - HeadAttackNearest);
  if ( part < 4 )
  {
    S = "snap_" $ string(I + 1) $ "_" $ string(part);
  } else {
    S = "roar_" $ string(I + 1);
  }
  SnakePlayAnim(name(S),HeadAttackAnimRate,0.2);
  PlayerHarry.ClientMessage("Attack anim:" $ S);
}

state statePodiumAttack
{
  function BeginState ()
  {
    local float deg;
  
    deg = DegreeRotToHarry();
    if ( deg < 0 )
    {
      SnakePlayAnim('LungeRight',HeadAttackAnimRate,0.2);
    } else {
      SnakePlayAnim('LungeLeft',HeadAttackAnimRate,0.2);
    }
  }
  
 begin:
  Sleep(2.0);
  GotoState(WaitingState);
}

state stateHit
{
  function BeginState ()
  {
    if ( bDidFirstBattle )
    {
      GotoState('stateHit_2_');
    }
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
 begin:
  AnimFrame = 0.0;
  SnakePlayAnim('InPain',0.75,1.0);
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_scream_death',Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.89999998,1.12));
  PlayerHarry.ShakeView(1.5,50.0,50.0);
  RotateTo(ActualYaw - 20,,160.0);
/*
JL007F:
  Sleep(0.01);
  if (! ActualYaw == DesiredYaw ) goto JL007F;
  TempFloat = 40.0;
  if ( Abs(TempFloat) > 1.125 )
  {
    RotateTo(ActualYaw + TempFloat,0.1);
    Sleep(0.01);
    if (! ActualYaw == DesiredYaw ) goto JL00C9;
    TempFloat *= -0.64999998;
    goto JL00A1;
  }
  Sleep(0.01);
  if (! _AnimChannel.bAnimDone ) goto JL00EF;
*/

  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until (ActualYaw == DesiredYaw);
  
  //for loop - AdamJD
  for ( TempFloat = 40; Abs(TempFloat) > 1.125; TempFloat *= -0.64999998 )
  {
	 RotateTo(ActualYaw + TempFloat,0.1);
	 
	 //do and until -AdamJD
	 do
	 {
		Sleep(0.01);
	 }
	 until (ActualYaw == DesiredYaw);
  }
  
  //do and until -AdamJD
  do
  {
	Sleep(0.01);
  }
  until	(_AnimChannel.bAnimDone);

  GotoState(BasilNextState);
}

state stateHit_2_
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  //UTPT didn't add this... -AdamJD
  function Tick(float dtime)
  {
	global.tick( dtime );

	if( Rand(12)==0 )
	{
		DesiredRotation.Yaw += (Rand(2)*2-1) * 4000;
		CastSpitSpell( false );
	}
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
 begin:
  _BasiliskHeadColObj.PlaySound(Sound'imp_ouch_02',Slot_None,BasilSoundVolume,,BasilSoundRadius,0.33329999);
  _BasiliskHeadColObj.PlaySound(Sound'SPI_medium_Hiss2',Slot_None,BasilSoundVolume,,BasilSoundRadius);
  _BasiliskHeadColObj.PlaySound(Sound'Basilisk_scream_death',Slot_Talk,BasilSoundVolume,,BasilSoundRadius);
  PlayAnim('React',1.0,2.0);
  PlayerHarry.ShakeView(2.0,125.0,125.0);
  FinishAnim();
  if ( bAttackAfterBeingHit )
  {
    bAttackAfterBeingHit = False;
    GotoState('stateAttackFromHole');
  }
  GotoState(BasilNextState);
}

function SetAttackTimer ()
{
  local float t;

  if (  !bDidFirstBattle )
  {
    t = b1_TimeBetweenAttackStart + (b1_TimeBetweenAttackStart - b1_TimeBetweenAttackEnd) * Health / 100;
    AttackTimer = t + RandRange( -t / 3, t / 3);
  } else {
    t = RandRange(1.0,AttackPeriod2);
    AttackTimer = t;
  }
}

function CastEyeSpell (bool bMissHarry)
{
  local BasiliskSpell spell;
  local Vector V;
  local float D;
  local float angleSpread;
  local float angleOffset;

  angleSpread = 3.0;
  bEyeShootToggle =  !bEyeShootToggle;
  if ( bEyeShootToggle )
  {
    angleOffset = 0.0;
  } else {
    angleOffset =  -angleSpread;
  }
  if ( bMissHarry )
  {
    angleOffset += DegRotAwayFromHarry() + 17.0 * (Rand(2) * 2 - 1);
  } else {
    angleOffset -= DegRotAwayFromHarry();
  }
  D = VSize(PlayerHarry.Location - _BasiliskHeadColObj.Location);
  V = Normal(PlayerHarry.Location + Vec(0.0,0.0,PlayerHarry.BaseEyeHeight / 3) - BonePos('Bone144'));
  spell = Spawn(Class'BasiliskSpell',,,BonePos('Bone144'));
}

state stateRetreat
{
  function bool ShouldDodgeSpell ()
  {
    return False;
  }
  
  function bool BasilAcksHit (baseSpell spell)
  {
    return False;
  }
  
 begin:
  PlayAnim('GoBack',1.0,0.31);
  FinishAnim();
  HideBasil();
  GotoState(WaitingState);
}

function int GetRealHeadYaw ()
{
  local int I;

  I = Rotation.Yaw + ActualYaw * 65536 / 360; 
  return I & 65535;
}

function SetRandomDesiredYawOffset (int YawOffset)
{
  local float Yaw;

  Yaw = ActualYaw + RandRange( -YawOffset,YawOffset);
  if ( Yaw <  -MaxHeadYaw )
  {
    Yaw =  -MaxHeadYaw;
  } else //{
    if ( Yaw > MaxHeadYaw )
    {
      Yaw = MaxHeadYaw;
    }
  //}
  RotateTo(Yaw);
}

function BasilHitBySpell (baseSpell spell, Vector HitLocation)
{
  local int DamageAmount;
  local bool bDoStateHit;

  if ( spellSwordFire(spell) == None )
  {
    return;
  }
  bDoStateHit = True;
  if ( bIdleState )
  {
    return;
  }
  DamageAmount = spellSwordFire(spell).Damage;
  DamageAmount *= GetBasilDamageScalar();
  if ( bDidFirstBattle )
  {
    DamageAmount *= 0.5;
  }
  if ( PlayerHarry.Difficulty == 1 )
  {
    DamageAmount *= 0.75;
  } else {
    if ( PlayerHarry.Difficulty == 2 )
    {
      DamageAmount *= 0.5;
    }
  }
  Health -= DamageAmount;
  if ( Health <= 0 )
  {
    if ( bDidFirstBattle && (aLastHole != HoleMarker[1]) )
    {
      bTookFirstDeathBlow = True;
      Health = 1;
    } else {
      Health = 0;
      BeatBoss();
    }
  }
  if ( Health > 0 )
  {
    if ( BasilAcksHit(spell) )
    {
      GotoState('stateHit');
    } else {
      if (  !bDidFirstBattle )
      {
        switch (Rand(3))
        {
          case 0:
          tempSound = Sound'Basilisk_ouch1';
          break;
          case 1:
          tempSound = Sound'Basilisk_ouch2';
          break;
          case 2:
          tempSound = Sound'Basilisk_ouch3';
          break;
          default:
        }
        PlaySound(tempSound,Slot_None,BasilSoundVolume,,BasilSoundRadius);
      }
    }
  }
  PlayerHarry.ClientMessage(" Basil Health:" $ string(Health));
  return;
}

function StartBossEncounter ()
{
  Super.StartBossEncounter();
  PlayerHarry.makeTarget();
  PlayerHarry.SpellCursor.bSpellCursorAlwaysOn = True;
  PlayerHarry.bStrafe = 1;
  PlayerHarry.bAutoCenterCamera = False;
  PlayerHarry.Cam.fDistanceScalarMin = 0.05;
  if (  !bDidFirstBattle )
  {
    PlayerHarry.Cam.fCurrentMinPitch = -4000.0;
    PlayerHarry.Cam.fCurrentMaxPitch = 10000.0;
    PlayerHarry.AimRotOffset = rot(3500,0,0);
    aEyeTarget = PlayerHarry.Spawn(Class'ActorChaser',PlayerHarry);
    aEyeTarget.AirSpeed = BeamChaseSpeed;
    aEyeTarget.AccelRate = BeamChaseAccel;
  } else {
    PlayerHarry.Cam.fCurrentMinPitch = -7000.0;
    PlayerHarry.Cam.fCurrentMaxPitch = 7000.0;
    PlayerHarry.AimRotOffset = rot(0,0,0);
  }
}

function BeatBoss ()
{
  local SnakeVenomPool pool;
  local spellAcidSpit spit;

  if (  !bDidFirstBattle )
  {
    StopEyeGlow();
    aEyeTarget.Destroy();
    aEyeTarget = None;
    SendDefeatedTrigger();
  } else {
    SendDefeatedTrigger2();
  }
  foreach AllActors(Class'SnakeVenomPool',pool)
  {
    pool.iDamage = 0;
  }
  foreach AllActors(Class'spellAcidSpit',spit)
  {
    spit.bSpawnPool = False;
    spit.iDamage = 0;
  }
  PlayerHarry.SpellCursor.bSpellCursorAlwaysOn = False;
  PlayerHarry.SpellCursor.EnableEmission(False);
  PlayerHarry.bAutoCenterCamera = True;
  PlayerHarry.TurnOffSpellCursor();
  PlayerHarry.StopBossEncounter();
  if ( bDidFirstBattle )
  {
    _BasiliskHeadColObj.Destroy();
    _BasiliskBreastColObj.Destroy();
    _BlockPlayer.Destroy();
    bBasilFinishedForGood = True;
    GotoState('stateInactive');
  } else {
    GotoState('stateIdle');
  }
  bIdleState = True;
  bDidFirstBattle = True;
}

function ColObjTouch (Actor Other, GenericColObj ColObj)
{
  local Sound snd;

  if ( (harry(Other) != None) && ((ColObj == _BasiliskHeadColObj) || (ColObj == _BasiliskHeadColObj2)) )
  {
    PlayerHarry.ClientMessage(" Basil ColObjTouch:" $ string(Other.Name));
    if ( HarryDamageTimer > 0.333 )
    {
      HarryDamageTimer = 0.0;
      if ( ColObj.bIsHead )
      {
        switch (Rand(5))
        {
          case 0:
          snd = Sound'PIX_bite1';
          break;
          case 1:
          snd = Sound'PIX_bite2';
          break;
          case 2:
          snd = Sound'PIX_bite3';
          break;
          case 3:
          snd = Sound'PIX_bite4';
          break;
          case 4:
          snd = Sound'PIX_bite5';
          break;
          default:
        }
        PlaySound(snd,Slot_None,BasilSoundVolume,,BasilSoundRadius,RandRange(0.62,0.81));
        harry(Other).TakeDamage(HeadDamage, self,ColObj.Location,vect(0.00,0.00,0.00),'None');
        BasilMunchesHarry();
      } else {
        harry(Other).TakeDamage(TailDamage, self,ColObj.Location,vect(0.00,0.00,0.00),'None');
      }
    }
  } else //{
    if ( spellSwordFire(Other) != None )
    {
      PlayerHarry.ClientMessage(" Basil ColObjTouch:" $ string(Other.Name));
      if (  !bHidden )
      {
        if ( ColObj == _BasiliskBreastColObj )
        {
          spellSwordFire(Other).Damage *= BreastHitDamageMult;
        }
        BasilHitBySpell(baseSpell(Other),Other.Location);
      }
    }
  //}
}

function MoveToRandomVisibleHole ()
{
  local int NumVisibleHoles;
  local int NumHoles;
  local Actor Holes[20];
  local Actor VisibleHoles[20];
  local Vector vDir;
  local Actor A;
  local float ClosestNonVisibleHoleDist;
  local int ClosestNonVisibleHoleIdx;

  ClosestNonVisibleHoleDist = 1000000.0;
  vDir = Normal(vector(PlayerHarry.Rotation) * vect(1.00,1.00,0.00));
  foreach AllActors(Class'Actor',A,HoleMarkerCommonTag)
  {
    if ( vDir Dot Normal((A.Location - PlayerHarry.Location) * vect(1.00,1.00,0.00)) > 0.5 )
    {
      VisibleHoles[NumVisibleHoles++ ] = A;
    } else {
      if ( VSize2D(A.Location - PlayerHarry.Location) < ClosestNonVisibleHoleDist )
      {
        ClosestNonVisibleHoleDist = VSize2D(A.Location - PlayerHarry.Location);
        ClosestNonVisibleHoleIdx = NumHoles;
      }
    }
    Holes[NumHoles++ ] = A;
  }
  if ( FRand() < 0.2 )
  {
    A = Holes[Rand(NumHoles)];
  } else //{
    if ( (NumVisibleHoles == 0) || (NumVisibleHoles == 1) && (FRand() < 0.5) )
    {
      A = Holes[ClosestNonVisibleHoleIdx];
    } else {
      A = VisibleHoles[Rand(NumVisibleHoles)];
    }
  //}
  SetLocation(A.Location);
}

function TweakSetting (string S)
{
  local string Command;
  local string v1;

  Command = ParseDelimitedString(S," ",1,False);
  v1 = ParseDelimitedString(S," ",2,False);
  if ( Command ~= "SpellStartSpeed" )
  {
    PlayerHarry.ClientMessage("Basil SpellStartSpeed:" $ string(SpellStartSpeed));
    if ( v1 != "" )
    {
      PlayerHarry.ClientMessage("      SpellStartSpeed:" $ string(float(v1)));
      SpellStartSpeed = float(v1);
    }
  } else //{
    if ( Command ~= "CamZOffset" )
    {
      PlayerHarry.ClientMessage("Basil CamZOffset:" $ string(CamZOffset));
      if ( v1 != "" )
      {
        PlayerHarry.ClientMessage("      CamZOffset:" $ string(float(v1)));
        CamZOffset = float(v1);
      }
    } else //{
      if ( Command ~= "EyeBeam" )
      {
        bUseEyeBeam = True;
      } else {
        Super.TweakSetting(S);
      }
    // }
  // }
}

defaultproperties
{
    BreastHitDamageMult=0.33

    bIdleState=True

    SlideDistance=30.00

    SlideSpeed=200.00

    CamXOffset=100.00

    CamZOffset=50.00

    HeadYawRate=25.00

    MaxHeadYaw=85.00

    b1_TimeBetweenAttackStart=1.00

    b1_TimeBetweenAttackEnd=0.25

    b1_EyeShootWarningStart=2.50

    b1_EyeShootWarningEnd=1.50

    BeamLifeSpan=2.00

    BeamYawRate_DegreesPerSec=12

    BeamYawStartOffset_Degrees=15

    BeamLength=340.00

    BeamDamage=10.00

    BeamChaseSpeed=90.00

    BeamChaseAccel=150.00

    AttackPeriod2=2.00

    HeadSpazSpeed=200.00

    HeadCollisionRadius=35.00

    MainBoneName="ani_Bone08"

    HeadAttackNearest=192.00

    HeadAttackFarthest=512.00

    HeadAttackAnimRate=0.70

    b1_HeadRoarAnimRate_Start=3.00

    b1_HeadRoarAnimRate_End=0.50

    HeadAttackNearest_2=128.00

    HeadAttackFarthest_2=320.00

    b2_SprayWarningAnimRate=2.00

    HoleMarkerCommonTag="BasiliskHoleMarker"

    OutHoleMaxRandYaw=9000

    BasilSniffDistance=350.00

    SpellToHeadProximity=80.00

    AcidSpitYawSpread=40.00

    AcidSpitCount=18

    AcidSpitFreq=20.00

    AcidSpitTargetDistributionWidth=250.00

    AcidSpitChaseHarryYawSpread=4000.00

    BasilSoundRadius=1000000.00

    BasilSoundVolume=0.70

    SpellDamageAmount=10.00

    SpellInitialDrawScale=2.00

    SpellEndDrawScale=2.00

    SpellStartSpeed=950.00

    SpellEndSpeed=155.00

    MinDamageToBotherBasil=3.00

    CentreOffset=(X=30.00,Y=0.00,Z=130.00),

    bGestureFaceHorizOnly=True

    Mesh=SkeletalMesh'HPModels.skbasiliskMesh'

    DrawScale=1.80

}
