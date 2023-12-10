//================================================================================
// Spider.
//================================================================================

class Spider extends HChar;

enum enumPreAttackAnim {
  ATTACK_NONE,
  ATTACK_JUMP,
  ATTACK_REAR
};

var Vector vDir;
var Rotator rRotationVector;
var Vector vDirectionVector;
var bool bAttacking;
var int check;
var name SavedState;
var() int numSpellsDefault;
var int numSpells;
var() float leaveDeadSpider;
var SpiderMarker currentMarker;
var float forward;
var() float NormalSpeed;
var() float attackSpeed;
var() bool canWander;
var() bool waitForTrigger;
var() float forwardDistance;
var() string GroupName;
var() float jumpDistance;
var float drawingScale;
var() bool bJumper;
var() float jumpingDistanceFromHarry;
var() float fDamageAmount;
var SpiderLarge myFriends[6];
var int numFriends;
var int Counter;
var bool bRandomSize;
var bool atTheEdge;
var float EdgeCounter;
var() enumPreAttackAnim ePreAttackAnim;
var Sound squishSound;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  if ( bJumper == True )
  {
    // SetPhysics(0);
	SetPhysics(PHYS_None);
    bCollideWorld = False;
  } else {
    // SetPhysics(1);
	SetPhysics(PHYS_Walking);
  }
  if ( bRandomSize == True )
  {
    DrawScale *= RandRange(0.69999999,1.5);
  }
  if ( self.IsA('SpiderAttendent') )
  {
    SetCollision(True,False);
  }
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
  UpdateFriendsList();
}

function PlayerCutCapture()
{
  SavedState = GetStateName();
  if ( SavedState != 'OutForTheCount' )
  {
    GotoState('CutIdle');
  }
}

function PlayerCutRelease()
{
  if ( SavedState != 'OutForTheCount' )
  {
    GotoState(SavedState);
  }
}

function UpdateFriendsList()
{
  local SpiderLarge tempSpider;

  if ( self.IsA('SpiderLarge') )
  {
    foreach AllActors(Class'SpiderLarge',tempSpider)
    {
      if ( tempSpider != self )
      {
        if ( tempSpider.GroupName == GroupName )
        {
          myFriends[numFriends] = tempSpider;
          numFriends++;
        }
      }
    }
  }
}

function playSquishSound()
{
  local int randNum;

  randNum = Rand(2);
  switch (randNum)
  {
    case 0:
    squishSound = Sound'spider_small_squish';
    break;
    case 1:
    squishSound = Sound'spider_small_squish2';
    break;
    default:
    squishSound = Sound'spider_small_squish';
    break;
  }
  PlaySound(squishSound,SLOT_None,RandRange(0.6,1.0),,10000.0,RandRange(0.80,1.20),,False);
}

function playAttackSound()
{
  local Sound AttackSound;
  local int randNum;

  randNum = Rand(3);
  switch (randNum)
  {
    case 0:
    AttackSound = Sound'firecrab_ouch_A';
    break;
    case 1:
    AttackSound = Sound'firecrab_ouch_B';
    break;
    case 2:
    AttackSound = Sound'firecrab_ouch_C';
    break;
    default:
  }
  PlaySound(AttackSound,SLOT_None,RandRange(0.6,1.0),,10000.0,RandRange(0.80,1.20),,False);
}

function bool AttackHarryCheck()
{
  local bool Attack;
  local Vector vTargetDir;

  Attack = False;
  vTargetDir = PlayerHarry.Location - Location;
  if ( self.IsA('SpiderSmall') )
  {
    if ( (VSize(PlayerHarry.Velocity) < 5) && (VSize(vTargetDir) < SightRadius) )
    {
      Attack = True;
    }
  } else //{
    if ( self.IsA('SpiderLarge') )
    {
      if ( VSize(vTargetDir) < SightRadius )
      {
        Attack = True;
      }
    }
 // }
  return Attack;
}

function Touch (Actor Other)
{
  if ( self.IsA('SpiderSmall') &&  !IsInState('Attack') && Other.IsA('harry') )
  {
    if ( VSize(PlayerHarry.Velocity) != 0 )
    {
      PlayerHarry.ClientMessage("Squish");
      playSquishSound();
      GotoState('DeadSpider');
    }
  } else {
    Super.Touch(Other);
  }
}

