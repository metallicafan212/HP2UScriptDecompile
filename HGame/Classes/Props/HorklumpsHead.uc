//================================================================================
// HorklumpsHead.
//================================================================================

class HorklumpsHead extends HProp;

const BOOL_DEBUG_AI= false;
var Rotator vMoveDirRot;
var Vector vMoveDir;
var float fRotVel;
var bool bFalling;
var float tempX;
var float tempY;
var Vector HeadLocation;
var Rotator HeadRotation;

function PostBeginPlay()
{
  tempX = FRand() * 4.0;
  tempY = FRand() * 4.0;
  if ( Rand(2) == 0 )
  {
    tempX =  -tempX;
  }
  if ( Rand(2) == 0 )
  {
    tempY =  -tempY;
  }
}

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( IsInState('stateBeingThrown') )
  {
    bObjectCanBePickedUp = False;
  }
}

function Landed (Vector HitNormal)
{
  bFalling = False;
}

function ThrownLanded (Vector HitNormal)
{
  if ( BOOL_DEBUG_AI )
  {
    PlayerHarry.ClientMessage("Thrown and Landed");
  }
  ShootPoison();
}

function ShootPoison()
{
  if ( BOOL_DEBUG_AI )
  {
    PlayerHarry.ClientMessage("Shoot Poison");
  }
  HeadLocation = Location;
  HeadRotation = Rotation;
  Destroy();
  PlaySound(Sound'horklump_mushroom_head_explode',SLOT_Misc,RandRange(0.62,1.0),,95000.0,RandRange(0.81,1.25),,False);
  Spawn(Class'ThrownPoisonCloud',self,,HeadLocation,HeadRotation);
}

auto state fallOver
{
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    if ( bFalling == True )
    {
      SetLocation(Location + Vec(tempX,tempY,0.0));
    }
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    if ( BOOL_DEBUG_AI )
    {
      PlayerHarry.ClientMessage("Hit the wall");
    }
    SetLocation(OldLocation);
    vMoveDirRot = rotator(HitNormal);
    vMoveDirRot.Yaw += 65536.0 * (8.0 / 20.0) / 2.0 * ((FRand() * 2.0) - 1.0);
    vMoveDirRot.Roll = 0;
    GotoState('TurnToNewDir');
  }
  
 begin:
  vMoveDir.X = 1.0;
  vMoveDir.Y = 1.0;
  vMoveDir.Z = 1.0;
  vMoveDirRot = Rotation;
  vMoveDirRot.Yaw += 16384 * (8.0 / 20.0) / 2.0 * ((FRand() * 2.0) - 1.0);
  fRotVel = 0.0;
  SetRotation(rotator(vMoveDir));
}

state TurnToNewDir
{
begin:
  LoopAnim('Idle');
  Sleep(0.5);
  TurnTo(Location + vMoveDir);
  GotoState('fallOver');
}

defaultproperties
{
    bFalling=True

    bObjectCanBePickedUp=True

    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HPModels.skhorklumpsHeadMesh'

    AmbientGlow=65

    CollisionRadius=10.00

    CollisionHeight=7.00

    bBlockActors=False
}
