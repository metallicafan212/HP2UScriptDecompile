//================================================================================
// InvisibleSpawn.
//================================================================================

class InvisibleSpawn extends GenericSpawner;

defaultproperties
{
    GoodieToSpawn(0)=Class'Jellybean'

    Snds=(Opening=Sound'HPSounds.General.knight_hit',Closing=None,Spawning=None)

    StartPos=(X=0.00,Y=0.00,Z=65.00)

    GoodieDelay=0.25

    Lives=3

    bHidden=True

    // Physics=0
	Physics=PHYS_None

    CentreOffset=(X=0.00,Y=0.00,Z=40.00)

    // DrawType=1
	DrawType=DT_Sprite

    Mesh=None

    DrawScale=1.50

    AmbientGlow=60

    CollisionRadius=32.00

    CollisionHeight=32.00

    // CollideType=1
	CollideType=CT_OrientedCylinder

    bBlockPlayers=False
}
