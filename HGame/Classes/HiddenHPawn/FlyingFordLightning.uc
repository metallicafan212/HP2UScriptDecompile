//================================================================================
// FlyingFordLightning.
//================================================================================

class FlyingFordLightning extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var FlyingFordDirector Director;
var() name stormName;
var() float fLightningViolence;
var() int iLightningLoops;
var() float fTimeBetweenchanges;

function PostBeginPlay()
{
	foreach AllActors(Class'FlyingFordDirector',Director)
	{
		break;
	}
}

function Touch (Actor Other)
{
	if ( Other.IsA('harry') )
	{
		if ( !bTouch )
		{
			bTouch = True;
			Director.OnTouchEvent(self,Other);
		}
	}
}

function UnTouch (Actor Other)
{
	Super.UnTouch(Other);
	if ( Other.IsA('harry') )
	{
		Director.OnUnTouchEvent(self,Other);
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

defaultproperties
{
    fLightningViolence=5.00

    iLightningLoops=15

    fTimeBetweenchanges=0.20

    Tag=''

    CollisionRadius=35.00

    CollisionHeight=32.00

    bCollideActors=True

    bCollideWorld=True

}