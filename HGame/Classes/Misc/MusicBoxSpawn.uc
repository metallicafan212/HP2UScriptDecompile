//================================================================================
// MusicBoxSpawn.
//================================================================================

class MusicBoxSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.spawner_music_box',Closing=None,Spawning=None)

    Limits=(Max=6,Min=4)

    StartPos=(X=0.00,Y=0.00,Z=20.00)

    Lives=3

    // eVulnerableToSpell=1
	eVulnerableToSpell=SPELL_Alohomora

    Mesh=SkeletalMesh'HPModels.skmusicboxMesh'

    DrawScale=2.00

    AmbientGlow=75

    CollisionRadius=20.00

    CollisionWidth=26.00

    CollisionHeight=16.00

    // CollideType=2
	CollideType=CT_Box
}
