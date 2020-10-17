//================================================================================
// HorklumpsLump.
//================================================================================

class HorklumpsLump extends HProp;

function Touch (Actor Other)
{
  Super.Touch(Other);
  if ( Other != PlayerHarry )
  {
    return;
  }
  PlayerHarry.TakeDamage(1,self,Location,vect(0.00,0.00,0.00),'None');
  Spawn(Class'PoisonCloud',self,,Location,Rotation);
  Destroy();
}

function HitWall (Vector HitNormal, Actor Wall)
{
  PlayerHarry.ClientMessage("Hit wall ...........................hit");
  Spawn(Class'PoisonCloud',self,,Location,Rotation);
  Destroy();
}

defaultproperties
{
    // Physics=1
	Physics=PHYS_Walking

    Mesh=SkeletalMesh'HPModels.skhorklumpchunkMesh'

    DrawScale=1.20

    CollisionRadius=2.00

    CollisionHeight=2.00

    bBlockActors=False

    bBlockPlayers=False

    bBounce=True
}
