//================================================================================
// SpiderSmall.
//================================================================================

class SpiderSmall extends Spider;

var Vector vDir;
var Vector attackLocation;
var Rotator Rot;
var int iteratorCheck;
var int randNum;
var name BoneName;
var Vector pivotAmount;
var Sound spiderBiteSound;
var Vector BonePosition;
var Rotator currentRotation;

function Timer ()
{
  Destroy();
}

function bool harryIsStill ()
{
  if ( VSize(PlayerHarry.Velocity) < 5 )
  {
    return True;
  }
  return False;
}

state preAttackCheck
{
begin:
  GotoState('Attack');
}

state Attack
{
  function HitWall (Vector HitNormal, Actor HitWall)
  {
    if ( HitWall != PlayerHarry )
    {
      if ( Floor == Vec(0.0,0.0,1.0) )
      {
        Acceleration *=  -HitNormal * 10;
      } else {
        Acceleration *= HitNormal * 10;
      }
      GotoState('Wander');
    }
  }
  
  function Bump (Actor Other)
  {
    Touch(Other);
  }
  
  function Touch (Actor Other)
  {
    Super.Touch(Other);
    if ( Other.IsA('harry') )
    {
      if ( VSize(PlayerHarry.Velocity) < 5 )
      {
        Velocity = vect(0.00,0.00,0.00);
        Acceleration = vect(0.00,0.00,0.00);
      } else {
        PlayerHarry.ClientMessage(string(Name) $ " is Squished. From state " $ string(GetStateName()));
        playSquishSound();
        GotoState('DeadSpider');
      }
    }
  }
  
  function UnTouch (Actor Other)
  {
    Super.UnTouch(Other);
    if ( Other.IsA('SpiderStickyWeb') )
    {
      GroundSpeed = NormalSpeed;
    }
  }
  
 begin:
  vDir = Normal(PlayerHarry.Location - Location);
  SetRotation(rotator(vDir));
  MoveToward(PlayerHarry);
  // if ( (harryIsStill() == True) && (VSize2D(PlayerHarry.Location - Location) > 30) )
  while ( (harryIsStill() == True) && (VSize2D(PlayerHarry.Location - Location) > 30) )
  {
    Sleep(0.2);
    vDir = Normal(PlayerHarry.Location - Location);
    SetRotation(rotator(vDir));
    MoveToward(PlayerHarry);
    currentRotation = Rotation;
    currentRotation.Pitch = 0;
    SetRotation(currentRotation);
    // goto JL002E;
  }
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  if ( harryIsStill() == False )
  {
    GotoState('ChaseHarry');
  } else {
    GotoState('AttachToHarry');
  }
}

state ChaseHarry
{
begin:
  vDir = Normal(PlayerHarry.Location - Location);
  SetRotation(rotator(vDir));
  currentRotation = Rotation;
  currentRotation.Pitch = 0;
  SetRotation(currentRotation);
  MoveToward(PlayerHarry);
  Sleep(0.2);
  GotoState('Wander');
}

state AttachToHarry
{
  function BeginState ()
  {
    iteratorCheck = 10;
  }
  
  function EndState ()
  {
  }
  
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    iteratorCheck--;
    if ( iteratorCheck < 0 )
    {
      iteratorCheck = 10;
      if ( harryIsStill() == False )
      {
        StopSound(squishSound,SLOT_None);
        Detach(PlayerHarry);
        SetOwner(None);
        // SetPhysics(2);
		SetPhysics(PHYS_Falling);
        PrePivot = vect(0.00,0.00,0.00);
        GotoState('moveToMarker');
      } else {
        PlaySound(spiderBiteSound,SLOT_None,RandRange(0.62,1.0),,200.0,RandRange(0.81,1.25),,False);
      }
    }
  }
  
 begin:
  randNum = Rand(3);
  switch (randNum)
  {
    case 0:
    BoneName = 'Cloak01 Tail1';
    pivotAmount = Vec(FRand() * 12,FRand() * 2,17.0);
    break;
    case 1:
    BoneName = 'Cloak02 Ponytail2';
    pivotAmount = Vec(FRand() * 16,2.0,19.0);
    break;
    case 2:
    BoneName = 'Cloak02 Ponytail2';
    pivotAmount = Vec(FRand() * 16,-2.0,19.0);
    break;
    default:
    BoneName = 'Cloak01 Tail1';
    pivotAmount = Vec(FRand() * 12,FRand() * 2,17.0);
    break;
  }
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  BonePosition = BonePos(BoneName);
  BonePosition.Z = Location.Z;
  MoveTo(BonePosition);
  Sleep(0.05);
  vDir = vector(PlayerHarry.Rotation);
  Rot = rotator(vDir);
  Rot.Yaw += 32768;
  SetRotation(Rot);
  SetOwner(PlayerHarry);
  AttachToOwner(BoneName);
  PrePivot = pivotAmount;
}

state DeadSpider
{
begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  currentRotation = Rotation;
  currentRotation.Pitch = 0;
  SetRotation(currentRotation);
  LoopAnim('Idle');
  SetTimer(leaveDeadSpider,False);
}

defaultproperties
{
    spiderBiteSound=Sound'HPSounds.Critters_sfx.spider_small_movement'

    leaveDeadSpider=0.50

    attackSpeed=105.00

    fDamageAmount=1.00

    MaxStepHeight=5.00

    SightRadius=300.00

    MenuName="SpiderSmall"

    Mesh=SkeletalMesh'HPModels.skSpiderSmallMesh'

    AmbientGlow=65

    CollisionRadius=10.00

    CollisionHeight=7.00

    bBlockActors=False

    bBlockPlayers=False

    RotationRate=(Pitch=50000,Yaw=50000,Roll=50000)

}
