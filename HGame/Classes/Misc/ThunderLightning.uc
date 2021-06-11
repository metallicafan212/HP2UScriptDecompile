//================================================================================
// ThunderLightning.
//================================================================================

class ThunderLightning extends Light;

var int Counter;
var() float flashTiming[5];
var bool bLightningActive;
var() name stormName;

function BeginPlay ()
{
  SetTimer(2.0 + FRand() * 6,False);
  // LightType = 0;
  LightType = LT_None;
  bLightningActive = False;
}

function Timer ()
{
  // if ( LightType == 4 )
  if ( LightType == LT_Flicker )
  {
    // LightType = 0;
	LightType = LT_None;
    bLightningActive = False;
    SetTimer(flashTiming[Counter],False);
    Counter++;
    if ( Counter >= 5 )
    {
      Counter = 0;
    }
  } else {
    // LightType = 4;
	LightType = LT_Flicker;
    bLightningActive = True;
    PlaySound(Sound'firecrab_hit',SLOT_NOne);
    SetTimer(0.81 + FRand() * 0.5,False);
  }
}

defaultproperties
{
    bStatic=False

    // LightType=4
	LightType=LT_Flicker

    LightBrightness=255

    LightRadius=255
}
