//================================================================================
// HorklumpsStem.
//================================================================================

class HorklumpsStem extends HProp;

var Vector V;

auto state wilt
{
begin:
  Sleep(2.0);
  PlayAnim('Die');
  FinishAnim();
}

defaultproperties
{
    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HPModels.skhorklumpsStemMesh'

    AmbientGlow=65

    CollisionRadius=5.00

    CollisionHeight=7.00

    bCollideActors=False

    bBlockActors=False
}
