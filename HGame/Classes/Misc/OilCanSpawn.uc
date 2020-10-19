//================================================================================
// OilCanSpawn.
//================================================================================

class OilCanSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.spawner_oil_can',Closing=None,Spawning=None)

    Limits=(Max=4,Min=3)

    StartBone=StartBone

    GoodieDelay=0.10

    Lives=2

    Mesh=SkeletalMesh'HPModels.skoilcanMesh'

    DrawScale=3.00

    AmbientGlow=75

    CollisionRadius=16.00

    CollisionHeight=20.00

    // CollideType=0
	CollideType=CT_AlignedCylinder
}
