//================================================================================
// FadeActorController.
//================================================================================

class FadeActorController extends Actor;

var() float TimeEnd;
var() float FadeEnd;
var float FadeStart;
var Actor FadingActor;
var float TimeCur;
var string SavedCue;
var harry PlayerHarry;

event BeginPlay()
{
  Super.BeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
}

function Init (Actor A, float fEndOpacity, float fTime, optional string cue)
{
  FadingActor = A;
  CutNotifyActor = A;
  FadeEnd = FClamp(fEndOpacity,0.0,1.0);
  FadeStart = FClamp(FadingActor.Opacity,0.0,1.0);
  TimeEnd = fTime;
  SavedCue = cue;
  PlayerHarry.ClientMessage("===---> Going to set actor " $ string(FadingActor) $ " from " $ string(FadeStart) $ " to " $ string(FadeEnd));
}

function CutBypass()
{
  Finish();
  Super.CutBypass();
}

function Finish()
{
  FadingActor.Opacity = FadeEnd;
  CutCue(SavedCue);
  PlayerHarry.ClientMessage("===---> Finishing FadeActor " $ string(FadingActor) $ " from " $ string(FadeStart) $ " to " $ string(FadeEnd));
  Destroy();
}

event Tick (float fTimeDelta)
{
  TimeCur += fTimeDelta;
  if ( TimeCur < TimeEnd )
  {
    FadingActor.Opacity += (FadeEnd - FadeStart) * (fTimeDelta / TimeEnd);
  } else {
    Finish();
  }
}

defaultproperties
{
    TimeEnd=5.00

    FadeStart=1.00

    bHidden=True

}
