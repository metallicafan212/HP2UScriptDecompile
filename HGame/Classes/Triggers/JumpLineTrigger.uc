//================================================================================
// JumpLineTrigger.
//================================================================================

class JumpLineTrigger extends Trigger;

var() bool bEnabled;
var() float MinCosTrigger;
var() float ForceJumpForward;
var() float fHorizSpeedMultiplier;

static function Vector GetFacing (Actor A)
{
	return Vec(1.0,0.0,0.0) >> A.Rotation;
}

function MakeJump (Actor Actor)
{
	local Vector Dir;

	Dir = Normal(Actor.Velocity) * (1 - ForceJumpForward) + GetFacing(self) * ForceJumpForward;
	Actor.Velocity = Pawn(Actor).GroundSpeed * Normal(Dir) * fHorizSpeedMultiplier;
	PlayerPawn(Actor).Jump();
}

function Tick (float t)
{
	local Vector Facing;
	local Vector other_facing;
	local actor TouchingAct;
	
	if (  !bEnabled )
	{
		return;
	}
	
	Facing = GetFacing(self);
	
	foreach TouchingActors(class'Actor', TouchingAct)
	{
		if ( PlayerPawn(TouchingAct) != None )
		{
			if ( ((TouchingAct.Location - Location) Dot Facing >= 0.0) && ((TouchingAct.OldLocation - Location) Dot Facing < 0.0) )
			{
				other_facing = GetFacing(TouchingAct);
				if ( other_facing Dot Facing >= MinCosTrigger )
				{
					MakeJump(TouchingAct);
				}
			}
		}
	}
}

defaultproperties
{
    ForceJumpForward=1.00

    fHorizSpeedMultiplier=1.00

    bDirectional=True

}
