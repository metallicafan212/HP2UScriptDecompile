//================================================================================
// CutScript.
//================================================================================

// Omega: Cleaned the fuck out of this class and made it generally easier to read
// some array operations for your notes:
/*(.Add, .AddItem, .Empty, .Contains, .Find, .InsertItem, .RemoveItem)*/

class CutScript extends Actor;

var(Script) string Script;
var int curScriptPosition;

var array<String> aCues;			// List of cues that have already happened
var array<String> aPendingCues;		// Used to queue cues, if you catch my drift

var int nPendingCues;
var int nCues;
var int lastCueNum;					// Static var

var string pendingTimerCue; 		//cue to issue on timer event. Used by WAITFOR durration.

var array<Actor> aCapturedActors;

var bool bPlaying;					// True if the cutscene is currently playing

var CutScene parentCutScene;

// Thread info
var int threadNum;
var string sThreadName;

var bool bFastForward;				// Cutscene skipping

var string lastCommand;				

var bool bScriptAdvancing;			// True if the script is not waiting on a cue to happen

var bool bUsingBaseCam;				// True if the script is making use of Basecam. Appears to be unused otherwise, but may be useful elsewhere

function bool CaptureActor (string actName)
{
	//local int I;
	local Actor Act;

	foreach AllActors(Class'Actor',Act)
	{
		if ( Act.CutName ~= actName )
		{
			break;
		}
	}
	cm("Attempting to capture: " $actName$ " Class: " $Act);
	
	if ( Act == None )
	{
		CutError("Can't Capture " $ actName $ ". Actor not found.");
		return False;
	}
	
	// Omega: check if the Actor is attached to any other cutscripts
	if ( Act.CutNotifyActor != None )
	{
		// Omega: Actors that are bumplining cutnotify themselves, this hack boots them out of this state
		if ( (Act.CutNotifyActor == Act) && Act.IsInState('DoingBumpLine') )
		{
			Act.CutCue("");
			if ( Act.CutNotifyActor != None )
			{
				CutError("Bump/Capture Hack Failed. " $ actName $ ". Actor already captured by" $ string(Act.CutNotifyActor) $ ".");
				return False;
			}
		} 
		// Omega: or else we just can't capture it because they're already captured elsewhere
		else 
		{
			CutError("Can't Capture " $ actName $ ". Actor already captured by" $ string(Act.CutNotifyActor) $ ".");
			return False;
		}
	}

	// Omega: if we've reached this point, we're able to capture this actor

	Act.CutCommand("CAPTURE");
	Act.CutNotifyActor = self;
	aCapturedActors.AddItem(Act);
	if ( Act.IsA('BaseCam') )
	{
		// Omega: This allows the camera to update only after the cutscene is updated, one of the few places where TickParent2 is useful
		// See Actor.uc for other potential uses of Owner, TickParent, and TickParent2
		Act.TickParent2 = self;
	}

	// Omega: Since this is a dynamic array, we can't fail this way
	return True;
}

// Omega: Similar to capturing, but only sets up the variables necessary to redirect the actor to our script here
function bool ReCaptureActor (string actName)
{
	//local int I;
	local Actor Act;

	foreach AllActors(Class'Actor',Act)
	{
		if ( Act.CutName ~= actName )
		{
			break;
		}
	}
	
	if ( Act == None )
	{
		CutError("Can't ReCapture " $ actName $ ". Actor not found.");
		return False;
	}
	
	if ( Act.CutNotifyActor == None )
	{
		CutError("Can't ReCapture " $ actName $ ". Actor not already captured.");
		return False;
	}

	Act.CutNotifyActor = self;
	aCapturedActors.AddItem(Act);

	if ( Act.IsA('BaseCam') )
	{
		Act.TickParent2 = self;
	}

	return true;
}

