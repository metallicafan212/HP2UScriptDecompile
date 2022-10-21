//================================================================================
// PixieMarker.
//================================================================================

class PixieMarker extends Actor;

//texture import -AdamJD
#exec Texture Import File=Textures\HiddenPawn.PNG Name=HiddenPawn COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

const BOOL_DEBUG_AI= false;
var() name GroupName;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  SetCollision(,,);
  bCollideWorld = False;
}

function PostBeginPlay()
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
    //GroupName="'"
	//fix for KW using '' instead of "" and added the name (to be compatible with the new engine) -AdamJD
    GroupName="None"

    bHidden=True

    //Tag="'"
	//fix for KW using '' instead of "" and added the name (to be compatible with the new engine) -AdamJD
    Tag="PixieMarker"

    Texture=Texture'HGame.HiddenPawn'

    CollisionRadius=50.00

    CollisionHeight=5.00
}
