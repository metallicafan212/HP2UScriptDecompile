//================================================================================
// FOVController.
//================================================================================
// Omega: Fix the desired fov issue

class FOVController extends Actor;

const EaseFromB= -0.171573;
const EaseFromM=  1.171573;
const EaseFromY=  0.171573;
const EaseFromX=  0.2928932188;
var() float FOVTime;
var() float FOVEnd;
var float FOVStart;
var float CurTime;
var harry PlayerHarry;
var bool bEaseTo;

// Omega: So we can cache it
var float OGDesiredFOV;

function float EaseTo (float t)
{
	if ( t <= 0 )
	{
		return 0.0;
	}
	else
	if ( t < 1 - 0.29289323 )
	{
		return 1.1715734 * t + 0;
	}
	else
	if ( t < 1.0 )
	{
		return 1.0 - 2.0 * (1.0 - t) * (1.0 - t);
	}
	else
	{
		return 1.0;
	}
}

event BeginPlay ()
{
	Super.BeginPlay();
	PlayerHarry = harry(Level.PlayerHarryActor);
	// Omega: Grab it so we can reset it later
	OGDesiredFOV = PlayerHarry.DesiredFOV;
	DestroyAllFOVControllers();
	FOVStart = PlayerHarry.FovAngle;
}

function Init (float SetFOVEnd, float SetTime, optional bool bInEaseTo)
{
	FOVTime = SetTime;

	// Omega: Dumbass hack. Treat 90 (unless the default here has been changed) as a code word to pull our configured value
	if(SetFOVEnd == Default.FOVEnd)
	{
		//FOVEnd = SetFOVEnd;
		FOVEnd = PlayerHarry.DefaultFOV;
	}
	else
	{
		FOVEnd = SetFOVEnd;
	}

	FOVStart 	= PlayerHarry.FovAngle;
	bEaseTo 	= bInEaseTo;
	PlayerHarry.ClientMessage("FOVController -> FOVStart: " $ string(FOVStart) $ " FOVEnd: " $ string(FOVEnd) $ " FOVTime: " $ string(FOVTime));
}

function DestroyAllFOVControllers ()
{
	local FOVController A;

	foreach AllActors(Class'FOVController',A)
	{
		if ( A != self )
		{
			A.Finish();
		}
	}
}

function CutBypass ()
{
	Finish();
	Super.CutBypass();
}

function Finish ()
{
	PlayerHarry.DesiredFOV = FOVEnd;
	PlayerHarry.FovAngle = FOVEnd;

	//PlayerHarry.DesiredFOV = OGDesiredFOV;
	//PlayerHarry.FovAngle = PlayerHarry.DesiredFOV;

	PlayerHarry.ClientMessage("FOVController -> Finish Called, Start: " $ string(FOVStart) $ " FOVEnd: " $ string(FOVEnd) $ " FOVTime: " $ string(FOVTime));
	Destroy();
}

auto state stateUpdateFOV
{
	event Tick (float fTimeDelta)
	{
		CurTime += fTimeDelta;
		if ( CurTime <= FOVTime )
		{
			if ( bEaseTo )
			{
				PlayerHarry.DesiredFOV = FOVStart + (FOVEnd - FOVStart) * EaseTo(FMin(CurTime / FOVTime,1.0));

				//PlayerHarry.FovAngle = FOVStart + (FOVEnd - FOVStart) * EaseTo(FMin(CurTime / FOVTime,1.0));
			}
			else 
			{
				PlayerHarry.DesiredFOV += (FOVEnd - FOVStart) * FMin(fTimeDelta / FOVTime,1.0);

				//PlayerHarry.FovAngle += (FOVEnd - FOVStart) * FMin(fTimeDelta / FOVTime,1.0); 
			}

			PlayerHarry.FovAngle = PlayerHarry.DesiredFOV;
		}
		else 
		{
			Finish();
		}
	}
}

defaultproperties
{
    FOVTime=2.00

    FOVEnd=90.00

    bHidden=True
}
