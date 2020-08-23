//================================================================================
// SpawnThingy.
//================================================================================

class SpawnThingy extends Triggers;

var() Class<Actor> SpawnClass;
var() float fVelocityModifier;
var() name SpawnTag;
var() bool bThrowItem;
var() bool bKeepingTryingSpawnZOnly;
var() float fAdditionalZVelocity;
var(SpawnThingyPatrol) name nameFirstPatrolPoint;
var(SpawnThingyPatrol) bool bLoopPatrolPath;

function Trigger (Actor Other, Pawn Instigator)
{
  local Actor SpawnedObject;
  local Vector Vel;
  local Rotator SpawnDirection;

  if ( SpawnClass != None )
  {
    if ( SpawnTag != 'None' )
    {
      SpawnedObject = FancySpawn(SpawnClass,,SpawnTag,Location,,bKeepingTryingSpawnZOnly);
    } else {
      SpawnedObject = FancySpawn(SpawnClass,,,Location,,bKeepingTryingSpawnZOnly);
    }
    if ( (nameFirstPatrolPoint != 'None') && SpawnedObject.IsA('HPawn') )
    {
      HPawn(SpawnedObject).firstPatrolPointObjectName = nameFirstPatrolPoint;
      HPawn(SpawnedObject).bLoopPath = bLoopPatrolPath;
    }
    if ( bThrowItem || SpawnedObject.IsA('Jellybean') && bDirectional )
    {
      Vel.X = 96.0 - 32 + Rand(64);
      Vel.Y = 0.0;
      Vel.Z = 40.0 + fAdditionalZVelocity;
      Vel = Vel >> Rotation;
      SpawnedObject.Velocity = Vel * fVelocityModifier;
      SpawnedObject.SetPhysics(/*2*/PHYS_Falling);
    }
  }
}

defaultproperties
{
    fVelocityModifier=1.00

    // Style=2
	Style=STY_Masked
	
    Texture=Texture'SthingE'
}