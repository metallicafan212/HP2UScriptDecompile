//================================================================================
// TargetPoint.
//================================================================================

class TargetPoint extends HPawn;

defaultproperties
{
    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite

    Texture=Texture'Engine.S_Patrol'

    CollisionRadius=2.00

    CollisionHeight=2.00

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False
}
