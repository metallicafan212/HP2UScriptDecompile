//================================================================================
// SpikyPlantHeadSpikes.
//================================================================================

class SpikyPlantHeadSpikes extends HProp;

const BOOL_DEBUG_AI= false;
var Rotator vMoveDirRot;
var Vector vMoveDir;
var float fRotVel;
var bool bFalling;
var float tempX;
var float tempY;
var float scaleIncrement;

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

function Landed (Vector HitNormal)
{
  bFalling = False;
}

function ThrownLanded (Vector HitNormal)
{
  ShootSpikes();
}

function ShootSpikes()
{
  local int I;
  local int NumSpikes;
  local Rotator rotate_spike;
  local Vector spike_locn;
  local Vector harrys_head;

  harrys_head = PlayerHarry.Location;
  harrys_head.Z += PlayerHarry.CollisionHeight / 2;
  NumSpikes = 8;
  rotate_spike = rotator(harrys_head - Location);
  Log("Spike aim" @ string(rotate_spike));
  rotate_spike.Roll = 0;
  rotate_spike.Pitch += (65536 * 3) / 4;
  if ( Rand(2) == 0 )
  {
    Spawn(Class'Explosion_01',self,,Location,Rotation);
  } else {
    Spawn(Class'SmokeExplo_01',self,,Location,Rotation);
  }
  // I = 0;
  // if ( I < NumSpikes )
  for(I = 0; I < NumSpikes; ++I)
  {
    rotate_spike.Yaw = (65536 / NumSpikes) * I;
    spike_locn = Location;
    spike_locn.Z += DrawScale * 3;
    Spawn(Class'ThrownSpike',self,,spike_locn,rotate_spike);
    // ++I;
    // goto JL00C4;
  }
  Destroy();
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
    if ( DrawScale > 1.0 )
    {
      DrawScale -= scaleIncrement;
    } else //{
      if ( DrawScale < 1.0 )
      {
        DrawScale = 1.0;
      }
    //}
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
    vMoveDirRot.Pitch = 0;
	vMoveDirRot.Roll = 0;
    GotoState('TurnToNewDir');
  }
  
 begin:
  vMoveDir.X = 1.0;
  vMoveDir.Y = 1.0;
  vMoveDir.Z = 1.0;
  vMoveDirRot = Rotation;
  vMoveDirRot.Yaw += 16384 * (8.0 / 20.0) / 2.0 * ((FRand() * 2.0) - 1.0);
  vMoveDirRot.Pitch += 8191 * (8.0/ 20.0) / 2.0 * ((FRand() * 2.0) - 1.0);
  vMoveDirRot.Roll += 16384 * (8.0/ 20.0) / 2.0 * ((FRand() * 2.0) - 1.0);
  vMoveDir = vMoveDir >> vMoveDirRot;
  fRotVel = 0.0;
  SetRotation(rotator(vMoveDir));
}

state TurnToNewDir
{
begin:
  LoopAnim('Idle');
wait:
  Sleep(0.5);
  TurnTo(Location + vMoveDir);
  GotoState('fallOver');
}

defaultproperties
{
    bFalling=True

    scaleIncrement=0.10

    bObjectCanBePickedUp=True

    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HPModels.skSpikyPlantHeadSpikesMesh'

    AmbientGlow=65

    CollisionRadius=25.00

    CollisionHeight=17.00
}
