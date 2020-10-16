//================================================================================
// CutScript.
//================================================================================

class CutScript extends Actor;

const MAX_CAPTURED_ACTORS=30;
const MAX_CUES=210;
var(Script) string Script;
var int curScriptPosition;
var string aCues[210];
var string aPendingCues[210];
var int nPendingCues;
var int nCues;
var int lastCueNum;
var string pendingTimerCue;
var Actor aCapturedActors[30];
var bool bPlaying;
var CutScene parentCutScene;
var int threadNum;
var string sThreadName;
var bool bFastForward;
var string lastCommand;
var bool bScriptAdvancing;
var bool bUsingBaseCam;

function bool CaptureActor (string actName)
{
  local int I;
  local Actor Act;

  foreach AllActors(Class'Actor',Act)
  {
    if ( Act.CutName ~= actName )
    {
      // goto JL002C;
	  break;
    }
  }
  if ( Act == None )
  {
    CutError("Can't Capture " $ actName $ ". Actor not found.");
    return False;
  }
  if ( Act.CutNotifyActor != None )
  {
    if ( (Act.CutNotifyActor == Act) && Act.IsInState('DoingBumpLine') )
    {
      Act.CutCue("");
      if ( Act.CutNotifyActor != None )
      {
        CutError("Bump/Capture Hack Failed. " $ actName $ ". Actor already captured by" $ string(Act.CutNotifyActor) $ ".");
        return False;
      }
    } else {
      CutError("Can't Capture " $ actName $ ". Actor already captured by" $ string(Act.CutNotifyActor) $ ".");
      return False;
    }
  }
  // I = 0;
  // if ( I < 30 )
  for(I = 0; I < MAX_CAPTURED_ACTORS; I++)
  {
    if ( aCapturedActors[I] == None )
    {
      if ( Act.CutCommand("CAPTURE") )
      {
        Act.CutNotifyActor = self;
        aCapturedActors[I] = Act;
        if ( Act.IsA('BaseCam') )
        {
          Act.TickParent2 = self;
        }
        return True;
      } else {
        CutError("Failed to Capture " $ actName $ ". Actor refused capture.");
        return False;
      }
    }
    // I++;
    // goto JL0192;
  }
  CutError("Failed to Capture " $ actName $ ". Too many captured actors.");
  return False;
}

function bool ReCaptureActor (string actName)
{
  local int I;
  local Actor Act;

  foreach AllActors(Class'Actor',Act)
  {
    if ( Act.CutName ~= actName )
    {
      // goto JL002C;
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
  // I = 0;
  // if ( I < 30 )
  for(I = 0; I < MAX_CAPTURED_ACTORS; I++)
  {
    if ( aCapturedActors[I] == None )
    {
      Act.CutNotifyActor = self;
      aCapturedActors[I] = Act;
      if ( Act.IsA('BaseCam') )
      {
        Act.TickParent2 = self;
      }
      return True;
    }
    // I++;
    // goto JL00CC;
  }
  CutError("Failed to ReCapture " $ actName $ ". Too many captured actors.");
  return False;
}

function bool ReleaseActor (string actName)
{
  local int I;

  // I = 0;
  // if ( I < 30 )
  for(I = 0; I < MAX_CAPTURED_ACTORS; I++)
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
      } else {
        CutError("Failed to Release " $ actName $ ". Actor refused Release!?!?!?!.");
        return False;
      }
    }
    // I++;
    // goto JL0007;
  }
  CutError("Failed to Release " $ actName $ ". Actor not captured.");
  return False;
}

function Actor FindCutSubject (string subjectName)
{
  local int I;

  if ( subjectName ~= "baseCam" )
  {
    bUsingBaseCam = True;
    return harry(Level.PlayerHarryActor).Cam;
  }
  // I = 0;
  // if ( I < 30 )
  for(I = 0; I < MAX_CAPTURED_ACTORS; I++)
  {
    if ( (aCapturedActors[I] != None) && (aCapturedActors[I].CutName ~= subjectName) )
    {
      return aCapturedActors[I];
    }
    // I++;
    // goto JL003F;
  }
  CutError("Failed to find " $ subjectName $ ". Actor not captured.");
  return None;
}

function CutLog (string Str)
{
  Level.PlayerHarryActor.ClientMessage("CutLog:" $ sThreadName $ "->" $ Str);
  if (  !Class'Version'.Default.bDebugEnabled )
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

function bool GetNextCommand (out string Command)
{
  local string Line;
  local int commentIndex;
  local int OtherCommentIndex;

  if (  !GetNextLine(Line) )
  {
    return False;
  }
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
  } else {
    Command = Line;
  }
  return True;
}

