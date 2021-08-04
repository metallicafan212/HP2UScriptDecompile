//================================================================================
// PixieDust.
//================================================================================

class PixieDust extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var float fLifetime;
var float timeSafe;
var bool bCanBeTouched;
var() int sleepyInterval;

function PostBeginPlay()
{
	SetTimer(fLifetime,False);
	bCollideWorld = True;
}

function Timer()
{
	Destroy();
}

function Touch (Actor Other)
{
	if ( (Other == PlayerHarry) && (bCanBeTouched) )
	{
		bCanBeTouched = False;
		if ( !baseHUD(PlayerHarry.myHUD).bCutSceneMode )
		{
			PlayerHarry.SleepyAnimTimerAdd(sleepyInterval);
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

defaultproperties
{
    bTouch=True

    fLifetime=5.00

    bCanBeTouched=True

    sleepyInterval=2

    attachedParticleClass(0)=Class'HPParticle.PixieGroundDust'

    Physics=PHYS_Falling

    DrawType=DT_None

    CollisionRadius=25.00

    CollisionHeight=32.00

    bCollideActors=True

    bCollideWorld=True

    Mass=10.00

}