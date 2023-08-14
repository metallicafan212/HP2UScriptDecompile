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

// Omega: Behavior restoration bool: Allow only one track at a time similar to stock
var() bool bAllowOnlyOneTrack;

function PostBeginPlay ()
{
	foreach AllActors(Class'harry',PlayerHarry)
	{
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
	
	// Metallicafan212:	This is ASSS
	if ( FadeOutAllSongs && !Triggered)
	{
		foreach AllActors(Class'NewMusicTrigger',nmt)
		{
			nmt.Triggered = False;
		}
		StopAllMusic(FadeOutTime);
	} 
	//else 
	//{
	if (!Triggered && Song != "")
	{
		Triggered = True;
		// Omega: Fade out all other tracks if we're using the old stock behavior
		if(bAllowOnlyOneTrack)
		{
			StopAllMusic(FadeOutTime);
		}
		SongHandle = PlayMusic(Song,FadeInTime);
	}
	//}
}

defaultproperties
{
    Texture=Texture'Engine.mu_icon'
	
	// Omega: added to match stock behavior
	bAllowOnlyOneTrack=True
}
