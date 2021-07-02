//================================================================================
// SnailTrail.
//================================================================================

class SnailTrail extends HProp;

var orangesnail parentSnail;
var float fTrailDuration;
var float fShrinkAfter;
var float fStartDrawScale;
var float fCountDown;

function SetSpawnProps (orangesnail parentInSnail, float fInTrailDuration, float fInShrinkAfter)
{
  parentSnail = parentInSnail;
  fTrailDuration = fInTrailDuration;
  fShrinkAfter = fInShrinkAfter;
}

function StartUsing (Vector vLoc)
{
  fCountDown = fTrailDuration;
  DrawScale = fStartDrawScale;
  SetCollision(True);
  SetLocation(vLoc);
  bHidden = False;
}

function StopUsing ()
{
  bHidden = True;
  SetCollision(False);
}

event Tick (float fDelta)
{
  if ( fCountDown <= 0 )
  {
    StopUsing();
  } else //{
    if ( bHidden == False )
    {
      if ( fTrailDuration - fCountDown >= fShrinkAfter )
      {
        DrawScale = fCountDown / (fTrailDuration - fShrinkAfter) * fStartDrawScale;
      }
      fCountDown -= fDelta;
    }
  //}
}

auto state ComeStepOnMeHarry
{
  function Touch (Actor Other)
  {
    Super.Touch(Other);
    if ( harry(Other) == None )
    {
      return;
    }
    parentSnail.HarrySteppedOnTrail(Location);
  }
  
}

defaultproperties
{
    fTrailDuration=2.00

    fShrinkAfter=1.00

    fStartDrawScale=0.10

    fCountDown=2.00

    Rotation=(Pitch=0,Yaw=0,Roll=-16320)

    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skSheetTestMesh'

    DrawScale=0.10

    bUnlit=True

    MultiSkins(0)=FireTexture'HPParticle.hp_fx.Particles.Silverslime'

    CollisionRadius=10.00

    CollisionHeight=5.00

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False
}
