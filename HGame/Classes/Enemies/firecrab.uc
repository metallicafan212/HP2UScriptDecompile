//================================================================================
// firecrab.
//================================================================================

class firecrab extends HChar;

const BOOL_DEBUG_AI= false;
var Vector vHome;
var Vector vPush;
var float fHighestZ;
var bool bFalling;
var Vector vMoveDir;
var Rotator vMoveDirRot;
var Sound WalkingSound;
var Sound RoarSound;
var Sound AttackSound;
var float OldFlipendoXY;
var float OldFlipendoZ;
var() float TimeUntilNextFireDefault;
var float TimeUntilNextFire;
var() float fAttackRange;
var() int iNumSpellHitsToFlipDefault;
var int iNumSpellHitsToFlip;
var() bool bFallDistanceCheck;
var() float fTimeSpentOnBack;
var float fTimeOnBack;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  if ( (DrawScale != Default.DrawScale) && self.IsA('firecrabLarge') )
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
  }
  AmbientSound = WalkingSound;
}

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  // SetPhysics(1);
  SetPhysics(PHYS_Walking);
  LoopAnim('Idle');
  vHome = Location;
  TimeUntilNextFire = TimeUntilNextFireDefault;
  iNumSpellHitsToFlip = iNumSpellHitsToFlipDefault;
  fHighestZ = Location.Z;
  fTimeOnBack = fTimeSpentOnBack;
}

function playHitSound ()
{
  local Sound HitSound;
  local Sound hardHitSound;
  local int randNum;

  randNum = Rand(3);
  switch (randNum)
  {
    case 0:
    HitSound = Sound'firecrab_ouch_A';
    break;
    case 1:
    HitSound = Sound'firecrab_ouch_B';
    break;
    case 2:
    HitSound = Sound'firecrab_ouch_C';
    break;
    default:
  }
  PlaySound(HitSound,/*0*/SLOT_None,RandRange(0.62,1.0),,10000.0,RandRange(0.81,1.25),,False);
  hardHitSound = Sound'firecrab_hit';
  PlaySound(hardHitSound,/*0*/SLOT_None,RandRange(0.62,1.0),,10000.0,RandRange(0.81,1.25),,False);
}

function playFlipSound ()
{
  local Sound flipSound;
  local int randNum;

  randNum = Rand(2);
  switch (randNum)
  {
    case 0:
    flipSound = Sound'firecrab_ss_fcb_turn_01E';
    break;
    case 1:
    flipSound = Sound'firecrab_ss_fcb_turn_01E';
    break;
    default:
  }
  PlaySound(flipSound,/*0*/SLOT_None,RandRange(0.81,1.0),,10000.0,RandRange(0.81,1.25),,False);
}

event TakeDamage (int Damage, Pawn EventInstigator, Vector HitLocation, Vector Momentum, name DamageType)
{
  if ( DamageType == 'ZonePain' )
  {
    Destroy();
  }
}

function PlayerCutCapture ()
{
  if (  !IsInState('stayFlipped') )
  {
    GotoState('CutIdle');
  }
}

state CutIdle
{
begin:
  TimeUntilNextFire = 1410065408.0;
  GotoState('patrol');
}

function PlayerCutRelease ()
{
  TimeUntilNextFire = TimeUntilNextFireDefault;
  // eVulnerableToSpell = 22;
  eVulnerableToSpell = SPELL_Rictusempra;
}

function bool OnALedge (Vector Loc)
{
  local Vector vLocation;
  local Vector vUnderLocation;

  vLocation = Loc;
  vUnderLocation = vLocation;
  vUnderLocation = vUnderLocation + Vec(0.0,0.0,-35.0);
  if ( FastTrace(vUnderLocation,vLocation) )
  {
    return True;
  }
  return False;
}