function InitSpider()
{
  local SpiderMarker Marker;

  foreach AllActors(Class'SpiderMarker',Marker)
  {
    if ( (Marker.bCenter == True) && (Marker.GroupName == GroupName) )
    {
      currentMarker = Marker;
	  break;
    }
  }
  if ( currentMarker == None )
  {
    Log(string(self.Name) $ ": There is NO marker with the same name in this level");
  }
  GroundSpeed = NormalSpeed + FRand() * 10;
  forward = forwardDistance;
  numSpells = numSpellsDefault;
  if ( DrawScale != Default.DrawScale )
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
  }
}

function Vector getNewDirection()
{
  local Vector vToMarker;
  local Vector vUp;
  local Vector vRight;
  local Vector vDirection;
  local Vector vToMarkerEdge;

  vToMarker = Normal(currentMarker.Location - Location);
  vUp = Vec(0.0,0.0,1.0);
  vToMarkerEdge = vToMarker * currentMarker.CollisionRadius;
  vRight = vToMarker Cross vUp;
  if ( Rand(2) == 0 )
  {
    vDirection = currentMarker.Location + vToMarkerEdge + (vRight * FRand() * 200);
  } else {
    vDirection = currentMarker.Location + vToMarkerEdge +  (-vRight * FRand() * 200);
  }
  return vDirection;
}

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( bDespawned )
  {
    GotoState('FellInAHole');
  }
}

state CutIdle
{
begin:
  if ( SavedState != 'OutForTheCount' )
  {
    LoopAnim('Idle');
  }
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
}

auto state BeginSpider
{
begin:
  if ( self.IsA('SpiderAttendent') )
  {
    GotoState('preAttackSetup');
  } else //{
    if ( self.IsA('SpiderDead') )
    {
      GotoState('StartPatrolling');
    } else {
      InitSpider();
      LoopAnim('Idle');
      if ( waitForTrigger == False )
      {
        GotoState('checkForwardDistance');
      } else {
        GotoState('waitingForTrigger');
      }
    }
  //}
}

state checkForwardDistance
{
begin:
  if ( forward != 0 )
  {
    GotoState('WalkForward');
  } else {
    GotoState('moveToMarker');
  }
}

state moveToMarker
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);

	if ( AttackHarryCheck() == true && forward == 0 && !IsInState('CutIdle') )
	{
		GotoState('preAttackCheck');
	}

	if ( Velocity == vec(0,0,0) )
	{
		LoopAnim('idle');
		GotoState('Wander');
	}
  }
  
  function HitWall (Vector HitNormal, Actor HitWall)
  {
    Super.HitWall(HitNormal,HitWall);
    if ( HitWall != PlayerHarry )
    {
      Acceleration *= HitNormal * 10;
      DesiredRotation = rotator(HitNormal);
      SetRotation(rotator(HitNormal));
      GotoState('Wander');
    }
  }
  
  function UnTouch (Actor Other)
  {
    Super.UnTouch(Other);
    if ( Other.IsA('SpiderMarker') )
    {
      if ( SpiderMarker(Other) == currentMarker )
      {
        Velocity = vect(0.00,0.00,0.00);
        Acceleration = vect(0.00,0.00,0.00);
        GotoState('AtMarker');
      }
    }
  }
  
 begin:
  LoopAnim('Walk');
  vDirectionVector = currentMarker.Location - Location;
  if ( Rand(2) == 0 )
  {
    vDir = Location + (vDirectionVector * (vDirectionVector Cross Vec(0.0,0.0,1.0) * (FRand() * 205)));
  } else {
    vDir = Location - (vDirectionVector * (vDirectionVector Cross Vec(0.0,0.0,1.0) * (FRand() * 205)));
  }
  MoveTo(vDir);
}

state WalkForward
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  function BeginState()
  {
    LoopAnim('Walk');
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);

	forward -= VSize(Velocity) * DeltaTime;
		
	if ( forward <= 0 )
	{
	  forward = 0;
	  GotoState('moveToMarker');
	}
  }
  
 begin:
  MoveTo(Location + (vector(Rotation) * forwardDistance));
}

state AtMarker
{
begin:
  if ( canWander == True )
  {
    GotoState('Wander');
  } else {
    GotoState('Wait');
  }
}

