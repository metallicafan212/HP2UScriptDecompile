//================================================================================
// orangesnail.
//================================================================================

class orangesnail extends Characters;

const TRAIL_ARRAY_SIZE= 50;
const fDONT_ATTACK_AFTER_CUT_TIME= 3.0;
const PATROL_BEFORE_RAM_TIME= 3.0;
var SnailTrail arrayTrail[50];
var Vector vLastTrailSpawnLoc;
var int nEctoplasmTouchCount;
var bool bLeaveTrail;
var int nCurrTrailSlot;
var bool bAllowSnailDamage;
var float fTimeSinceSnailDamage;
var float fPatrolTime;
var Vector vTemp;
var bool bCutInProgress;
var float fStunTimeLeft;
var float fCountdownAfterCut;
var Sound soundAttackCry;
var Sound soundWarningCry;
var(Snail) float fGroundspeedNormal;
var(Snail) float fGroundspeedEcto;
var(Snail) float fGroundspeedRam;
var(Snail) float fGroundspeedEctoRam;
var(Snail) bool bAllowRam;
var(Snail) int nBumpRetreatMin;
var(Snail) int nBumpRetreatMax;
var(Snail) float fTrailDuration;
var(Snail) float fTrailShrinkAfter;
var(Snail) int nMaxTrailSegments;
var(Snail) float fTrailDamageWait;
var(Snail) int nTrailDamage;
var(Snail) int nNormalBodyDamage;
var(Snail) int nRamBodyDamage;
var(Snail) float fStunDuration;

function PostBeginPlay()
{
  if ( nMaxTrailSegments > 50 )
  {
    PlayerHarry.ClientMessage("Warning: Need to increase TRAIL_ARRAY_SIZE");
    Log("Warning: Need to increase TRAIL_ARRAY_SIZE");
    nMaxTrailSegments = 50;
  }
}

event Tick (float fDeltaTime)
{
  Super.Tick(fDeltaTime);
  DoTrailUpdates(fDeltaTime);
  if ( fStunTimeLeft > 0 )
  {
    fStunTimeLeft -= fDeltaTime;
    if ( fStunTimeLeft < 0 )
    {
      fStunTimeLeft = 0.0;
    }
  }
  if ( (bCutInProgress == True) && (fCountdownAfterCut > 0) )
  {
    fCountdownAfterCut -= fDeltaTime;
    if ( fCountdownAfterCut <= 0 )
    {
      bCutInProgress = False;
      fCountdownAfterCut = 0.0;
    }
  }
}

event Falling()
{
  Super.Falling();
  EndTrail();
}

event Landed (Vector HitNormal)
{
  Super.Landed(HitNormal);
  PlaySound(Sound'snail_land',SLOT_None);
  if ( IsInState('patrol') || IsInState('RamHarry') )
  {
    StartTrail();
  }
}

function SetGroundSpeed()
{
  if ( nEctoplasmTouchCount >= 1 )
  {
    GroundSpeed = fGroundspeedEcto;
  } else {
    GroundSpeed = fGroundspeedNormal;
  }
}

function HarrySteppedOnTrail (Vector vTrailLocation)
{
  DoSnailDamage('SnailTrail',vTrailLocation,IsInState('RamHarry'));
}

function DoSnailDamage (name nameDamage, Vector vDamageLoc, bool bCuttingHarryOff)
{
  local int nDamage;

  if ( bCutInProgress )
  {
    return;
  }
  if ( bAllowSnailDamage == True )
  {
    if ( nameDamage == 'SnailTrail' )
    {
      nDamage = nTrailDamage;
    } else {
      if ( bCuttingHarryOff )
      {
        nDamage = nRamBodyDamage;
      } else {
        nDamage = nNormalBodyDamage;
      }
    }
    PlayerHarry.TakeDamage(nDamage,self,vDamageLoc,vect(0.00,0.00,0.00),nameDamage);
    if ( nameDamage == 'SnailTrail' )
    {
      switch (Rand(3))
      {
        case 0:
        PlaySound(Sound'HAR_acid_burn1');
        break;
        case 1:
        PlaySound(Sound'HAR_acid_burn2');
        break;
        case 2:
        PlaySound(Sound'HAR_acid_burn3');
        break;
        default:
      }
    } else {
      PlaySound(Sound'snail_ouch2',SLOT_None,RandRange(0.81,1.0),,,RandRange(0.81,1.12));
    }
    bAllowSnailDamage = False;
  }
}

