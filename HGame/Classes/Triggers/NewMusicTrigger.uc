//================================================================================
// NewMusicTrigger.
//================================================================================

// Metallicafan212:	All of this behavior and variables have been rolled into MusicTrigger in Engine.
//					This was done to have one source of this music behavior to use in all HP2 engine enhanced games (UT, HP1, etc.).
class NewMusicTrigger extends MusicTrigger;//Trigger;

/*
var() string 		Song;
var() float 		FadeInTime;
var() float 		FadeOutTime;

// Metallicafan212:	Initial timestamp (because why not)
var() float			Timestamp;

var() bool 			FadeOutAllSongs;

// Metallicafan212:	M212 oneshot music type (doesn't loop)
var() bool 			bOnceOnly;

// Metallicafan212:	Fire an event when the music track loops/finishes
var() bool			bEventOnMusicLoop;

// Omega: Behavior restoration bool: Allow only one track at a time similar to stock
var() bool 			bAllowOnlyOneTrack;

var transient bool 	Triggered;
var transient int 	SongHandle;
var harry 			PlayerHarry;


event MusicTrackLooped()
{
	super.MusicTrackLooped();
	
	if(bEventOnMusicLoop)
	{
		TriggerEvent(Event, self, none);
	}
}

function PostBeginPlay ()
{
	foreach AllActors(Class'harry', PlayerHarry)
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
	if (!Triggered && Song != "")
	{
		Triggered = True;
		
		// Omega: Fade out all other tracks if we're using the old stock behavior
		if(bAllowOnlyOneTrack)
		{
			StopAllMusic(FadeOutTime);
		}
		SongHandle = PlayMusic(Song, FadeInTime, Timestamp, bOnceOnly);
	}
}

defaultproperties
{
    Texture=Texture'Engine.mu_icon'
	
	// Omega: added to match stock behavior
	bAllowOnlyOneTrack=True
}
*/
