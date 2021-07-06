//================================================================================
// FlyingFordHedwig.
//================================================================================

class FlyingFordHedwig extends HiddenHPawn;

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
    bHidden=False

    bTrailerSameRotation=True

    bTrailerPrePivot=True

    Tag=''

    DrawType=DT_Mesh

    Mesh=SkeletalMesh'HPModels.skowlbarnMesh'

    DrawScale=1.20

    CollisionRadius=35.00

    CollisionHeight=32.00

}