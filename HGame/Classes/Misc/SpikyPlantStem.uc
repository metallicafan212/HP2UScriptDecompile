//================================================================================
// SpikyPlantStem.
//================================================================================

class SpikyPlantStem extends HProp;

var float scaleIncrement;

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( DrawScale > 0.75 )
  {
    DrawScale -= scaleIncrement;
  } else //{
    if ( DrawScale < 0.75 )
    {
      DrawScale = 0.75;
    }
  //}
}

defaultproperties
{
    scaleIncrement=0.10

    Mesh=SkeletalMesh'HPModels.skSpikyPlantStemMesh'

    AmbientGlow=65

    CollisionRadius=20.00

    CollisionHeight=4.00

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

}
