//================================================================================
// FlyingFordPathGuide.
//================================================================================

class FlyingFordPathGuide extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var Director Director;
var name PathName;
var float AirSpeedNormal;

function PostBeginPlay()
{
	foreach AllActors(Class'Director',Director)
	{
		break;
	}
	SetCollision(False,False,False);
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
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("I have been bumped ");
	}
	Touch(Other);
}

auto state startFlying
{
	begin:
		FollowSplinePath(PathName,AirSpeedNormal,0.0,);
}

defaultproperties
{
    //Tag=''
	//fix for KW using '' instead of "" and added the name (to be compatible with the new engine) -AdamJD
    Tag="FlyingFordPathGuide"

    DrawType=DT_Mesh

    Mesh=SkeletalMesh'HPModels.skfirecrabMesh'

    CollisionRadius=200.00

    CollisionHeight=50.00
}