// Omega: Clears the variables necessary for capture, and sends the release command
function bool ReleaseActor (string actName)
{
	local int I;

	for(I = 0; I < aCapturedActors.Length; I++)
	{
		if ( (aCapturedActors[I] != None) && (aCapturedActors[I].CutName ~= actName) )
		{
			if ( aCapturedActors[I].CutCommand("RELEASE") )
			{
				if ( aCapturedActors[I].CutNotifyActor != self )
				{
					CutError("Failed to Release " $ actName $ ". Actor Notify doesn't match!?!?!?!.");
					return False;
				}
				
				aCapturedActors[I].CutNotifyActor = None;
				aCapturedActors[I] = None;
				return True;
			} 
			else 
			{
				CutError("Failed to Release " $ actName $ ". Actor refused Release!?!?!?!.");
				return False;
			}
		}
	}

	CutError("Failed to Release " $ actName $ ". Actor not captured.");
	return False;
}

// Omega: Used internally to search for our cut subject on various commands
// You will likely see this error logged when you inevitably forget to capture an actor lmao
function Actor FindCutSubject (string subjectName)
{
	local int I;

	// Omega: Love this KW hack of not just setting the baseCam name by default... 
	// it's already gonna conflict either way, might as well have just set the cutname of baseCam by default
	if ( subjectName ~= "baseCam" )
	{
		bUsingBaseCam = True;
		return harry(Level.PlayerHarryActor).Cam;
	}

	for(I = 0; I < aCapturedActors.Length; I++)
	{
		if(aCapturedActors[I].CutName ~= subjectName)
		{
			return aCapturedActors[I];
		}
	}
	
	CutError("Failed to find " $ subjectName $ ". Actor not captured.");
	return None;
}

function CutLog (string Str)
{
	Level.PlayerHarryActor.ClientMessage("CutLog:" $ sThreadName $ "->" $ Str);
	if (!Class'Version'.Default.bDebugEnabled)
	{
		return;
	}
	Log("CutLog:" $ sThreadName $ "->" $ Str);
}

function CutError (string Str)
{
	local string sWhoIam;

	Level.PlayerHarryActor.ClientMessage("*********************************************************");
	Level.PlayerHarryActor.ClientMessage("**** CutError:" $ sThreadName);
	Level.PlayerHarryActor.ClientMessage("**** CutError:" $ Str);
	Level.PlayerHarryActor.ClientMessage("*********************************************************");
	Log("*********************************************************");
	Log("**** CutError:" $ sThreadName);
	Log("**** CutError:" $ Str);
	Log("*********************************************************");
}

// Omega: Some string filtering to get the next line
function bool GetNextLine (out string Line)
{
	local int eolIndex;
	local string TempStr;

	if ( curScriptPosition >= Len(Script) )
	{
		return False;
	}

	TempStr = Mid(Script,curScriptPosition);
	eolIndex = InStr(TempStr,Chr(13));

	if ( eolIndex < 0 )
	{
		eolIndex = Len(TempStr);
	}

	curScriptPosition += eolIndex + 2;
	Line = Left(TempStr,eolIndex);
	return True;
}

// Omega: Looks for the next cut command using filtering
function bool GetNextCommand (out string Command)
{
	local string Line;
	local int commentIndex;
	local int OtherCommentIndex;

	if (!GetNextLine(Line) )
	{
		return False;
	}

	// Omega: Two commenting formats supported here, woo!
	commentIndex = InStr(Line,";");
	OtherCommentIndex = InStr(Line,"/");

	if ( OtherCommentIndex > -1 )
	{
		if ( (commentIndex < 0) || (OtherCommentIndex < commentIndex) )
		{
			commentIndex = OtherCommentIndex;
		}
	}

	if ( commentIndex > -1 )
	{
		Command = Left(Line,commentIndex);
	}

	else 
	{
		Command = Line;
	}

	return True;
}

// Omega: Cues a CutCue, adding it to the array of Cue'd Cues.
// This allows these to happen latently, but introduces the downside of being unable to reuse names of cues
// Ensure that you pick unique names for specified cues
function CutCue (string cue)
{
	local int I;

	if ( cue == "" )
	{
		CutError("Error blank cue");
	}

	aCues[aCues.Length]=cue;
	nCues++;

	if ( nPendingCues > 0 )
	{
		for(I = 0; I < nPendingCues; I++)
		{
			if(aPendingCues[I] ~= cue)
			{
				if ( nPendingCues - 1 == I )
				{
					aPendingCues[I] = "";
					nPendingCues--;
				}
				else
				{
					aPendingCues[I] = aPendingCues[nPendingCues - 1];
					nPendingCues--;
				}
			}
		}
	}
}