function DoTrailUpdates (float fDeltaTime)
{
  local int nTrailRadius;
  local int nTrailHeight;
  local Rotator rTrailRotation;
  local Vector vTrailLocation;

  nTrailRadius = Class'SnailTrail'.Default.CollisionRadius;
  // if ( (bLeaveTrail == True) && (bool(Physics) != bool(2)) && (VSize(Location - vLastTrailSpawnLoc) > byte(nTrailRadius) * 0.81) );
  if ( (bLeaveTrail == True && Physics != PHYS_Falling) && (VSize(Location - vLastTrailSpawnLoc) > (nTrailRadius * 0.81)) )
  {
    rTrailRotation = Class'SnailTrail'.Default.Rotation;
    vTrailLocation = Location;
    vTrailLocation.Z -= CollisionHeight;
    if ( arrayTrail[nCurrTrailSlot] == None )
    {
      arrayTrail[nCurrTrailSlot] = Spawn(Class'SnailTrail',,,vTrailLocation,rTrailRotation);
      arrayTrail[nCurrTrailSlot].SetSpawnProps(self,fTrailDuration,fTrailShrinkAfter);
    }
    arrayTrail[nCurrTrailSlot].StartUsing(vTrailLocation);
    vLastTrailSpawnLoc = Location;
    nCurrTrailSlot++;
    if ( nCurrTrailSlot >= nMaxTrailSegments )
    {
      nCurrTrailSlot = 0;
    }
  }
  if ( bAllowSnailDamage == False )
  {
    fTimeSinceSnailDamage += fDeltaTime;
    if ( fTimeSinceSnailDamage >= fTrailDamageWait )
    {
      bAllowSnailDamage = True;
      fTimeSinceSnailDamage = 0.0;
    }
  }
}

function StartTrail()
{
  bLeaveTrail = True;
}

function EndTrail()
{
  local int I;

  bLeaveTrail = False;

  for(I = 0; I < nMaxTrailSegments; I++)
  {
    arrayTrail[I].StopUsing();
  }
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  local bool bReturn;

  PlaySnailHitSound();
  Super.HandleSpellFlipendo(spell,vHitLocation);
  GotoState('Pushed');
  return True;
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  local bool bReturn;

  PlaySnailHitSound();
  EndTrail();
  Super.HandleSpellRictusempra(spell,vHitLocation);
  GotoState('Stunned');
  return True;
}

function PlaySnailHitSound()
{
  switch (Rand(3))
  {
    case 0:
    PlaySound(Sound'snail_ouch1_A',SLOT_None);
    break;
    case 1:
    PlaySound(Sound'snail_ouch1_B',SLOT_None);
    break;
    case 2:
    PlaySound(Sound'snail_ouch1_C',SLOT_None);
    break;
    case 3:
    PlaySound(Sound'snail_ouch2_A',SLOT_None);
    break;
    default:
  }
}

function PlayerCutCapture()
{
  fCountdownAfterCut = 0.0;
  bCutInProgress = True;
  if ( IsInState('RamHarry') )
  {
    GotoState('patrol');
  }
}

function PlayerCutRelease()
{
  fCountdownAfterCut = 3.0;
}

event Bump (Actor Other)
{
  if ( PlayerHarry == Other )
  {
    DoSnailDamage('Snail',Location,IsInState('RamHarry'));
    GotoState('BumpedHarryPart1');
  }
}

event Touch (Actor Other)
{
  if ( Ectoplasma(Other) != None )
  {
    nEctoplasmTouchCount++;
    SetGroundSpeed();
  }
}

event UnTouch (Actor Other)
{
  if ( Ectoplasma(Other) != None )
  {
    nEctoplasmTouchCount--;
    if ( nEctoplasmTouchCount <= 0 )
    {
      nEctoplasmTouchCount = 0;
    }
    SetGroundSpeed();
  }
}

auto state patrol
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  //UTPT didn't add this for some reason -AdamJD
  event Tick(float fDeltaTime)
  {
	  Global.Tick(fDeltaTime);

	  fPatrolTime += fDeltaTime;

	  if ( bAllowRam && !bCutInProgress && CanSee(playerHarry) && (fPatrolTime >= PATROL_BEFORE_RAM_TIME) )
	  {
		  GoToState('RamHarry');
	  }
  }
  
  function Timer()
  {
    SetTimer(RandRange(3.0,8.0),False);
    if ( Rand(2) == 0 )
    {
      PlaySound(Sound'snail_slither1',SLOT_None,,,1000.0,RandRange(0.81,1.12));
    } else {
      PlaySound(Sound'snail_slither2',SLOT_None,,,1000.0,RandRange(0.81,1.12));
    }
  }
  
  event BeginState()
  {
    Super.BeginState();
    SetGroundSpeed();
    StartTrail();
    fPatrolTime = 0.0;
    SetTimer(RandRange(3.0,8.0),False);
  }
  
  event EndState()
  {
    SetTimer(0.0,False);
  }
}

state Pushed
{
  ignores Bump; //UTPT didn't add this for some reason -AdamJD
	
  function Landed (Vector HitNormal)
  {
    Super.Landed(HitNormal);
    PlaySound(Sound'snail_land',SLOT_None);
    GotoState('RecoverFromPush');
  }
  
 begin:
  PlayAnim('Idle');
}

