//================================================================================
// SpikyPlantSpike.
//================================================================================

class SpikyPlantSpike extends Projectile;

var int Lift;
var int Speed;
var Vector start_location;
var Rotator flight_direction;
var Vector prev_location;
var int start_pitch;
var int iDamage;
var SpikyBushSmoke Smoke;

auto state Flying
{
  function Disintegrate ()
  {
    Destroy();
  }
  
  function Tick (float DeltaTime)
  {
    local Vector locn_diff;
    local Rotator locn_rot;
  
    if ( Physics == PHYS_Falling )
    {
      locn_diff = Location - prev_location;
      if ( VSize2D(locn_diff) > 0.5 )
      {
        locn_rot = rotator(locn_diff);
        locn_rot.Pitch += start_pitch;
        SetRotation(locn_rot);
        prev_location = Location;
      }
      Velocity.Z += Lift * DeltaTime;
      Smoke.Move(Location - Smoke.Location);
    }
  }
  
  function Touch (Actor Other)
  {
    if ( Other.IsA('harry') )
    {
      Other.TakeDamage(iDamage,Pawn(Owner),Location,Velocity * 1,'Spiked');
      Disintegrate();
    }
  }
  
  function Landed (Vector HitNormal)
  {
    Disintegrate();
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    Disintegrate();
  }
  
  function BeginState ()
  {
    Disable('Tick');
    start_location = Location;
    prev_location = Location;
    flight_direction = Rotation;
    flight_direction.Pitch -= (65536 * 3) / 4;
    Velocity.X = Speed;
    Velocity = Velocity >> flight_direction;
    start_pitch = Rotation.Pitch + 16384;
    Smoke = Spawn(Class'SpikyBushSmoke',,,Location);
    // Smoke.SetPhysics(11);
	Smoke.SetPhysics(PHYS_Trailer);
    Enable('Tick');
  }
  
}

defaultproperties
{
    Lift=400

    Speed=300

    // Physics=2
	Physics=PHYS_Falling

    Velocity=(X=300.00,Y=0.00,Z=0.00)

    Mesh=SkeletalMesh'HPModels.skSpikyPlantSpikeMesh'

    AmbientGlow=65

    CollisionRadius=5.00

    CollisionHeight=2.00
}
