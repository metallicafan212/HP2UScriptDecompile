//================================================================================
// SavePoint.
//================================================================================

class SavePoint extends HPawn;

var() bool bSaveOnce;
var bool bActive;
var Vector vLoc;
var float fBobAmount;
var float fWaitTime;

//added from UEExplorer because UTPT didn't decompile the tick function -AdamJD
function Tick (float dtime)
{
	super.Tick(dtime);

    if(bActive)
    {
        SetLocation(vLoc +(Vec((fBobAmount * 0.20) * Cos((Level.TimeSeconds * 1) * 3),0.0,fBobAmount * Sin((Level.TimeSeconds * 2) * 3)) >> Rotation));
    }
    
    else
    {
        if(fWaitTime > 0)
        {
            fWaitTime -= dtime;
        }
        
        else
        {
            fWaitTime = 0.0;
            bActive = true;
        }
		
        Opacity = 1.0 - (fWaitTime / default.fWaitTime);
        SoundVolume = int(128 * Opacity);
    }
}

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  vLoc = Location;
  AmbientSound = Default.AmbientSound;
  SoundRadius = Default.SoundRadius;
  SoundVolume = Default.SoundVolume;
  SoundPitch = Default.SoundPitch;
}

function OnSaveGame ()
{
  //local int Health;
  local int iHarryHealth;

  if ( PlayerHarry.GetHealthCount() <= 0 )
  {
    return;
  }
  bActive = False;
  if ( bSaveOnce )
  {
    Destroy();
  }
  fWaitTime = Default.fWaitTime;
  Opacity = 0.0;
  iHarryHealth = PlayerHarry.GetHealthCount();
  if ( iHarryHealth < PlayerHarry.iMinHealthAfterDeath )
  {
    PlayerHarry.SetHealth(PlayerHarry.iMinHealthAfterDeath);
  }
  PlayerHarry.SaveGame();
  PlayerHarry.SetHealth(iHarryHealth);
}

function Touch (Actor Other)
{
  if ( Other.IsA('harry') && bActive )
  {
    PlayerHarry.ClientMessage("" $ string(self) $ " touched, other: " $ string(Other));
    OnSaveGame();
  }
}

defaultproperties
{
    bSaveOnce=True

    fBobAmount=10.00

    fWaitTime=10.00

    AmbientSound=Sound'HPSounds.menu_sfx.Save_book_loop'

    Rotation=(Pitch=16384,Yaw=0,Roll=0)

    Mesh=SkeletalMesh'HPModels.SavePointFloatBookMesh'

    AmbientGlow=75

    SoundRadius=16

    SoundVolume=44

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

}
