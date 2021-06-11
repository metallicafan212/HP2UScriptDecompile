//================================================================================
// CHGrate.
//================================================================================

class CHGrate extends HProp;

var() int FlyOffYawOffset;

function Trigger (Actor Other, Pawn EventInstigator)
{
  GotoState('OpenUp');
}

state OpenUp
{
  function AlterRotation ()
  {
    local Rotator R;
  
    R = Rotation;
    R.Yaw += FlyOffYawOffset;
    SetRotation(R);
  }
  
 begin:
  SetCollision(False,False,False);
  AlterRotation();
  PlayAnim('PopOut');
  Sleep(25.0 / 30.0);
  PlaySound(Sound'floor_grate_landing',SLOT_None,,False,1000000.0,RandRange(0.81,1.25));
}

state Idle
{
}

state rattle
{
begin:
  PlayAnim('rattle');
  FinishAnim();
  PlayAnim('Idle',,0.41);
  GotoState('Idle');
}

function OnEvent (name EventName)
{
  Super.OnEvent(EventName);
  if ( EventName == 'rattle' )
  {
    GotoState('rattle');
  }
}

defaultproperties
{
    Mesh=None

    CollisionRadius=30.00

    CollisionHeight=9.00

    bCollideWorld=False

    bAlignBottom=False

}
