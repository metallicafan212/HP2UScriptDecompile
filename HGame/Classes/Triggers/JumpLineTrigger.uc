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
  local int I;
  local Vector Facing;
  local Vector other_facing;
  local PlayerPawn pp; //added by me for compatibility code -AdamJD

  if (  !bEnabled )
  {
    return;
  }

  //updated to make this compatible with the new engine -AdamJD
  //
  //for(I = 0; I < ArrayCount(Touching); I++)
  foreach TouchingActors(class'PlayerPawn', pp)
  {
    Facing = GetFacing(self);

	/*
    if ( PlayerPawn(Touching[I]) != None )
    {
      if ( ((Touching[I].Location - Location) Dot Facing >= 0.0) && ((Touching[I].OldLocation - Location) Dot Facing < 0.0) )
      {
        other_facing = GetFacing(Touching[I]);
        if ( other_facing Dot Facing >= MinCosTrigger )
        {
          MakeJump(Touching[I]);
        }
      }
    }
	*/

	if ( pp != None )
    {
      if ( ((pp.Location - Location) Dot Facing >= 0.0) && ((pp.OldLocation - Location) Dot Facing < 0.0) )
      {
        other_facing = GetFacing(pp);
        if ( other_facing Dot Facing >= MinCosTrigger )
        {
          MakeJump(pp);
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
