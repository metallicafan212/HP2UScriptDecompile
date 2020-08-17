//================================================================================
// NewMusicTrigger.
//================================================================================

class NewMusicTrigger extends Trigger;

var() string Song;
var() float FadeInTime;
var() float FadeOutTime;
var() bool FadeOutAllSongs;
var transient bool Triggered;
var transient int SongHandle;
var harry PlayerHarry;

function PostBeginPlay ()
{
// JL0014:
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL0014;
	break;
  }
}

function Activate (Actor Other, Pawn Instigator)
{
  ProcessTrigger();
}

function ProcessTrigger ()
{
  local NewMusicTrigger nmt;

  if ( FadeOutAllSongs )
  {
    foreach AllActors(Class'NewMusicTrigger',nmt)
    {
      nmt.Triggered = False;
    }
    StopAllMusic(FadeOutTime);
  } else {
    if (  !Triggered )
    {
      Triggered = True;
      SongHandle = PlayMusic(Song,FadeInTime);
    }
  }
}

defaultproperties
{
    Texture=Texture'Engine.mu_icon'

}
