//================================================================================
// LumosTrigger.
//================================================================================

class LumosTrigger extends Triggers;

var bool bFirstEventSent;
var() bool bNoEventWhileInRadius;
var() bool bEventEntering;
var() bool bEventLeaving;
var() bool bUseZDistanceCheck;
var() float fZDistanceCheck;
var() float fDistanceCheck;
var harry PlayerHarry;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
}

function bool IsSafeToTurnLumosOff()
{
  local HPawn HPawn;

  return True;
}

function bool InLumosRadius()
{
  if ( VSize(Location - PlayerHarry.Location) < fDistanceCheck )
  {
    return True;
  }
  return False;
}

auto state StateLumosOff
{
  function OnLumosOn()
  {
    if (  !bFirstEventSent )
    {
      GotoState('StateWaitingToTurnOn');
    }
  }
}

state StateWaitingToTurnOn
{
  function BeginState()
  {
    PlayerHarry.ClientMessage(" LumosTrigger " $ string(self) $ " Waiting To turn on once we are within lumos range!");
  }
  
  event Tick (float fTimeDelta)
  {
    if ( InLumosRadius() )
    {
      if (  !bUseZDistanceCheck )
      {
        GotoState('StateLumosOn');
      } else //{
        if ( Abs(Location.Z - PlayerHarry.Location.Z) < fZDistanceCheck )
        {
          GotoState('StateLumosOn');
        }
      //}
    }
  }
  
  function OnLumosOff()
  {
    GotoState('StateLumosOff');
  }
}

state StateLumosOn
{
  function BeginState()
  {
    if ( bEventEntering &&  !bFirstEventSent )
    {
      PlayerHarry.ClientMessage("LumosTrigger " $ string(self) $ " Sending ENTERING TriggerEvent!");
      TriggerEvent(Event,self,None);
      bFirstEventSent = True;
    }
    PlaySound(Sound'Lumos_hit01', SLOT_None,125.0,False);
  }
  
  event Tick (float fTimeDelta)
  {
    if (  !InLumosRadius() )
    {
      OnLumosOff();
    }
  }
  
  function OnLumosOff()
  {
    if ( bEventLeaving &&  !bFirstEventSent )
    {
      PlayerHarry.ClientMessage(" LumosTrigger " $ string(self) $ " Sending EXITING TriggerEvent!");
      TriggerEvent(Event,self,None);
      bFirstEventSent = True;
    }
    GotoState('StateLumosOff');
  }
}

defaultproperties
{
    bEventEntering=True

    fZDistanceCheck=64.00

    fDistanceCheck=512.00

}
