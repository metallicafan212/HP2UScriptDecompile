//================================================================================
// QuidditchCameraTarget.
//================================================================================

class QuidditchCameraTarget extends QuidditchPlayer;

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
}

state Fly
{
  function BeginState()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' Begin Seeking'));
    Log(string(Name) $ string(' Begin Seeking'));
  }
  
  function EndState()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' End Seeking'));
    Log(string(Name) $ string(' End Seeking'));
  }
  
begin:
loop:
  if ( (LookForTarget != None) &&  !LookForTarget.bHidden )
  {
    Log(string(Name) $ " Sees Target, will pursue");
    GotoState('Pursue');
  }
  Sleep(0.1);
  goto ('Loop');
}

auto state Pursue
{
begin:
  SetCollision(False,False,False);
  bCollideWorld = False;
loop:
  Sleep(30.0);
  goto ('Loop');
}

defaultproperties
{
    TrackingOffsetRange_Horz=0.00

    TrackingOffsetRange_Vert=0.00

    bCanWoosh=False

    // Team=2
	Team=TA_Neutral

    bHidden=True

    // DrawType=0
	DrawType=DT_None

    bCollideActors=False

    bCollideWorld=False

    bBlockPlayers=False
}
