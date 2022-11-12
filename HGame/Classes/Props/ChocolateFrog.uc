//================================================================================
// ChocolateFrog.
//================================================================================

class ChocolateFrog extends HProp;

var Actor shower;
var Sound soundRibbit;
var Sound soundHop;
var Sound soundUse;
var() bool bSmartFrog;
var Vector vStartLoc;
var() float fFrogJumpRadius;
var int JumpOutOfWayCount;
var() float fJumpTime;
var Vector vTemp;

function Sound GetRibbitOrHopsound()
{
  if ( FRand() <= 0.69999999 )
  {
    return soundHop;
  } else {
    return soundRibbit;
  }
}

function JumpToNewLoc (Vector V, optional bool bJumpOutOfWay)
{
  //local float JumpTime;
  local float JumpFrogTime;

  JumpFrogTime = fJumpTime;
  if ( bJumpOutOfWay )
  {
    DesiredRotation.Yaw = rotator(V - Location).Yaw;
    PlayAnim('hop2',1.0,0.05);
    JumpFrogTime *= 0.5;
    JumpOutOfWayCount++;
  }
  // SetPhysics(2);
  SetPhysics(PHYS_Falling);
  Velocity = ComputeTrajectoryByTime(Location,V,JumpFrogTime);
  GotoState('stateJump');
}

auto state holdstill
{
  function Timer()
  {
    local Vector vH;
    local Vector vToMe;
    local Vector vCross;
    local float JumpDist;
  
    JumpDist = 100.0;
    vH = PlayerHarry.Velocity;
    if ( (vH != vect(0.00,0.00,0.00)) && (VSize(PlayerHarry.Location - Location) < 100) )
    {
      vH = Normal(vH * vect(1.00,1.00,0.00));
      vToMe = (Location - PlayerHarry.Location) * vect(1.00,1.00,0.00);
      vCross = vH Cross vToMe;
      if ( (vH Dot vToMe > 0) && (Abs(vCross.Z) < 40) )
      {
        if ( JumpOutOfWayCount >= 3 )
        {
          JumpDist = 25.0;
        }
        JumpToNewLoc(Location + Normal(vCross Cross vH) * JumpDist,True);
      }
    }
  }
  
  function EndState()
  {
    SetTimer(0.0,False);
  }
  
 begin:
  SetTimer(0.125,True);
  LoopAnim('croak',1.0,0.2);
  FinishAnim();
  soundUse = GetRibbitOrHopsound();
  if ( soundUse == soundRibbit )
  {
    PlaySound(soundRibbit);
  }
  LoopAnim('breath',0.6,0.2);
  Sleep(FRand() * 3);
  FinishAnim();
  if ( vStartLoc == vect(0.00,0.00,0.00) )
  {
    vStartLoc = Location;
  }
  vTemp = vStartLoc + Normal(VRand() * vect(1.00,1.00,0.00)) * fFrogJumpRadius;
  DesiredRotation.Yaw = rotator(vTemp - Location).Yaw;
  PlayAnim('trans2hop2',,0.2);
  Sleep(7.0 / 30.0);
  SetTimer(0.0,False);
  JumpOutOfWayCount = 0;
  PlayAnim('hop2',1.0,0.05);
  JumpToNewLoc(vTemp);
}

state stateJump
{
  function Landed (Vector HitNormal)
  {
    GotoState('holdstill');
  }
  
 begin:
  Sleep(0.2);
  PlayAnim('breath',1.0,0.69999999);
  FinishAnim();
}

defaultproperties
{
    soundRibbit=Sound'HPSounds.Critters_sfx.frog_ribbit'

    soundHop=Sound'HPSounds.Critters_sfx.frog_hop'

    bSmartFrog=True

    fFrogJumpRadius=50.00

    fJumpTime=0.80

    soundPickup=Sound'HPSounds.Critters_sfx.pickup_frog'

    bPickupOnTouch=True

    nPickupIncrement=40

    //PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupHealth'

    classStatusItem=Class'StatusItemHealth'

    ShadowClass=Class'Engine.ActorShadow'

    //Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HProps.skChocolateFrogMesh'

    DrawScale=0.50

    CollisionRadius=20.00

    CollisionHeight=20.00

    bBlockPlayers=False

    bBlockCamera=False

    RotationRate=(Pitch=4096,Yaw=150000,Roll=3072)
}
