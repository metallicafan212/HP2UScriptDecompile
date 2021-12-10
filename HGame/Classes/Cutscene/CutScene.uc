//================================================================================
// CutScene.
//================================================================================

class CutScene extends Actor;

const MAX_THREADS=20;
var() string aThreadScripts[20];
var CutScript aThreads[20];
var bool bHasBeenDisabled;
var bool Saved_bBumpStarts;
var bool Saved_bTriggerStarts;
var bool Saved_bDoImmediateStart;
var() bool bBumpStarts;
var() bool bTriggerStarts;
var() bool bLevelLoadStarts;
var() string FileName;
var() bool bPlayOnce;
var() bool bDelayLevelFadeIn;
var() bool bTriggerTogglesBumpStart;
var() bool bSkipAllowed;
var bool bDoImmediateStart;
var bool bPlaying;
var int numScriptsPlaying;
var int nPlayedCount;
var bool bFastForwarding;
var int safetyLoopCount;

function CutSceneLog (string Str)
{
  Level.PlayerHarryActor.ClientMessage("CutSceneLog:<" $ FileName $ ">" $ Str);
  Log("CutSceneLog:<" $ FileName $ ">" $ Str);
}

function OpenCutConsole()
{
  HPConsole(Level.PlayerHarryActor.Player.Console).ShowCutConsole(True);
}

function CutCue (string cue)
{
  local int I;

  for(I = 0; I < ArrayCount(aThreads); I++)
  {
    if ( aThreads[I] != None )
    {
      aThreads[I].CutCue(cue);
    }
  }
}

event OnResolveGameState()
{
  if (  !bInCurrentGameState )
  {
    GotoState('disabled');
    Log("*** " $ string(self) $ " is NOT in the current GameState. CurrentGameState = " $ harry(Level.PlayerHarryActor).CurrentGameState);
  } else {
    GotoState('Idle');
    Log("*** " $ string(self) $ " is *IN* the current GameState. CurrentGameState = " $ harry(Level.PlayerHarryActor).CurrentGameState);
    if ( bDelayLevelFadeIn && bLevelLoadStarts )
    {
      if ( bPlayOnce && (nPlayedCount > 0) )
      {
        return;
      } else {
        harry(Level.PlayerHarryActor).FadeRate = 0.0;
      }
    }
  }
}

event PostBeginPlay()
{
  if ( bLevelLoadStarts )
  {
    bDoImmediateStart = True;
  }
}

function CreateThreads()
{
  local int I;
  local int t;
  local string Line;

  if ( FileName != "" )
  {
	for(t = 0; t < ArrayCount(aThreads); t++)
    {
      Line = Localize("thread_"$t,"line_0","Cutscenes\\" $FileName);
      if ( InStr(Line,"<?") == -1 )
      {
        aThreads[t] = Spawn(Class'CutScriptDisk');
        CutScriptDisk(aThreads[t]).load("thread_" $t,"Cutscenes\\" $FileName);
        aThreads[t].parentCutScene = self;
        aThreads[t].threadNum = t;
        aThreads[t].Play();
      }
    }
  } else {
	for(I = 0; I < ArrayCount(aThreads); I++)
    {
      if ( Len(aThreadScripts[I]) > 0 )
      {
        aThreads[I] = Spawn(Class'CutScript');
        aThreads[I].Script = aThreadScripts[I];
        aThreads[I].parentCutScene = self;
        aThreads[t].threadNum = t;
        aThreads[I].Play();
      }
    }
  }
}

function DeleteThreads()
{
  local int I;

  for(I = 0; I < ArrayCount(aThreads); I++)
  {
    if ( aThreads[I] != None )
    {
      aThreads[I].Destroy();
    }
  }
}

auto state disabled
{
  event BeginState()
  {
    harry(Level.PlayerHarryActor).ClientMessage(string(self) $ " Entering DISABLED state");
    if ( bPlaying || bFastForwarding )
    {
      CutSceneLog("Error. Entering disabled while still running. Forceing finish");
      ForceFinish();
      bPlaying = False;
      bFastForwarding = False;
    }
    if ( bInCurrentGameState )
    {
      harry(Level.PlayerHarryActor).ClientMessage(string(self) $ " Changing to ENABLED state");
      GotoState('Idle');
    }
  }
  
  event Touch (Actor Other)
  {
  }
  
  event Trigger (Actor Other, Pawn EventInstigator)
  {
  }
  
  function Play()
  {
  }
  
}

state Idle
{
  event BeginState()
  {
    harry(Level.PlayerHarryActor).ClientMessage(string(self) $ " Entering ENABLED state");
    if (  !bInCurrentGameState )
    {
      harry(Level.PlayerHarryActor).ClientMessage(string(self) $ " Changing to DISABLED state");
      GotoState('disabled');
    }
  }
  
  event Touch (Actor Other)
  {
    if ( harry(Other) != None )
    {
      harry(Other).ClientMessage(string(self) $ " Bumped. bBumpStarts=" $ string(bBumpStarts));
      if ( bBumpStarts &&  !harry(Other).HarryIsDead() )
      {
        Play();
      }
    }
  }
  
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    if ( harry(Other).HarryIsDead() )
    {
      return;
    }
    if ( bTriggerTogglesBumpStart )
    {
      bBumpStarts =  !bBumpStarts;
      harry(Level.PlayerHarryActor).ClientMessage(string(self) $ "+++++++++++++++++++ Triggered bTriggerTogglesBumpStart. bBumpStarts=" $ string(bBumpStarts));
    }
    if ( bInCurrentGameState && bTriggerStarts )
    {
      if ( bPlayOnce )
      {
        bTriggerStarts = False;
      }
      Play();
    }
  }
  
 begin:
  bPlaying = False;
  if ( bDoImmediateStart )
  {
    bDoImmediateStart = False;
    Sleep(0.2);
    Play();
  }
}

