//================================================================================
// FlipendoVaseBronzeShard.
//================================================================================

class FlipendoVaseBronzeShard extends HFlipendo;

var Rotator randrot;
var bool tickOn;

auto state Fall
{
  function Tick (float DeltaTime)
  {
    local Vector Loc;
  
  }
  
  function Touch (Actor Other)
  {
    if ( Other == PlayerHarry )
    {
      Destroy();
    }
  }
  
  function initfall()
  {
    local Rotator randx;
  
    DesiredRotation = RotRand();
    RotationRate.Yaw = Rand(40000);
    RotationRate.Pitch = Rand(40000);
    RotationRate.Roll = Rand(40000);
    randx.Yaw = Rand(65536);
    Velocity = Normal(vector(randx)) * RandRange(50.0,300.0);
    Velocity.Z = RandRange(80.0,300.0);
  }
  
 begin:
  initfall();
  DrawScale = RandRange(1.0,4.0);
  tickOn = True;
  Sleep(RandRange(1.0,2.0));
  tickOn = False;
  Destroy();
}

defaultproperties
{
    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HProps.skFlipendoVaseBronzeShardMesh'

    CollisionRadius=1.00

    CollisionHeight=1.00
}
