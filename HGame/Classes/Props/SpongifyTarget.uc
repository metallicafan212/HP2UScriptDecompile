//================================================================================
// SpongifyTarget.
//================================================================================

class SpongifyTarget extends HProp;

function PreBeginPlay ()
{
	SetCollision(False,False,False);
}

defaultproperties
{
    bStatic=True

    bHidden=True

    //DrawType=1
	DrawType=DT_Sprite

    Texture=Texture'HGame.SpongifyTargetTexture'

    Mesh=None

    CollisionRadius=16.00

    CollisionWidth=16.00

    CollisionHeight=16.00

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False
}