function CutCue (string cue)
{
  local int I;

  if ( cue == "" )
  {
    CutError("Error blank cue");
  }
  aCues[nCues] = cue;
  nCues++;
  // if ( nCues > 210 )
  if(nCues > MAX_CUES)
  {
    CutError("Failed to CutCue. Exceeded MAX_CUES");
  }
  if ( nPendingCues > 0 )
  {
    // I = 0;
    // if ( I < nPendingCues )
	for(I = 0; I < nPendingCues; I++)
    {
      if ( aPendingCues[I] ~= cue )
      {
        if ( nPendingCues - 1 == I )
        {
          aPendingCues[I] = "";
          nPendingCues--;
        } else {
          aPendingCues[I] = aPendingCues[nPendingCues - 1];
          nPendingCues--;
        }
      }
      // I++;
      // goto JL0084;
    }
  }
}

function AddPendingCue (string cue)
{
  local int I;

  if ( cue == "" )
  {
    CutError("Error blank Pending cue");
  }
  // I = 0;
  // if ( I < nCues )
  for(I = 0; I < nCues; I++)
  {
    if ( aCues[I] ~= cue )
    {
      return;
    }
    // I++;
    // goto JL0032;
  }
  aPendingCues[nPendingCues] = cue;
  nPendingCues++;
  // if ( nPendingCues > 210 )
  if(nPendingCues > MAX_CUES)
  {
    CutError("Failed to AddPendingCue. Exceeded Pending MAX_CUES");
  }
}

function string GenerateUniqueCue ()
{
  Default.lastCueNum++;
  return "_" $ Default.lastCueNum $ "UniqueCue";
}

