//================================================================================
// SpellLearnFX.
//================================================================================

class SpellLearnFX extends Actor;

var Gesture SpellGesture;
var float TotalTime;
var float FXSize;
var float fFXDecayTime;
var Vector OrigLoc;
var int I;
var ParticleFX Sparkle;
var int iCounter;
var float TimerToPoint;
var() bool bStarted;

event Destroyed()
{
  Sparkle.Destroy();
  Super.Destroyed();
}

function SetupFX (int iType)
{
  Sparkle = Spawn(Class'SilverSparkle01',,,Location);
  Sparkle.Lifetime.Base = 100000000.0;
  Sparkle.Lifetime.Rand = 0.0;
  Sparkle.SizeWidth.Base = 3.0 * FXSize;
  Sparkle.SizeLength.Base = 3.0 * FXSize;
}

function DrawSpell (Gesture Gesture, float inSize, float inTime, int iType, float fAccuracy, float fDecayTime)
{
  if ( Gesture.Points.Length < 2 )
  {
    return;
  }
  SpellGesture = Gesture;
  OrigLoc = Location;
  TotalTime = inTime;
  FXSize = fAccuracy / 0.01;
  fFXDecayTime = fDecayTime;
  SetupFX(iType);
  Sparkle.Pattern = Gesture;
  Sparkle.DrawScale = inSize;
  Sparkle.Period.Base = 0.0;
  Sparkle.Period.Rand = 0.0;
  GotoState('DrawState');
}

state DrawState
{
  function Tick (float DeltaTime)
  {
    Sparkle.Period.Base += Sparkle.Period.Rand;
    if ( Sparkle.Period.Base > 1.0 )
    {
      Sparkle.Period.Rand = 0.0;
      return;
    }
    Sparkle.Period.Rand = DeltaTime / TotalTime;
  }
}

defaultproperties
{
    DrawType=DT_None
}
