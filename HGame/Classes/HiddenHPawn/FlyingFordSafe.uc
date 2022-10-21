//================================================================================
// FlyingFordSafe.
//================================================================================

class FlyingFordSafe extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var Director Director;

function PostBeginPlay()
{
	foreach AllActors(Class'Director',Director)
	{
		break;
	}
}

function Touch (Actor Other)
{
	if ( !bTouch )
	{
		bTouch = True;
		Director.OnTouchEvent(self,Other);
	}
}

function UnTouch (Actor Other)
{
	bTouch = False;
	Director.OnUnTouchEvent(self,Other);
}

function Bump (Actor Other)
{
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("I have been bumped ");
	}
	Touch(Other);
}

defaultproperties
{
    //Tag=''
	//fix for KW using '' instead of "" and added the name (to be compatible with the new engine) -AdamJD
    Tag="FlyingFordSafe"

    bCollideWhenPlacing=True

    CollisionRadius=35.00

    CollisionHeight=32.00

    bCollideActors=True

    bCollideWorld=True
}