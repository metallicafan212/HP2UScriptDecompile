//================================================================================
// PixieMarker.
//================================================================================

class PixieMarker extends Actor;

const BOOL_DEBUG_AI= false;
var() name GroupName;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  SetCollision(,,);
  bCollideWorld = False;
}

function PostBeginPlay ()
{
  SetCollision(True,False,False);
}

function Touch (Actor Other)
{
  Super.Touch(Other);
}

function UnTouch (Actor Other)
{
  Super.UnTouch(Other);
}

function Bump (Actor Other)
{
  Touch(Other);
}

defaultproperties
{
    GroupName="'"

    bHidden=True

    Tag="'"

    Texture=Texture'HGame.HiddenPawn'

    CollisionRadius=50.00

    CollisionHeight=5.00

}