// Omega: Queues a cue. See above on limitations of the system
function AddPendingCue (string cue)
{
	local int I;

	if ( cue == "" )
	{
		CutError("Error blank Pending cue");
	}

	// Omega: Tell the user that this cue has already been recieved, since there's probably a mistake in the cutscene scripting in this case
	for(I = 0; I < nCues; I++)
	{
		if(aCues[I] ~= cue)
		{
			// Omega: Seems there's kind of false positives that this handles, so I'm cutting this CutError message to cut down on spam
			//CutError("Error: Cue: " $cue$ " already recieved! Use a different cue!!!!");
			return;
		}
	}

	aPendingCues[nPendingCues] = cue;
	nPendingCues++;
}

// Omega: Generates a new cue name for any unnamed cues, allowing the user to not worry about it.
// Previously, the fact that every command required a cue meant that there was a pretty low limit on how long cutscenes could be.
// For example, the proto had a limit of 150, while the Basilisk cutscene that was finished after that time in development necessitated it
// to be expanded to 210 (and only a handful more commands will cause the script to throw errors). Dynamic arrays solve this issue and 
// typically will actually reduce the resources needed for smaller scenes, though this is only a really slight memory footprint.
function string GenerateUniqueCue ()
{
	// Omega: The clever thing about this is the fact that it will generate a persistent unique cue ID, eliminating overlap between cutscripts
	// This *might* pass over to other levels during the play session, but I haven't checked. Regardless, it only matters on a per-map basis
	Default.lastCueNum++;
	return "_" $ Default.lastCueNum $ "UniqueCue";
}

