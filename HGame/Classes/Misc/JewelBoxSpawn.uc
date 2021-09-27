//================================================================================
// JewelBoxSpawn.
//================================================================================

class JewelBoxSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn(0)=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.spawner_jewel_box',Closing=None,Spawning=None)

    Limits=(Max=6,Min=4)

    Lives=3

    // eVulnerableToSpell=1
	eVulnerableToSpell=SPELL_Alohomora

    Mesh=SkeletalMesh'HPModels.skjewelboxMesh'

    DrawScale=3.00

    AmbientGlow=75

    CollisionRadius=20.00

    CollisionWidth=26.00

    // CollideType=2
	CollideType=CT_Box
}
