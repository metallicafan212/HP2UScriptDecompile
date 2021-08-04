//================================================================================
// FlyingFordWindTrigger.
//================================================================================

class FlyingFordWindTrigger extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var FlyingFordDirector Director;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	foreach AllActors(Class'FlyingFordDirector',Director)
	{
		break;
	}
}

function Touch (Actor Other)
{
	local FlyingFordWind Wind;

	Super.Touch(Other);
	if ( Other.IsA('harry') )
	{
		if ( !bTouch )
		{
			bTouch = True;
			Director.OnTouchEvent(self,Other);
			Wind = FlyingFordWind(Owner);
			if ( Wind != None )
			{
				Wind.StartWind();
			}
		}
	}
}

function UnTouch (Actor Other)
{
	local FlyingFordWind Wind;

	Super.UnTouch(Other);
	if ( Other.IsA('harry') )
	{
		bTouch = False;
		Director.OnUnTouchEvent(self,Other);
		Wind = FlyingFordWind(Owner);
		if ( Wind != None )
		{
		Wind.StopWind();
		}
	}
}

function Bump (Actor Other)
{
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("I have been bumped ");
	}
	Touch(Other);
}

auto state triggerBegin
{
}

defaultproperties
{
    bHidden=False

    Tag=''

    CollisionRadius=0.00

    CollisionHeight=400.00

    bCollideActors=True

    bCollideWorld=True

}