// Omega: The powerhouse of the class here, and how the scripting works
// Largely, just a block of checks to see what the commands are, and what to pass down to the commanded actors
function bool ParseCommand (string Command)
{
	local string subjectPart;
	local string actionPart;
	local string untilCue;
	local string TempCommand;
	local Actor subjectActor;
	local BossEncounterTrigger aTrigger;
	local int Index;
	local int eow;
	local int I;
	local float timerDuration;
	local string questionString;
	local TimedCue tcue;
	local name N;
	// Omega: Used for the Goto command's clear cues parameter
	local bool bClearCues;

	subjectPart = ParseDelimitedString(Command," ",1,False);
	if ( Len(subjectPart) == 0 )
	{
		return True;
	}

	if ( subjectPart ~= "IF" )
	{
		questionString = ParseDelimitedString(Command," ",2,False);
		if (	!Level.PlayerHarryActor.CutQuestion(questionString) )
		{
			if ( Level.PlayerHarryActor.CutErrorString != "" )
			{
				CutError(Level.PlayerHarryActor.CutErrorString);
			}
			return True;
		} 
		else 
		{
			Command = Mid(Command,InStr(Command,questionString) + Len(questionString) + 1);
			subjectPart = ParseDelimitedString(Command," ",1,False);
		}
	}

	if ( subjectPart ~= "IFNOT" )
	{
		questionString = ParseDelimitedString(Command," ",2,False);
		if ( Level.PlayerHarryActor.CutQuestion(questionString) )
		{
			if ( Level.PlayerHarryActor.CutErrorString != "" )
			{
				CutError(Level.PlayerHarryActor.CutErrorString);
			}
			return True;
		} 
		else 
		{
			Command = Mid(Command,InStr(Command,questionString) + Len(questionString) + 1);
			subjectPart = ParseDelimitedString(Command," ",1,False);
		}
	}

	switch (subjectPart)
	{
		// EX: Cue MyCue
		// Sends the cue, allowing any WaitFor commands to listen for it and resume script execution
		case "CUE":
			CutLog("Issuing: CUE:" $ ParseDelimitedString(Command," ",2,False));
			parentCutScene.CutCue(ParseDelimitedString(Command," ",2,False));
			return True;
			break;
		
		// EX: Waitfor MyCue
		// Pauses script execution until the cue is given
		case "WAITFOR":
			CutLog("Issuing: WAITFOR:" $ ParseDelimitedString(Command," ",2,False));
			AddPendingCue(ParseDelimitedString(Command," ",2,False));
			return True;
			break;
		
		// EX: Sleep 5
		// Pauses script execution for 5 seconds
		case "SLEEP":
			if ( bFastForward )
			{
				return True;
			}
			CutLog("Issuing: SLEEP:" $ ParseDelimitedString(Command," ",2,False));
			pendingTimerCue = GenerateUniqueCue();
			timerDuration = float(ParseDelimitedString(Command," ",2,False));
			
			// Omega: This restriction seems a bit arbitrary, only being able to do the lower limit of 100 seconds of sleep
			// This may be useful for non-cinematic cutscene usage, so I've elected to not limit it. Be smart, users!
			//if ( (timerDuration > 0) && (timerDuration < 100) )
			if(timerDuration > 0)
			{
				tcue = Spawn(Class'TimedCue');
				tcue.CutNotifyActor = self;
				tcue.SetupTimer(timerDuration,pendingTimerCue);
				AddPendingCue(pendingTimerCue);
			} 
			else 
			{
				CutError("Invalid SLEEP duration:" $ string(timerDuration));
			}
		
			return True;
			break;
		
		// EX: randsleep 2 5
		// Sleeps a random duration between 2 and 5, min must go before max
		case "RANDSLEEP":
			if ( bFastForward )
			{
				return True;
			}
			// Omega: Seems to account for this case anyway, so uh whatever
			/*if(float(ParseDelimitedString(Command," ",3,False)) < float(ParseDelimitedString(Command," ",2,False)))
			{
				CutError("Invalid use of RANDSLEEP, Max is less than Min: " $ParseDelimitedString(Command," ",2,False)$ " - " $float(ParseDelimitedString(Command," ",3,False)));
				return False;
			}*/

			timerDuration = RandRange(float(ParseDelimitedString(Command," ",2,False)), float(ParseDelimitedString(Command," ",3,False)));
			CutLog("Issuing: RANDSLEEP: " $ParseDelimitedString(Command," ",2,False)$ " - " $float(ParseDelimitedString(Command," ",3,False))$ ". Chose: " $timerDuration);
			pendingTimerCue = GenerateUniqueCue();
			
			if(timerDuration > 0)
			{
				tcue = Spawn(Class'TimedCue');
				tcue.CutNotifyActor = self;
				tcue.SetupTimer(timerDuration,pendingTimerCue);
				AddPendingCue(pendingTimerCue);
			} 
			else 
			{
				CutError("Invalid RANDSLEEP duration:" $ string(timerDuration));
			}
		
			return True;
			break;
		
		// EX: Capture BaseCam
		// Captures an actor and subscribes them to this script's commands
		case "CAPTURE":
			CutLog("Issuing: CAPTURE " $ ParseDelimitedString(Command," ",2,False));
			CaptureActor(ParseDelimitedString(Command," ",2,False));
			return True;
			break;
		
		// EX: ReCapture BaseCam
		// ReCaptures an actor and subscribes them to this script's commands. Used if already captured elsewhere, and passing the actor off to another script
		case "RECAPTURE":
			CutLog("Issuing: RECAPTURE " $ ParseDelimitedString(Command," ",2,False));
			ReCaptureActor(ParseDelimitedString(Command," ",2,False));
			return True;
			break;
		
		// EX: Release BaseCam
		// Returns the actor to its normal state
		case "RELEASE":
			CutLog("Issuing: RELEASE " $ ParseDelimitedString(Command," ",2,False));
			ReleaseActor(ParseDelimitedString(Command," ",2,False));
			return True;
			break;
		// EX: Trigger MyTag
		// Sends a trigger similarly to a level's trigger
		case "TRIGGER":
			CutLog("Issuing: TRIGGER " $ ParseDelimitedString(Command," ",2,False));
			TriggerEvent(name(ParseDelimitedString(Command," ",2,False)),self,harry(Level.PlayerHarryActor));
			return True;
			break;
		// EX: Camerashake time=2.0
		// Shakes the camera for 2.0 seconds
		case "CAMERASHAKE":
			CutLog("Issuing: CameraShake " $ ParseDelimitedString(Command," ",2,False));
			CutCommand_CameraShake(ParseDelimitedString(Command," ",2,False));
			return True;
			break;
		
		case "DISABLEPLAYERINPUT":
			CutLog("Issuing: DisablePlayerInput");
			harry(Level.PlayerHarryActor).DisablePlayerInput();
			return True;
			break;
		
		case "ENABLEPLAYERINPUT":
			CutLog("Issuing: EnablePlayerInput");
			harry(Level.PlayerHarryActor).EnablePlayerInput();
			return True;
			break;
		
		case "MESSAGE":
			CutLog(ParseDelimitedString(Command," ",2,True));
			return True;
			break;
		
		case "COMMENT":
			questionString = Localize("all",ParseDelimitedString(Command," ",2,True),"HPMenu");
			HPHud(harry(Level.PlayerHarryActor).myHUD).managerCutScene.SetCutCommentText(questionString);
			return True;
			break;
		
		case "SLOMO":
			harry(Level.PlayerHarryActor).SloMo(float(ParseDelimitedString(Command," ",2,True)));
			CutLog("Issuing: SloMo " $ string(float(ParseDelimitedString(Command," ",2,True))));
			return True;
			break;
		
		case "SAVEGAME":
			harry(Level.PlayerHarryActor).SaveGame();
			CutLog("Issuing: SaveGame ");
			return True;

		// Omega: Loadsave command, to make loading the game more convenient
		case "LOADSAVE":
			CutLog("Issuing: Loadsave ");
			harry(Level.PlayerHarryActor).ConsoleCommand("Loadgame 0");
			return True;

		// Omega: Numbered save and load commands as well
		// EX: Savenum 5
		// EX: Loadnum 5
		// Saves and loads from save slot 5
		case "SAVENUM":
			harry(Level.PlayerHarryActor).ConsoleCommand("Savegame " $int(ParseDelimitedString(Command," ",2,True)));
			CutLog("Issuing: SaveNum" $int(ParseDelimitedString(Command," ",2,True)));
			return True;
			break;

		case "LOADNUM":
			harry(Level.PlayerHarryActor).ConsoleCommand("Loadgame " $int(ParseDelimitedString(Command," ",2,True)));
			CutLog("Issuing: LoadNum" $int(ParseDelimitedString(Command," ",2,True)));
			return True;
			break;
		
		case "FORCEFINISH":
			parentCutScene.ForceFinish();
			CutLog("Issuing: FORCEFINISH");
			return True;
		
		// EX: ChangeGameState 180
		// Sets the gamestate to 180
		case "CHANGEGAMESTATE":
			CutLog("Issuing: SetGameState " $ ParseDelimitedString(Command," ",2,True));
			if (	!harry(Level.PlayerHarryActor).SetGameState(ParseDelimitedString(Command," ",2,True)) )
			{
				CutError("!E!R!R!O!R! GameState " $ ParseDelimitedString(Command," ",2,True) $ " is not a valid GameState in the *GameStateMasterList*!!!");
			}
			return True;

		// Omega: Console command for those that might need it
		// EX: ConsoleCommand Set Harry Fatness 255
		// Chungus
		case "CONSOLECOMMAND":
			harry(Level.PlayerHarryActor).ConsoleCommand((ParseDelimitedString(Command," ",2,True)));
			CutLog("Issuing: CONSOLECOMMAND: " $(ParseDelimitedString(Command," ",2,True)));
			return True;
		
		// EX: Goto Test
		// Goes to the label called "Test:"

		/*Capture Harry
		Capture Basecam

		Goto Test >>

		Harry M212Say Package=AllDialog Localize=HPDialog PC_Ara_Adv9aForest_10

	>>	Test:
		Release Harry
		Release Basecam */

		// Goto Test ClearCues will clear the script's previous cues, useful when going backwards into the script to do loops

		// This can skip over sections of script, especially powerful if used with If and IfNot statements
		case "GOTO":
			// Metallicafan212:	Find the label to go to!
			Index = CurScriptPosition;
			// Omega: Appended a colon
			ActionPart = ParseDelimitedString(Command," ",2,False)$ ":";
			//CutLog("Goto ActionPart: " $ActionPart);

			if(ParseDelimitedString(Command, " ", 3, True) ~= "CLEARCUES")
			{
				bClearCues = True;
			}
			
			// Omega: we should start from the top of the script so we can do backwards gotos, allowing looping scripts
			CurScriptPosition = 0;

			while(GetNextCommand(TempCommand))
			{
				subjectPart = ParseDelimitedString(TempCommand," ",1,False);
				
				if(CharAt(SubjectPart, Len(SubjectPart) - 1) == ":" && subjectPart ~= ActionPart)
				{
					if(bClearCues)
					{
						CutLog("GOTO: Clearing cues!");
						aCues.Empty();
					}
					// We shouldn't have to clear the pending cues
					//aPendingCues.Empty();

					// Metallicafan212:	Sucessfully found that label, skip to the next line
					CutLog("GOTO: Found label: " $subjectPart);
					return true;
				}
			}
			
			// Metallicafan212:	Failed to find the label! Go back
			CurScriptPosition = Index;
			
			CutError("Failed to Parse Command:" $ Command $ ". Can't find label");
			
			return false;
		
		default:
			// Metallicafan212:	See if it's just a label
			if(CharAt(SubjectPart, Len(SubjectPart) - 1) == ":")
			{
				// Metallicafan212:	It's a label
				return true;
			}
	}
	// EX: SetObjectiveId SomeLine
	// Will set the pause menu's objective text to some line inside of the HPDialog subtitles
	if ( subjectPart ~= "SetObjectiveId" )
	{
		harry(Level.PlayerHarryActor).SetObjectiveTextId(ParseDelimitedString(Command," ",2,False));
		return True;
	}

	//====================================Generic CutSubject Commanding========================================
	subjectActor = FindCutSubject(subjectPart);
	
	if ( subjectActor == None )
	{
		CutError("Failed to Parse Command:" $ Command $ ". Can't find subject");
		return False;
	}
	actionPart = ParseDelimitedString(Command," ",2,True);
	Index = InStr(actionPart,"*");
	
	if ( Index < 0 )
	{
		untilCue = GenerateUniqueCue();
		AddPendingCue(untilCue);
	} 
	else 
	{
		untilCue = ParseDelimitedString(Mid(actionPart,Index + 1)," ",1,False);
		if ( Len(untilCue) == 0 )
		{
			untilCue = GenerateUniqueCue();
		}
		actionPart = Left(actionPart,Index);
	}
	
	while ( (Asc(Right(actionPart,1)) == 32) || (Asc(Right(actionPart,1)) == 9) )
	{
		actionPart = Left(actionPart,Len(actionPart) - 1);
	}
	
	while ( (Asc(Right(untilCue,1)) == 32) || (Asc(Right(untilCue,1)) == 9) )
	{
		untilCue = Left(untilCue,Len(untilCue) - 1);
	}

	// Omega: In many cases, this is an intentional action even in official KW scripts. There's often times moves that take place during lines, for example.
	// Because of this, this is being reduced to a log about actions happening asynchronously, just in case this isn't intentional
	if ( (subjectActor.sCutNotifyCue != "") &&	!subjectActor.IsA('BaseCam') )
	{
		//CutError("Trying to issue command to:" $ string(subjectActor) $ " when previous CutCommand hasnt finished yet!!!!! PreviousCue:" $ subjectActor.sCutNotifyCue);
		CutLog(subjectActor.CutName$ " Doing asynchronous CutCommand. Previous Cue: " $subjectActor.sCutNotifyCue$ " Current cue: " $untilCue);
	}
	if ( subjectActor.CutNotifyActor != self )
	{
		CutError("Trying to issue command to:" $ string(subjectActor) $ " when actor is captured by:" $ string(subjectActor.CutNotifyActor));
	}

	// Omega: and now finally, issuing the command to the subject
	// If the if statement fails, it is because the command throws an error
	CutLog("Issuing to " $ subjectActor.CutName $ ":" $ actionPart $ " Cue:" $ untilCue);
	if (!subjectActor.CutCommand(actionPart,untilCue,bFastForward))
	{
		CutError("Command Error:" $ subjectActor.CutErrorString $ " From:" $ string(subjectActor));
		subjectActor.CutErrorString = "";
	}
}

