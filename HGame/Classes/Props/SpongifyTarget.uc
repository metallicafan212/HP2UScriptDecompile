//================================================================================
// SpongifyTarget.
//================================================================================

class SpongifyTarget extends HProp;

//texture import -AdamJD
#exec Texture Import File=Textures\SpongifyTargetTexture.PNG Name=SpongifyTargetTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2

function PreBeginPlay()
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