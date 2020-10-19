//================================================================================
// TestChar.
//================================================================================

class TestChar extends HChar;

var() name Start[3];
var() name End[3];
var float MyTimer;
var int CurrentPiece;

function OnEvent (name EventName)
{
  if ( EventName == 'ActionDone' )
  {
    PlayerHarry.ClientMessage("ActionDone");
    if ( IsInState('patrolFollowSpline') )
    {
      GotoState('DoSplineFollowWait');
    }
  }
}

function FollowNextSplinePath ()
{
  CurrentPiece++;
  if ( CurrentPiece >= 3 )
  {
    CurrentPiece = 0;
  }
  FollowSplinePath('InterpolationPointSet3',60.0,30.0,Start[CurrentPiece],End[CurrentPiece],,/*4*/MOVE_TYPE_EASE_FROM_AND_TO);
}

auto state() DoNothing
{
begin:
  FollowSplinePath('InterpolationPointSet3',60.0);
}

state patrolFollowSpline //extends patrolFollowSpline
{
  function Tick (float dtime)
  {
    MyTimer += dtime;
    if ( MyTimer >= 10 )
    {
      MyTimer = 0.0;
      GotoState('sldkfj');
    }
  }
  
  function Timer ()
  {
  }
  
}

state() DoSplineFollow
{
begin:
  CurrentPiece = -1;
  FollowNextSplinePath();
}

state() stateDoMoveTo
{
begin:
  Sleep(2.0);
  CutCommand("FlyTo baseCam EaseBetween Fixed x=-12.34 time=1.5");
}

state DoSplineFollowWait
{
begin:
  Sleep(2.0);
  FollowNextSplinePath();
}

state stateGotoPatrol
{
begin:
  GotoState('patrol');
}

state stateMoveAround
{
begin:
  MoveTo(Location + Normal(VRand() * Vec(1.0,1.0,0.0)) * 150);
  goto ('Begin');
}

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skChristmasTreeMesh'

}
