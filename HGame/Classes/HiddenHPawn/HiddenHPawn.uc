//================================================================================
// HiddenHPawn.
//================================================================================

class HiddenHPawn extends HPawn;

var bool bShowHiddenPawns;

function PreBeginPlay ()
{
	Super.PreBeginPlay();
	SetCollision(,);
	bCollideWorld = False;
	if ( bShowHiddenPawns )
	{
		bHidden 	= False;
		DrawType 	= DT_Sprite;
		Style 		= STY_Normal;
	}
}

defaultproperties
{
    bHidden=True

    DrawType=DT_Sprite

    Texture=Texture'HGame.HiddenPawn'

    Mesh=None

    CollisionRadius=2.00

    CollisionHeight=2.00

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

}