function Vector pushDirection ()
{
  local float fRotation[16];
  local int Count;
  local int rotationCount;
  local Rotator Facing;
  local Vector tempLocation;
  local Vector tempCollision;
  local int Index;

  Facing = rotator(PlayerHarry.Location - Location);
  // Count = 1;
  // if ( Count <= 16 )
  for(Count = 1; Count <= 16; Count++)
  {
    Facing.Yaw = 65536 / 16 * Count;
    tempLocation = Location + (vector(Facing) * CollisionRadius);
    if (  !OnALedge(tempLocation) )
    {
      fRotation[rotationCount] = (65536.0 / 16) * Count;
      rotationCount++;
    }
    // Count++;
    // goto JL0023;
  }
  // Count = 0;
  // if ( Count < rotationCount )
  // {
    // Count++;
    // goto JL00AA;
  // }
  
  if ( rotationCount <= 2 )
  {
    return Vec(0.0,0.0,-1.0);
  } else //{
    if ( rotationCount <= 9 )
    {
      Index = rotationCount / 2;
      Facing = rotator(PlayerHarry.Location - Location);
      Facing.Yaw = fRotation[Index];
	  tempLocation = Location + (vector(Facing) * CollisionRadius);
      return Normal(Location - tempLocation);
    } else {
      return Vec(0.0,0.0,0.0);
    }
  //}
}

static function Vector GetFacing (Actor A)
{
  return Vec(1.0,0.0,0.0) >> A.Rotation;
}

function Landed (Vector HitNormal)
{
  local float fFallDistanceZ;

  Super.Landed(HitNormal);
  if ( (DrawScale != Default.DrawScale) && self.IsA('firecrabLarge') )
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
  }
  fFallDistanceZ = fHighestZ - Location.Z;
  if ( (fFallDistanceZ > 25) && (bFallDistanceCheck == True) )
  {
    cm("Fall distance greater than 25. Stay Flipped");
    GotoState('stayFlipped');
  }
  PlayerHarry.ClientMessage("How far did the firecrab fall : " $ string(fFallDistanceZ));
}

function Falling ()
{
  Super.Falling();
  if ( False )
  {
    PlayerHarry.ClientMessage("I'm falling and I can't get up ");
  }
}

function HitByThrownObject (int Damage, HPawn InstigatedBy, Vector HitLocation, Vector Momentum, name ObjectType)
{
  fTimeOnBack = fTimeSpentOnBack * 4;
  iNumSpellHitsToFlip = 1;
  HandleSpellRictusempra(None,HitLocation);
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  if ( Other == self )
  {
    GotoState('stayFlipped');
  }
}

state stateIdle //extends stateIdle
{
begin:
  AmbientSound = None;
  LoopAnim('Idle');
}

state FallOverLedge
{
  function BeginState ()
  {
    cm("Entered state FallOverLedge");
    fHighestZ = Location.Z;
    LoopAnim('onback');
    if ( bFalling == True )
    {
      if ( OnALedge(Location) )
      {
        vPush = pushDirection();
      }
    }
    bFalling = True;
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    Super.HitWall(HitNormal,Wall);
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
  }
  
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    MoveSmooth(vPush * (GroundSpeed * 3) * DeltaTime);
  }
  
  begin:
}

state stayFlipped
{
begin:
  cm("Begun state StayFlipped");
  // eVulnerableToSpell = 13;
  eVulnerableToSpell = SPELL_Flipendo;
  if ( self.IsA('firecrabSmall') )
  {
    fFlipPushForceXY = 0.5 * Default.fFlipPushForceXY;
    fFlipPushForceZ = 0.41 * Default.fFlipPushForceZ;
  }
  if ( False )
  {
    PlayerHarry.ClientMessage(string(Name) $ " : State StayFlipped ");
  }
  TimeUntilNextFire = 999999.0;
  LoopAnim('onback');
  TimeUntilNextFire = 999999.0;
  Sleep(1.0);
  goto ('onBackloop');
}

defaultproperties
{
    RoarSound=Sound'HPSounds.Critters_sfx.firecrab_roar'

    AttackSound=Sound'HPSounds.Critters_sfx.firecrab_attack'

    TimeUntilNextFireDefault=2.00

    fAttackRange=400.00

    iNumSpellHitsToFlip=2

    bFallDistanceCheck=True

    fTimeSpentOnBack=5.00

    fFlipPushForceXY=260.00

    fFlipPushForceZ=100.00

    bThrownObjectDamage=True

    GroundSpeed=60.00

    AirSpeed=60.00

    AccelRate=4000.00

    SightRadius=600.00

    PeripheralVision=1.00

    BaseEyeHeight=20.00

    EyeHeight=20.00

    IdleAnimName=breath

    RunAnimName=Walk

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra

    Mesh=SkeletalMesh'HPModels.skfirecrabMesh'

    DrawScale=2.00

    AmbientGlow=110

    Mass=130.00

    RotationRate=(Pitch=100000,Yaw=100000,Roll=100000),
}
