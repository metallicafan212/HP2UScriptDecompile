//================================================================================
// PixieMarker.
//================================================================================

class PixieMarker extends Actor;

//texture import -AdamJD
#exec Texture Import File=Textures\HiddenPawn.PNG Name=HiddenPawn COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914

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