function bool ParseCommand (string Command)
{
  local string subjectPart;
  local string actionPart;
  local string untilCue;
  local Actor subjectActor;
  local BossEncounterTrigger aTrigger;
  local int Index;
  local int eow;
  local int I;
  local float timerDuration;
  local string questionString;
  local TimedCue tcue;
  local name N;

  subjectPart = ParseDelimitedString(Command," ",1,False);
  if ( Len(subjectPart) == 0 )
  {
    return True;
  }
  if ( subjectPart ~= "IF" )
  {
    questionString = ParseDelimitedString(Command," ",2,False);
    if (  !Level.PlayerHarryActor.CutQuestion(questionString) )
    {
      if ( Level.PlayerHarryActor.CutErrorString != "" )
      {
        CutError(Level.PlayerHarryActor.CutErrorString);
      }
      return True;
    } else {
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
    } else {
      Command = Mid(Command,InStr(Command,questionString) + Len(questionString) + 1);
      subjectPart = ParseDelimitedString(Command," ",1,False);
    }
  }
  switch (subjectPart)
  {
    case "CUE":
    CutLog("Issuing: CUE:" $ ParseDelimitedString(Command," ",2,False));
    parentCutScene.CutCue(ParseDelimitedString(Command," ",2,False));
    return True;
    break;
    case "WAITFOR":
    CutLog("Issuing: WAITFOR:" $ ParseDelimitedString(Command," ",2,False));
    AddPendingCue(ParseDelimitedString(Command," ",2,False));
    return True;
    break;
    case "SLEEP":
    if ( bFastForward )
    {
      return True;
    }
    CutLog("Issuing: SLEEP:" $ ParseDelimitedString(Command," ",2,False));
    pendingTimerCue = GenerateUniqueCue();
    timerDuration = float(ParseDelimitedString(Command," ",2,False));
    if ( (timerDuration > 0) && (timerDuration < 100) )
    {
      tcue = Spawn(Class'TimedCue');
      tcue.CutNotifyActor = self;
      tcue.SetupTimer(timerDuration,pendingTimerCue);
      AddPendingCue(pendingTimerCue);
    } else {
      CutError("Invalid SLEEP duration:" $ string(timerDuration));
    }
    return True;
    break;
    case "CAPTURE":
    CutLog("Issuing: CAPTURE " $ ParseDelimitedString(Command," ",2,False));
    CaptureActor(ParseDelimitedString(Command," ",2,False));
    return True;
    break;
    case "RECAPTURE":
    CutLog("Issuing: RECAPTURE " $ ParseDelimitedString(Command," ",2,False));
    ReCaptureActor(ParseDelimitedString(Command," ",2,False));
    return True;
    break;
    case "RELEASE":
    CutLog("Issuing: RELEASE " $ ParseDelimitedString(Command," ",2,False));
    ReleaseActor(ParseDelimitedString(Command," ",2,False));
    return True;
    break;
    case "TRIGGER":
    CutLog("Issuing: TRIGGER " $ ParseDelimitedString(Command," ",2,False));
    TriggerEvent(name(ParseDelimitedString(Command," ",2,False)),self,harry(Level.PlayerHarryActor));
    return True;
    break;
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
    case "FORCEFINISH":
    parentCutScene.ForceFinish();
    CutLog("Issuing: FORCEFINISH");
    return True;
    case "CHANGEGAMESTATE":
    CutLog("Issuing: SetGameState " $ ParseDelimitedString(Command," ",2,True));
    if (  !harry(Level.PlayerHarryActor).SetGameState(ParseDelimitedString(Command," ",2,True)) )
    {
      CutError("!E!R!R!O!R! GameState " $ ParseDelimitedString(Command," ",2,True) $ " is not a valid GameState in the *GameStateMasterList*!!!");
    }
    return True;
    default:
    break;
  }
  if ( subjectPart ~= "SetObjectiveId" )
  {
    harry(Level.PlayerHarryActor).SetObjectiveTextId(ParseDelimitedString(Command," ",2,False));
    return True;
  }
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
  } else {
    untilCue = ParseDelimitedString(Mid(actionPart,Index + 1)," ",1,False);
    if ( Len(untilCue) == 0 )
    {
      untilCue = GenerateUniqueCue();
    }
    actionPart = Left(actionPart,Index);
  }
  // if ( (Asc(Right(actionPart,1)) == 32) || (Asc(Right(actionPart,1)) == 9) )
  while ( (Asc(Right(actionPart,1)) == 32) || (Asc(Right(actionPart,1)) == 9) )
  {
    actionPart = Left(actionPart,Len(actionPart) - 1);
    // goto JL0979;
  }
  // if ( (Asc(Right(untilCue,1)) == 32) || (Asc(Right(untilCue,1)) == 9) )
  while ( (Asc(Right(untilCue,1)) == 32) || (Asc(Right(untilCue,1)) == 9) )
  {
    untilCue = Left(untilCue,Len(untilCue) - 1);
    // goto JL09B7;
  }
  if ( (subjectActor.sCutNotifyCue != "") &&  !subjectActor.IsA('BaseCam') )
  {
    CutError("Trying to issue command to:" $ string(subjectActor) $ " when previous CutCommand hasnt finished yet!!!!! PreviousCue:" $ subjectActor.sCutNotifyCue);
  }
  if ( subjectActor.CutNotifyActor != self )
  {
    CutError("Trying to issue command to:" $ string(subjectActor) $ " when actor is captured by:" $ string(subjectActor.CutNotifyActor));
  }
  CutLog("Issuing to " $ subjectActor.CutName $ ":" $ actionPart $ " Cue:" $ untilCue);
  if (  !subjectActor.CutCommand(actionPart,untilCue,bFastForward) )
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
  // I = I;
  // if ( I < 20 )
  for(I = I; I < 20; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( sString == "" )
    {
      // goto JL00BA;
	  break;
    } else //{
      if ( float(sString) > 0 )
      {
        magnitude = float(sString);
      } else //{
        if ( Left(sString,Len("time=")) ~= "time=" )
        {
          Time = float(Mid(sString,Len("time=")));
        }
      //}
    //}
    // I++;
    // goto JL0029;
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
// JL005C:
  // I = 0;
  // if ( I < 30 )
  for(I = 0; I < MAX_CAPTURED_ACTORS; I++)
  {
    if ( aCapturedActors[I] != None )
    {
      aCapturedActors[I].CutBypass();
      aCapturedActors[I].GlobalCutBypass();
    }
    // I++;
    // goto JL005C;
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
    } else {
      sThreadName = parentCutScene $ "." $threadNum;
    }
    CutLog("***CutScript Starting");
  }
  
  event Tick (float DeltaTime)
  {
    local string Command;
  
    bScriptAdvancing = False;
    // if ( nPendingCues == 0 )
	while ( nPendingCues == 0 )
    {
      if (  !GetNextCommand(Command) )
      {
        CutLog("***CutScript Finishing");
        GotoState('Finished');
        return;
      }
      lastCommand = Command;
	  bScriptAdvancing = true;
	  
      if ( !ParseCommand(Command) )
	  {
		//KW left this empty? -AdamJD
	  }
	  
      if ( bFastForward )
      {
        return;
      }
      // goto JL0008;
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
begin:
  bPlaying = False;
}

defaultproperties
{
    bHidden=True

}