function bool CutCommand_CameraShake (string Command)
{
	local Actor A;
	local string sString;
	local int I;
	local float magnitude;
	local float Time;

	magnitude = 100.0;
	Time = 0.5;
	I = 2;

	for(I = I; I < 20; I++)
	{
		sString = ParseDelimitedString(Command," ",I,False);
		if ( sString == "" )
		{
			break;
		}
		else
		if ( float(sString) > 0 )
		{
			magnitude = float(sString);
		} 
		else
		if ( Left(sString,Len("time=")) ~= "time=" )
		{
			Time = float(Mid(sString,Len("time=")));
		}
	}
	harry(Level.PlayerHarryActor).ShakeView(Time,magnitude,magnitude);
	return True;
}

function Play ()
{
	GotoState('Running');
}

function Pause ()
{
	GotoState('Idle');
}

// Omega: Triggers the fast forward for cutscene skipping
function FastForward ()
{
	local TimedCue TC;
	local Actor Act;
	local int I;

	CutLog("***Starting fastforward:");
	foreach AllActors(Class'TimedCue',TC)
	{
		if ( TC.CutNotifyActor == self )
		{
			TC.Timer();
		}
	}

	for(I = 0; I < aCapturedActors.Length; I++)
	{
		aCapturedActors[I].CutByPass();
		aCapturedActors[I].GlobalCutByPass();
	}
	bFastForward = True;
}