function ForceFinish()
{
  local int I;

  CutSceneLog("***Force Finishing");

  for(I = 0; I < MAX_THREADS; I++)
  {
    if ( (aThreads[I] != None) && aThreads[I].bPlaying )
    {
      aThreads[I].GotoState('Finished');
    }
  }
}

function bool CheckFinished()
{
  local int I;
  local bool bStillRunning;

  bStillRunning = False;

  for(I = 0; I < MAX_THREADS; I++)
  {
    if ( (aThreads[I] != None) && aThreads[I].bPlaying )
    {
      bStillRunning = True;
    }
  }
  return  !bStillRunning;
}

function bool CheckAdvancing()
{
  local int I;
  local bool bStillAdvancing;

  bStillAdvancing = False;

  for(I = 0; I < MAX_THREADS; I++)
  {
    if ( (aThreads[I] != None) && aThreads[I].bPlaying && aThreads[I].bScriptAdvancing )
    {
      bStillAdvancing = True;
    }
  }
  return bStillAdvancing;
}

function FastForward()
{
  if ( bPlaying || bFastForwarding )
  {
    CutSceneLog("***Error. Global FastForward called! StateName" $ string(GetStateName()));
    ForceFinish();
    bPlaying = False;
    bFastForwarding = False;
  }
}

state Running
{
  event Tick (float Time)
  {
  }
  
  function FastForward()
  {
    if ( bSkipAllowed )
    {
      CutSceneLog("Starting Fastforward");
      GotoState('FastForwarding');
    } else {
      CutSceneLog("Refusing Fastforward: bSkipAllowed==false");
    }
  }
  
 begin:
  bPlaying = True;
  Default.numScriptsPlaying++;
 loop:
  if ( CheckFinished() )
  {
    GotoState('Finished');
  }
  Sleep(0.5);
  goto ('Loop');
}

function DumpCurState()
{
  local int I;

  CutSceneLog("*****************************************************************************");
  CutSceneLog("*****************************************************************************");
  CutSceneLog("*CutScript Dump:" $ FileName $ "->" $ string(self));
  CutSceneLog("*CutScene Flags:" $ " bBumpStarts:" $ string(bBumpStarts) $ " bTriggerStarts:" $ string(bTriggerStarts) $ " bLevelLoadStarts:" $ string(bLevelLoadStarts) $ " bPlayOnce:" $ string(bPlayOnce) $ " bSkipAllowed:" $ string(bSkipAllowed) $ " bDoImmediateStart:" $ string(bDoImmediateStart) $ " BumpStarts:" $ string(bBumpStarts));
  CutSceneLog("*CutScene State:" $ string(GetStateName()));
  CutSceneLog("*CutScene Status:" $ " bPlaying:" $ string(bPlaying) $ " bFastForwarding:" $ string(bFastForwarding) $ " safetyLoopCount:" $ string(safetyLoopCount) $ " nPlayedCount:" $ string(nPlayedCount));
  CutSceneLog("*****************************************************************************");

  for(I = 0; I < MAX_THREADS; I++)
  {
    if ( (aThreads[I] != None) && aThreads[I].bPlaying )
    {
      aThreads[I].DumpCurState();
    }
  }
  CutSceneLog("*****************************************************************************");
  CutSceneLog("*****************************************************************************");
}

state FastForwarding
{
  event BeginState()
  {
    safetyLoopCount = 0;
    bFastForwarding = True;
    harry(Level.PlayerHarryActor).ClientMessage(string(self) $ " FastForwarding");
  }
  
  function StartThreadsFF()
  {
    local int I;
  
	for(I = 0; I < MAX_THREADS; I++)
    {
      if ( (aThreads[I] != None) && aThreads[I].bPlaying )
      {
        aThreads[I].FastForward();
      }
    }
  }
  
  function FastForward()
  {
    CutSceneLog("***Fastforward called while already fastforwarding");
  }
  
 begin:
  Sleep(0.2);
  StartThreadsFF();
 loop:
  if (  !CheckAdvancing() )
  {
    safetyLoopCount++;
  }
  if ( CheckFinished() || (safetyLoopCount > 15) )
  {
    if ( safetyLoopCount > 15 )
    {
      CutSceneLog("***CUTERROR:SKIP ERROR:" $ string(self) $ " failed to advance after " $ string(safetyLoopCount) $ " loops");
      DumpCurState();
    }
    CutSceneLog(string(self) $ " skipped");
    bFastForwarding = False;
    GotoState('Finished');
  }
  Sleep(0.1);
  goto ('Loop');
}

state Finished
{
Begin:
  bPlaying = False;
  Default.numScriptsPlaying--;
  DeleteThreads();
Loop:
  if (  !bPlayOnce )
  {
    GotoState('Idle');
  }
}

function Play()
{
  if ( bPlaying )
  {
    return;
  }
  if ( bPlayOnce && (nPlayedCount > 0) )
  {
    return;
  }
  nPlayedCount++;
  CutSceneLog(" starting for the " $ string(nPlayedCount) $ " time");
  CreateThreads();
  GotoState('Running');
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string targetName;
  local Actor TempActor;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    return True;
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      return True;
    }
  //}
  return Super.CutCommand(Command,cue,bFastFlag);
}

defaultproperties
{
    bBumpStarts=True

    bPlayOnce=True

    bSkipAllowed=True

    bHidden=True

    // DrawType=2
	DrawType=DT_Mesh

    Mesh=SkeletalMesh'HProps.skCutSceneMarkerMesh'

    AmbientGlow=75

    bCollideActors=True
}
