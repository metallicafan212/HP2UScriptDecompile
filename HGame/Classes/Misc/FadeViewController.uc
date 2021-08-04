//================================================================================
// FadeViewController.
//================================================================================

class FadeViewController extends Actor;

var() bool bFadeFlash;
var() float fadetime;
var() Plane FadeEnd;
var Plane FadeStart;
var float CurTime;
var harry PlayerHarry;

event BeginPlay()
{
  Super.BeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
  DestroyAllFadeViewControllers();
  FadeStart = PlayerHarry.ConstantGlowFog;
}

function Init (float A, float R, float G, float B, float fTime, optional bool bFlash)
{
  FadeEnd.W = FClamp(A,0.0,1.0);
  FadeEnd.X = FClamp(R,0.0,1.0);
  FadeEnd.Y = FClamp(G,0.0,1.0);
  FadeEnd.Z = FClamp(B,0.0,1.0);
  fadetime = fTime;
  bFadeFlash = bFlash;
  if ( bFadeFlash )
  {
    fadetime = fadetime / 2;
    FadeStart = PlayerHarry.FlashFog;
    GotoState('stateFlash');
  } else {
    FadeEnd.W =  -FadeEnd.W;
    FadeStart = PlayerHarry.ConstantGlowFog;
  }
  PlayerHarry.ClientMessage("Fade translated " $ "R:" $ string(FadeEnd.X) $ "G:" $ string(FadeEnd.Y) $ "B:" $ string(FadeEnd.Z) $ "A:" $ string(FadeEnd.W));
}

function DestroyAllFadeViewControllers()
{
  local FadeViewController A;

  foreach AllActors(Class'FadeViewController',A)
  {
    if ( A != self )
    {
      A.Finish();
    }
  }
}

function Finish()
{
}

function CutBypass()
{
  Finish();
  Super.CutBypass();
}

auto state stateFade
{
  event Tick (float fTimeDelta)
  {
    local float fSpeedAndTime;
  
    CurTime += fTimeDelta;
    if ( CurTime < fadetime )
    {
      fSpeedAndTime = fTimeDelta / fadetime;
      PlayerHarry.ConstantGlowFog.X += (FadeEnd.X - FadeStart.X) * fSpeedAndTime;
      PlayerHarry.ConstantGlowFog.Y += (FadeEnd.Y - FadeStart.Y) * fSpeedAndTime;
      PlayerHarry.ConstantGlowFog.Z += (FadeEnd.Z - FadeStart.Z) * fSpeedAndTime;
      PlayerHarry.ConstantGlowFog.W += (FadeEnd.W - FadeStart.W) * fSpeedAndTime;
    } else {
      Finish();
    }
  }
  
  function Finish()
  {
    PlayerHarry.ConstantGlowFog = FadeEnd;
    Destroy();
  }
  
}

state stateFlash
{
  event Tick (float fTimeDelta)
  {
    local float fSpeedAndTime;
  
    CurTime += fTimeDelta;
    if ( CurTime < fadetime )
    {
      fSpeedAndTime = fTimeDelta / fadetime;
      PlayerHarry.FlashFog.X += (FadeEnd.X - FadeStart.X) * fSpeedAndTime;
      PlayerHarry.FlashFog.Y += (FadeEnd.Y - FadeStart.Y) * fSpeedAndTime;
      PlayerHarry.FlashFog.Z += (FadeEnd.Z - FadeStart.Z) * fSpeedAndTime;
      PlayerHarry.FlashFog.W += (FadeEnd.W - FadeStart.W) * fSpeedAndTime;
    } else {
      PlayerHarry.FlashFog = FadeEnd;
      if (  !bFadeFlash )
      {
        Destroy();
      }
      bFadeFlash = False;
      FadeEnd = FadeStart;
      FadeStart = PlayerHarry.FlashFog;
      fadetime *= 2;
    }
  }
  
  function Finish()
  {
    if ( bFadeFlash )
    {
      PlayerHarry.FlashFog = FadeStart;
    } else {
      PlayerHarry.FlashFog = FadeEnd;
    }
    Destroy();
  }
  
}

defaultproperties
{
    fadetime=5.00

    FadeEnd=(X=1.00,Y=1.00,Z=1.00,W=1.00)

    bHidden=True

}
