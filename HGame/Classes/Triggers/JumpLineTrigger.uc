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

  if (  !bEnabled )
  {
    return;
  }
  // I = 0;
  // if ( I < 4 )
  for(I = 0; I < 4; I++)
  {
    Facing = GetFacing(self);
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
    // I++;
    // goto JL0014;
  }
}

defaultproperties
{
    ForceJumpForward=1.00

    fHorizSpeedMultiplier=1.00

    bDirectional=True

}
