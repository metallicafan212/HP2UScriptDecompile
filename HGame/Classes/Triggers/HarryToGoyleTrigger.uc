//================================================================================
// HarryToGoyleTrigger.
//================================================================================

class HarryToGoyleTrigger extends Trigger;

var harry PlayerHarry;
var() Class<ParticleFX> Particles;
var() float ParticlesWaitingTime;
var() bool bChangeToHarry;

function PostBeginPlay()
{
// JL0014:
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL0014;
	break;
  }
}

function TriggerEvent (name EventName, Actor Other, Pawn EventInstigator)
{
  GotoState('stateMagic');
}

state stateMagic
{
begin:
  PlayerHarry.SpawnParticles(Particles);
  if ( bChangeToHarry )
  {
    PlayerHarry.bIsGoyle = False;
  } else {
    PlayerHarry.bIsGoyle = True;
  }
  Sleep(ParticlesWaitingTime);
  PlayerHarry.SetNewMesh();
  GotoState('NormalTrigger');
}

defaultproperties
{
    bSendEventOnEvent=True

}