state RecoverFromPush
{
  ignores Bump; //UTPT didn't add this for some reason -AdamJD
	 
begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  LoopAnim('Stunned');
  if ( fStunTimeLeft > 0 )
  {
    Sleep(fStunTimeLeft);
  }
  // eVulnerableToSpell = 22;
  eVulnerableToSpell = SPELL_Rictusempra;
  GotoState('patrol');
}

state Stunned
{
  ignores Bump; //UTPT didn't add this for some reason -AdamJD
  
begin:
  fStunTimeLeft = fStunDuration;
  // eVulnerableToSpell = 13;
  eVulnerableToSpell = SPELL_Flipendo;
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  PlayAnim('spin');
  FinishAnim();
  LoopAnim('Stunned');
  Sleep(fStunTimeLeft);
  // eVulnerableToSpell = 22;
  eVulnerableToSpell = SPELL_Rictusempra;
  GotoState('patrol');
}

state RamHarry
{
  function SetGroundSpeed()
  {
    if ( nEctoplasmTouchCount >= 1 )
    {
      GroundSpeed = fGroundspeedEctoRam;
    } else {
      GroundSpeed = fGroundspeedRam;
    }
  }
  
  event BeginState()
  {
    Super.BeginState();
    StartTrail();
  }
  
  event HitWall (Vector HitNormal, Actor HitWall)
  {
    GotoState('patrol');
  }
  
  event EndState()
  {
    StopSound(soundAttackCry,SLOT_None);
    StopSound(soundWarningCry,SLOT_None);
  }
  
 begin:
  TurnToward(PlayerHarry);
  SetGroundSpeed();
  if ( Rand(2) == 0 )
  {
    PlaySound(soundAttackCry,SLOT_None,RandRange(0.81,1.0),,,RandRange(0.81,1.12));
  } else {
    PlaySound(soundWarningCry,SLOT_None,RandRange(0.81,1.0),,,RandRange(0.81,1.12));
  }
  MoveTo(PlayerHarry.Location);
  PlayAnim('Idle');
  Sleep(0.5);
  GotoState('patrol');
}

state BumpedHarryPart1
{
  ignores Bump; //UTPT didn't add this for some reason -AdamJD
  
  function Vector GetAboutFaceVector()
  {
    local Vector vDest;
  
    vDest = Velocity;
    vDest = Normal(vDest);
    vDest *= -15;
    vDest = Location + vDest;
    return vDest;
  }
  
 begin:
  vTemp = GetAboutFaceVector();
  EndTrail();
  StartTrail();
  MoveTo(vTemp);
  GotoState('BumpedHarryPart2');
}

state BumpedHarryPart2
{
  function Vector GetDestVector()
  {
    local Vector vDest;
    local int nRetreatScalar;
  
    vDest = Normal(Velocity);
    nRetreatScalar = RandRange(nBumpRetreatMin, nBumpRetreatMax);
	PlayerHarry.ClientMessage("Bump Retreat: " $ string(nRetreatScalar));
    vDest *= nRetreatScalar;
    vDest = Location + vDest;
    return vDest;
  }
  
 begin:
  MoveTo(GetDestVector());
  GotoState('patrol');
}

defaultproperties
{
    bAllowSnailDamage=True

    soundAttackCry=Sound'HPSounds.Critters_sfx.snail_attack_cry'

    soundWarningCry=Sound'HPSounds.Critters_sfx.snail_warning_cry'

    fGroundspeedNormal=25.00

    fGroundspeedEcto=10.00

    fGroundspeedRam=100.00

    fGroundspeedEctoRam=20.00

    bAllowRam=True

    nBumpRetreatMin=100

    nBumpRetreatMax=200

    fTrailDuration=9.00

    fTrailShrinkAfter=4.50

    nMaxTrailSegments=40

    fTrailDamageWait=2.00

    nTrailDamage=10

    nNormalBodyDamage=5

    nRamBodyDamage=25

    fStunDuration=15.00

    bFlipPushable=True

    fFlipPushForceZ=100.00

    soundFalling(0)=Sound'HPSounds.Critters_sfx.snail_falling'

    soundFalling(1)=Sound'HPSounds.Critters_sfx.snail_falling2'

    bThrownObjectDamage=True

    GroundSpeed=25.00

    SightRadius=600.00

    PeripheralVision=0.40

    BaseEyeHeight=30.00

    EyeHeight=30.00

    WalkAnimName=locomotion

    RunAnimName=locomotion

    bDoEyeBlinks=False

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra

    Mesh=SkeletalMesh'HPModels.skorangesnailMesh'

    DrawScale=3.00

    AmbientGlow=110

    CollisionRadius=30.00

    CollisionHeight=30.00

    RotationRate=(Pitch=10500,Yaw=10500,Roll=10500)
}
