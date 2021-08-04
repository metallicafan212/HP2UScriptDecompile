//================================================================================
// GestureSprite.
//================================================================================

class GestureSprite extends Sprite;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  SetCollision(,,);
  bCollideWorld = False;
}

defaultproperties
{
    bHidden=True

    Texture=None

    CollisionRadius=2.00

    CollisionHeight=2.00

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

}
