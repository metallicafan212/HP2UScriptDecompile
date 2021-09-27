//================================================================================
// Knightspawn.
//================================================================================

class Knightspawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn(0)=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.knight_hit',Closing=None,Spawning=None)

    StartPos=(X=0.00,Y=0.00,Z=65.00)

    GoodieDelay=0.25

    Lives=3

    CentreOffset=(X=0.00,Y=0.00,Z=40.00)

    Mesh=SkeletalMesh'HProps.skKnightMesh'

    DrawScale=1.50

    AmbientGlow=60

    CollisionRadius=11.00

    CollisionWidth=28.00

    CollisionHeight=60.00

    // CollideType=2
	CollideType=CT_Box

    bBlockCamera=True
}
