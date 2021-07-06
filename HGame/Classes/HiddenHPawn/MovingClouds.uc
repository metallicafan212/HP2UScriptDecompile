//================================================================================
// MovingClouds.
//================================================================================

class MovingClouds extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var() float fFrontOffset;
var() float fSideOffset;
var() bool bFollowCar;
var() bool bFollowPath;
var Vector vCloudLocation;
var Vector vDir;
var Director Director;

function PostBeginPlay()
{
	foreach AllActors(Class'Director',Director)
	{
		break;
	}
	vCloudLocation = FindLocation();
	SetLocation(vCloudLocation);
}

function Touch (Actor Other)
{
	Director.OnTouchEvent(self,Other);
}

function UnTouch (Actor Other)
{
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

function bool PassedClouds()
{
	local Vector vCarLocation;
	local Vector vStraightDir;
	local Vector vCarDir;

	vStraightDir 	=  -Vector(Rotation);
	vCarDir 		= Vector(PlayerHarry.Rotation);
	if ( vStraightDir Dot vCarDir < 0 )
	{
		ClientMessage("We have passed the clouds");
		return True;
	}
	return False;
}

function Vector FindLocation()
{
	local Rotator Direction;
	local Vector vOffset;
	local Vector vLocation;

	Direction 		= PlayerHarry.Rotation;
	Direction.Yaw 	= Direction.Yaw + fSideOffset;
	vOffset 		= Vector(Direction) * fFrontOffset;
	vLocation 		= PlayerHarry.Location + vOffset;
	return vLocation;
}

function Vector FindLocationFromPath()
{
	local Rotator Direction;
	local Vector vOffset;
	local Vector vLocation;
	local PatrolPoint PPClosestToCar;
	local PatrolPoint PPClosestToCarNext;
	local PatrolPoint PPClosestToLine;
	local PatrolPoint PPClosestToLineNext;
	local Rotator lineRotation;
	local Rotator destRotation;
	local Vector fLine;
	local float fDistanceFromPoint;

	PPClosestToCar 		= FindNearestPatrolPoint(PlayerHarry.Location);
	PPClosestToCarNext 	= PPClosestToCar.NextPatrolPoint;
	lineRotation 		= rotator(PPClosestToCarNext.Location - PPClosestToCar.Location);
	fLine 				= PlayerHarry.Location + Vector(lineRotation) * fFrontOffset;
	PPClosestToLine 	= FindNearestPatrolPoint(fLine);
	fDistanceFromPoint 	= VSize2D(PPClosestToLine.Location - fLine);
	if ( PPClosestToLine.NextPatrolPoint != None )
	{
		PPClosestToLineNext = PPClosestToLine.NextPatrolPoint;
		destRotation 		= rotator(PPClosestToLineNext.Location - PPClosestToLine.Location);
	} 
	else 
	{
		destRotation = PPClosestToLine.Rotation;
	}
	destRotation.Yaw 	= destRotation.Yaw + fSideOffset;
	vOffset 			= Vector(destRotation) * fDistanceFromPoint;
	vLocation 			= PPClosestToLine.Location + vOffset;
	return vLocation;
}

function PatrolPoint FindNearestPatrolPoint (Vector Loc)
{
	local PatrolPoint tempPatrolPoint;
	local PatrolPoint ClosestPoint;
	local float fDist;
	local float fClosestDist;
	local Vector vLocation;

	vLocation = Loc;
	fClosestDist = 1000000.0;
	foreach AllActors(Class'PatrolPoint',tempPatrolPoint)
	{
		fDist = VSize(vLocation - tempPatrolPoint.Location);
		if ( fDist < fClosestDist )
		{
		fClosestDist = fDist;
		ClosestPoint = tempPatrolPoint;
		}
	}
	return ClosestPoint;
}

function Tick (float DeltaTime)
{
	local Vector vDirection;
	local Rotator vRot;

	if ( bFollowPath )
	{
		vCloudLocation = FindLocationFromPath();
	}
	if ( bFollowCar )
	{
		vCloudLocation = FindLocation();
	}
	SetLocation(vCloudLocation);
}

defaultproperties
{
    fFrontOffset=100.00

    fSideOffset=8191.00

    bFollowCar=True

    attachedParticleClass(0)=Class'HPParticle.FlyingClouds'

    bHidden=False

    Tag=''

    DrawScale=5.00

    CollisionRadius=35.00

    CollisionHeight=32.00

}