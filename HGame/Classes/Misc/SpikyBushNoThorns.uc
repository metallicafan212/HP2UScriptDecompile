//================================================================================
// SpikyBushNoThorns.
//================================================================================

class SpikyBushNoThorns extends HChar;

auto state Wilted
{
  event AnimEnd ()
  {
    SetCollision(False,False,False);
    SetCollisionSize(0.0,0.0);
  }
  
 begin:
  Log("spiky bush wilting...");
  PlayAnim('wither');
  Sleep(1.0);
  PlaySound(Sound'spiky_bush_wilt',SLOT_None);
}

defaultproperties
{
    Mesh=SkeletalMesh'HPModels.skspikybushnothornsMesh'

    AmbientGlow=65

    CollisionRadius=25.00

    CollisionHeight=20.00

    bCollideActors=False

    bBlockActors=False

    bBlockPlayers=False

    bProjTarget=False

}
