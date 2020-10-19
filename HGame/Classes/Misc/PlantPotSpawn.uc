//================================================================================
// PlantPotSpawn.
//================================================================================

class PlantPotSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.spawner_plant_pot',Closing=None,Spawning=None)

    Limits=(Max=3,Min=2)

    StartBone=StartBone

    GoodieDelay=0.20

    Mesh=SkeletalMesh'HPModels.skemptyplantpotMesh'

    DrawScale=3.50

    AmbientGlow=75

    CollisionRadius=20.00

    CollisionHeight=16.00

    // CollideType=0
	CollideType=CT_AlignedCylinder
}
