//================================================================================
// DecanterSpawn.
//================================================================================

class DecanterSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.spawner_decanter',Closing=None,Spawning=None)

    Limits=(Max=2,Min=2)

    StartBone=StartBone

    StartPos=(X=0.00,Y=0.00,Z=0.00)

    Mesh=SkeletalMesh'HPModels.skdecanterMesh'

    DrawScale=2.50

    AmbientGlow=75

    CollisionRadius=16.00

    // CollideType=0
	CollideType=CT_AlignedCylinder
}
