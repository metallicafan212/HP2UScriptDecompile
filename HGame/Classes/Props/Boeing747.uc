//================================================================================
// Boeing747.
//================================================================================

class Boeing747 extends HProp;

var() name PathName;
var() float PathSpeed;
var Vector OneStartCP;
var Vector OneEndCP;
var Vector OneLocation;
var Vector TwoStartCP;
var Vector TwoEndCP;
var Vector TwoLocation;
var Vector ThreeStartCP;
var Vector ThreeEndCP;
var Vector ThreeLocation;
var InterpolationManager IM;
var DynamicInterpolationPoint TransPath[3];
var int iTransPoint;

function OnEvent (name EventName)
{
  if ( EventName == 'ActionDone' )
  {
    PlayerHarry.ClientMessage("ACTION DONE");
  }
}

function bool StartTransPath ()
{
  local float fDistance;
  local InterpolationPoint I;
  local Vector X;
  local Vector Y;
  local Vector Z;
  local float fClosestDistance;
  local InterpolationPoint ClosestPoint;
  local int iClosestPoint;
  local float fTransDistance;
  local InterpolationPoint TransPoint;

  foreach AllActors(Class'InterpolationPoint',I,PathName)
  {
    if ( I.Position == 0 )
    {
      TransPoint = I;
      fTransDistance = fDistance;
      iTransPoint = I.Position;
    } //else {
    //}
  }
  if ( TransPoint == None )
  {
    Log("BroomHarry could not find an interpolation point on path to go to");
    return False;
  }
  if ( TransPath[1] == None )
  {
    TransPath[1] = Spawn(Class'DynamicInterpolationPoint');
    TransPath[1].Tag = TransPath[1].Name;
    TransPath[1].Position = 1;
    TransPath[1].bEndOfPath = True;
  }
  TransPath[1].SetLocation(TransPoint.Location);
  TransPath[1].SetRotation(TransPoint.Rotation);
  TransPath[1].DesiredSpeed = 1200.0;
  TransPath[1].StartControlPoint = OneStartCP;
  TransPath[1].EndControlPoint = OneEndCP;
  if ( TransPath[0] == None )
  {
    TransPath[0] = Spawn(Class'DynamicInterpolationPoint',,TransPath[1].Tag);
    TransPath[0].Position = 0;
    TransPath[0].bEndOfPath = False;
    TransPath[0].Next = TransPath[1];
    TransPath[0].Prev = TransPath[1];
    TransPath[1].Next = TransPath[0];
    TransPath[1].Prev = TransPath[0];
  }
  TransPath[0].SetLocation(Location);
  TransPath[0].DesiredSpeed = VSize(Velocity);
  GetAxes(Rotation,X,Y,Z);
  TransPath[0].StartControlPoint = TwoStartCP;
  TransPath[0].EndControlPoint = TwoEndCP;
  SetCollision(True,False,False);
  bCollideWorld = False;
  bInterpolating = True;
  // SetPhysics(0);
  SetPhysics(PHYS_None);
  IM = Spawn(Class'InterpolationManager',self);
  IM.Init(TransPath[1],1.0,False);
  return True;
}

function DestroyTransPath ()
{
  local InterpolationManager IM_ToStop;

  if ( IM != None )
  {
    IM_ToStop = IM;
    IM = None;
    IM_ToStop.FinishedInterpolation(None);
  }
  TransPath[0].Destroy();
  TransPath[1].Destroy();
}

function StartOnPath ()
{
  FollowSplinePath(PathName,PathSpeed,0.0,);
}

defaultproperties
{
    PathName=747Path

    PathSpeed=1200.00

    Mesh=SkeletalMesh'HPModels.skBoeing747Mesh'

    DrawScale=6.00

    AmbientGlow=50

    CollisionRadius=1000.00

    CollisionHeight=250.00

}