function Reset ()
{
}

auto state Idle
{
	begin:
		bPlaying = False;
}

// Omega: Obviously the state for running the script. Simple, only parses commands if there's no pending cues
state Running
{
	function BeginState ()
	{
		bPlaying = True;
		bFastForward = False;
		bUsingBaseCam = False;
		if ( parentCutScene.FileName != "" )
		{
			sThreadName = "<" $ parentCutScene.FileName $ ">." $threadNum;
		}
		else 
		{
			sThreadName = parentCutScene $ "." $threadNum;
		}
		CutLog("***CutScript Starting");
	}
	
	event Tick (float DeltaTime)
	{
		local string Command;
	
		bScriptAdvancing = False;

		while ( nPendingCues == 0 )
		{
			if (!GetNextCommand(Command) )
			{
				CutLog("***CutScript Finishing");
				GotoState('Finished');
				return;
			}
			lastCommand = Command;
			bScriptAdvancing = true;
			
			/*if ( !ParseCommand(Command) )
			{
				//KW left this empty? -AdamJD
			}*/
			// Omega: No reason to if this, in that case
			ParseCommand(Command);
		
			if ( bFastForward )
			{
				return;
			}
		}
	}
	
}

function DumpCurState ()
{
	CutLog("*****************************************************************************");
	CutLog("*CutDump" $ string(self));
	CutLog("*bPlaying:" $ string(bPlaying) $ "*bFastForward:" $ string(bFastForward) $ "*bScriptAdvancing:" $ string(bScriptAdvancing));
	CutLog("*Pending Cues:" $ string(nPendingCues));
	CutLog("*Last Command:" $ lastCommand);
	CutLog("*****************************************************************************");
}

state Finished
{
	function BeginState()
	{
		bPlaying = False;
	}
	/*begin:
		bPlaying = False;*/
}

defaultproperties
{
	bHidden=True
}