state Wander
{
  // ignores  Touch, Tick; //UTPT added this for some reason -AdamJD
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);

	if ( AttackHarryCheck() == true && !IsInState('CutIdle') )
	{
	  GotoState('preAttackCheck');
	}

	else if ( VSize(Velocity) < GroundSpeed / 3.0 )
	{
	  SetLocation(OldLocation);
	  GotoState('ImLost');
	}
  }
  
  function HitWall (Vector HitNormal, Actor HitWall)
  {
    Super.HitWall(HitNormal,HitWall);
    if ( HitWall != PlayerHarry )
    {
      SetLocation(OldLocation);
      GotoState('Wander');
    }
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Touch(actor other)
  {
	Global.Touch(other);
		
	if ( other.IsA('SpiderSmall') || other.IsA('SpiderLarge') )
	{
	  //KW left this empty? -AdamJD
	}
	else
	{
	  GotoState('wander');
	}
  }
  
  function Bump (Actor Other)
  {
    Touch(Other);
  }
  
  function UnTouch (Actor Other)
  {
    Super.UnTouch(Other);
    if ( Other.IsA('SpiderMarker') )
    {
      if ( SpiderMarker(Other) == currentMarker )
      {
        Velocity = vect(0.00,0.00,0.00);
        Acceleration = vect(0.00,0.00,0.00);
        GotoState('RandomWait');
      }
    }
  }
  
 begin:
  GroundSpeed = NormalSpeed;
  SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
  if ( atTheEdge == True )
  {
    GotoState('walkAway');
  } else {
    if ( AttackHarryCheck() != True )
    {
      vDir = getNewDirection();
      MoveTo(vDir);
    }
    LoopAnim('Walk',0.85);
  }
}

state walkAway
{
  function BeginState()
  {
    EdgeCounter = FRand() * 1.5 + 1.5;
  }
  
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    EdgeCounter -= DeltaTime;
    if ( EdgeCounter <= 0 )
    {
      Acceleration = vect(0.00,0.00,0.00);
      Velocity = vect(0.00,0.00,0.00);
      GotoState('Wander');
    }
  }
  
 begin:
  atTheEdge = False;
  LoopAnim('Walk',0.85);
  MoveToward(currentMarker);
}

state Wait
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);

	if ( AttackHarryCheck() == true  && !IsInState('CutIdle') )
	{
	  GotoState('preAttackCheck');
	}
  }
  
 begin:
  LoopAnim('Idle');
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
}

state jumpOffWall
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);

	if ( jumpDistance > 0 )
	{
	  SetLocation(Location + (vDirectionVector*(200 * deltaTime)));
	  jumpDistance -= (200 * DeltaTime);
	}
	else
	{
	  gotoState('StartLandingFromJump');
	}
  }
  
  function Vector findWallNormal()
  {
    local Vector newNormal;
    local Vector X;
    local Vector Y;
    local Vector Z;
  
    GetAxes(Rotation,X,Y,Z);
    newNormal = Z;
    return newNormal;
  }
  
 begin:
  vDirectionVector = findWallNormal();
  PlayAnim('walk2jump');
}

state StartLandingFromJump
{
  function Landed (Vector HitNormal)
  {
    GotoState('LandFromJump');
  }
  
 begin:
  // SetPhysics(1);
  SetPhysics(PHYS_Walking);
  bCollideWorld = True;
  rRotationVector = rotator(PlayerHarry.Location - Location);
  rRotationVector.Pitch = 0;
  DesiredRotation = rRotationVector;
}

state LandFromJump
{
begin:
  PlayAnim('Landed');
  FinishAnim();
  GotoState('checkForwardDistance');
}

state waitingForTrigger
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    if ( bJumper == False )
    {
      GotoState('checkForwardDistance');
    } else {
      GotoState('jumpOffWall');
    }
  }
  
 begin:
  LoopAnim('Idle');
}

state RandomWait
{
begin:
  LoopAnim('Idle');
  Sleep(FRand() * 2);
  GotoState('Wander');
}

state ImLost
{
begin:
  MoveToward(PlayerHarry);
  Sleep(1.5);
  GotoState('Wander');
}

state FellInAHole
{
begin:
  Destroy();
}

defaultproperties
{
    numSpellsDefault=1

    leaveDeadSpider=0.20

    NormalSpeed=75.00

    attackSpeed=100.00

    canWander=True

    jumpDistance=75.00

    jumpingDistanceFromHarry=250.00

    bDespawnable=True

    bThrownObjectDamage=True

    GroundSpeed=100.00

    AirSpeed=200.00

    AccelRate=4000.00

    MaxStepHeight=10.00

    AirControl=2.00

    BaseEyeHeight=30.00

    EyeHeight=30.00

    MenuName="Spider"

    IdleAnimName=Walk

    Mesh=SkeletalMesh'HPModels.skSpiderLargeMesh'

    AmbientGlow=200

    CollisionRadius=40.00

    CollisionHeight=30.00

    Mass=1.00

    RotationRate=(Pitch=100000,Yaw=100000,Roll=100000)

}
