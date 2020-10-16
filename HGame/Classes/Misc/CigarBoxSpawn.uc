//================================================================================
// CigarBoxSpawn.
//================================================================================

class CigarBoxSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.spawner_cigar_box',Closing=None,Spawning=None)

    Limits=(Max=3,Min=2)

    StartPos=(X=0.00,Y=0.00,Z=20.00)

    GoodieDelay=0.10

    Lives=2

    // eVulnerableToSpell=1
	eVulnerableToSpell=SPELL_Alohomora

    DrawScale=2.50

    AmbientGlow=75

    CollisionRadius=17.00

    CollisionWidth=22.00

    CollisionHeight=18.00

    // CollideType=2
	CollideType=CT_Box
}
