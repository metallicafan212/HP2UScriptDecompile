//================================================================================
// HPConsole.
//================================================================================

class HPConsole extends baseConsole;

const BUTTONS_Y=193;
const BUTTONS_X=185;
var UWindowDialogClientWindow levSelect;
var HGameButton OKButton;
var bool bLevelSelect;
var bool firstRun;
var int CanvasSizeX;
var int CanvasSizeY;
var float fFadeDirection;
var bool bShootingRange;
var bool bLoadNewLevel;
var bool bFastForwardMode;
var bool bFastForwarding;
var FEBook menuBook;
var bool bToggleMoveModePressed;
var bool bShowPos;
var bool bBoostKeyPressed;
var ParticleFX MouseParticle;
var bool bShiftDown;
var UWindowMessageBoxCW TestConfirm;
var bool bInHubFlow;
var string ResTimeOutSettings;
var ShortCutWindow SCWindow;
var CutLogWindow CutConsoleWindow;
var bool bShowCutConsole;
var float fSlomoSpeed;
var string CutSkippingString;
var bool bVendorBar;

exec function DestroyClass (string Input)
{
  harry(Viewport.Actor).DestroyClass(Input);
}

exec function ListGroups ()
{
  harry(Viewport.Actor).ListGroups();
}

exec function ShortCut ()
{
  if ( SCWindow == None )
  {
    SCWindow = ShortCutWindow(Root.CreateWindow(Class'ShortCutWindow',64.0,64.0,320.0,320.0));
  } 
  //else 
  //{
  else if ( SCWindow.bUWindowActive )
  {
    SCWindow.Close();
  } 
  else 
  {
    SCWindow.ActivateWindow(0,False);
  }
  //}
}

function CutConsoleLog (string Msg)
{
  CutLogClientWindow(CutConsoleWindow.ClientArea).TextArea.AddText(Msg);
}

function ShowCutConsole (bool flag)
{
  if ( flag )
  {
    bShowCutConsole = True;
    CutConsoleWindow.ShowWindow();
  } 
  else 
  {
    bShowCutConsole = False;
    CutConsoleWindow.HideWindow();
  }
}

exec function Lumos_Debug ()
{
  if ( baseWand(harry(Viewport.Actor).Weapon).TheLumosLight != None )
  {
    baseWand(harry(Viewport.Actor).Weapon).TheLumosLight.ShowDebugInfo();
  }
}

exec function Wand_Debug (bool bInput)
{
  baseWand(harry(Viewport.Actor).Weapon).SetDebugMode(bInput);
}

exec function SpellCursor_Debug (bool bInput)
{
  harry(Viewport.Actor).SpellCursor.SetDebugMode(bInput);
}

exec function SpellCursor_Distance (float fInput)
{
  harry(Viewport.Actor).SpellCursor.SetLOSDistance(fInput);
}

exec function Cam_Mode (string sInput)
{
  harry(Viewport.Actor).Cam.SetModeByString(sInput);
}

exec function Cam_Settings ()
{
  harry(Viewport.Actor).Cam.ShowSettings();
}

exec function Cam_SaveSettings (int iInput)
{
  harry(Viewport.Actor).Cam.SaveUserSettings(iInput);
}

exec function Cam_LoadSettings (int iInput)
{
  harry(Viewport.Actor).Cam.LoadUserSettings(iInput);
}

exec function Cam_MinPitch (float fInput)
{
  harry(Viewport.Actor).Cam.SetMinPitch(fInput);
}

exec function Cam_MaxPitch (float fInput)
{
  harry(Viewport.Actor).Cam.SetMaxPitch(fInput);
}

exec function Cam_XOffset (float fInput)
{
  harry(Viewport.Actor).Cam.SetXOffset(fInput);
}

exec function Cam_YOffset (float fInput)
{
  harry(Viewport.Actor).Cam.SetYOffset(fInput);
}

exec function Cam_ZOffset (float fInput)
{
  harry(Viewport.Actor).Cam.SetZOffset(fInput);
}

exec function Cam_Distance (float fInput)
{
  harry(Viewport.Actor).Cam.SetDistance(fInput);
}

exec function Cam_RotStepYaw (float fInput)
{
  harry(Viewport.Actor).Cam.SetRotStepYaw(fInput);
}

exec function Cam_RotStepPitch (float fInput)
{
  harry(Viewport.Actor).Cam.SetRotStepPitch(fInput);
}

exec function Cam_RotStepRoll (float fInput)
{
  harry(Viewport.Actor).Cam.SetRotStepRoll(fInput);
}

exec function Cam_RotTightness (float fInput)
{
  harry(Viewport.Actor).Cam.SetRotTightness(fInput);
}

exec function Cam_RotSpeed (float fInput)
{
  harry(Viewport.Actor).Cam.SetRotSpeed(fInput);
}

exec function Cam_MoveBackTightness (float fInput)
{
  harry(Viewport.Actor).Cam.SetMoveBackTightness(fInput);
}

exec function Cam_MoveTightness (float fInput)
{
  harry(Viewport.Actor).Cam.SetMoveTightness(fInput);
}

exec function Cam_MoveSpeed (float fInput)
{
  harry(Viewport.Actor).Cam.SetMoveSpeed(fInput);
}

exec function Cam_Yaw (float fInput)
{
  harry(Viewport.Actor).Cam.SetYaw(fInput);
}

exec function Cam_Pitch (float fInput)
{
  harry(Viewport.Actor).Cam.SetPitch(fInput);
}

exec function Cam_Roll (float fInput)
{
  harry(Viewport.Actor).Cam.SetRoll(fInput);
}

exec function Cam_Target (name nInput)
{
  harry(Viewport.Actor).Cam.SetTargetActor(nInput);
}

exec function Cam_SyncPos (bool bInput)
{
  harry(Viewport.Actor).Cam.SetSyncPosWithTarget(bInput);
}

exec function Cam_SyncRot (bool bInput)
{
  harry(Viewport.Actor).Cam.SetSyncRotWithTarget(bInput);
}

exec function Cam_FOV (float fInput)
{
  harry(Viewport.Actor).Cam.SetFOV(fInput,1.0,True);
}

exec function Cam_CutCommand (string sInput)
{
  harry(Viewport.Actor).Cam.CutCommand(sInput);
}

exec function Boss (string sInput)
{
  baseBoss(harry(Viewport.Actor).BossTarget).TweakSetting(sInput);
}

exec function SetGState (string Str)
{
  harry(Viewport.Actor).SetGameState(Str);
}

exec function ShowGState ()
{
  harry(Viewport.Actor).ClientMessage("Current GameState : " $ harry(Viewport.Actor).CurrentGameState);
}

exec function ShowCardData ()
{
  harry(Viewport.Actor).managerStatus.ShowCardData();
}

exec function AddHPointsG (int nPoints)
{
  harry(Viewport.Actor).managerStatus.AddHPointsG(nPoints);
}

exec function AddHPointsH (int nPoints)
{
  harry(Viewport.Actor).managerStatus.AddHPointsH(nPoints);
}

exec function AddHPointsS (int nPoints)
{
  harry(Viewport.Actor).managerStatus.AddHPointsS(nPoints);
}

exec function AddHPointsR (int nPoints)
{
  harry(Viewport.Actor).managerStatus.AddHPointsR(nPoints);
}

exec function AddFMucus (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddFMucus(nCount);
}

exec function AddWBark (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddWBark(nCount);
}

exec function AddBicorn (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddBicorn(nCount);
}

exec function AddBoomslang (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddBoomslang(nCount);
}

exec function AddNimbus (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddNimbus(nCount);
}

exec function AddQArmor (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddQArmor(nCount);
}

exec function AddPotions (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddPotions(nCount);
}

exec function AddBeans (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddBeans(nCount);
}

exec function AddHealth (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddHealth(nCount);
}

exec function AddHealthPotential (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddHealthPotential(nCount);
}

exec function AddLock1 (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddLock1(nCount);
}

exec function AddLock2 (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddLock2(nCount);
}

exec function AddLock3 (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddLock3(nCount);
}

exec function AddLock4 (int nCount)
{
  harry(Viewport.Actor).managerStatus.AddLock4(nCount);
}

exec function ShowLock1Count ()
{
  harry(Viewport.Actor).ClientMessage(string(harry(Viewport.Actor).managerStatus.GetLock1Count()));
}

exec function ShowLock2Count ()
{
  harry(Viewport.Actor).ClientMessage(string(harry(Viewport.Actor).managerStatus.GetLock2Count()));
}

exec function ShowLock3Count ()
{
  harry(Viewport.Actor).ClientMessage(string(harry(Viewport.Actor).managerStatus.GetLock3Count()));
}

exec function ShowLock4Count ()
{
  harry(Viewport.Actor).ClientMessage(string(harry(Viewport.Actor).managerStatus.GetLock4Count()));
}

exec function GiveCardToHarry (int nCardId)
{
  harry(Viewport.Actor).managerStatus.GiveCardToHarry(nCardId);
}

exec function GiveAllCardsToHarry ()
{
  harry(Viewport.Actor).managerStatus.GiveAllCardsToHarry();
}

exec function GiveCardToVendors (int nCardId)
{
  harry(Viewport.Actor).managerStatus.GiveCardToVendors(nCardId);
}

exec function GiveSpell (string Str)
{
  harry(Viewport.Actor).AddToSpellBookByString(Str);
}

exec function GiveAllSpells ()
{
  harry(Viewport.Actor).AddAllSpellsToSpellBook();
}

exec function TakeAllSpells ()
{
  harry(Viewport.Actor).ClearSpellBook();
}

exec function ArtTest ()
{
  local harry PlayerHarry;
  local StatusManager managerStatus;
  local StatusGroup sg;
  local ChallengeScoreManager ChallengeScore;

  PlayerHarry = harry(Viewport.Actor);
  managerStatus = PlayerHarry.managerStatus;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupQGear');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupPotionIngr');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupPolyIngr');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupPotions');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupLocks');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg = managerStatus.GetStatusGroup(Class'StatusGroupWizardCards');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg.IncrementCount(Class'StatusItemBronzeCards',1);
  sg = managerStatus.GetStatusGroup(Class'StatusGroupStars');
  sg.GameEffectType = ET_Permanent;
  sg.CurrEffectType = ET_Permanent;
  sg.IncrementCount(Class'StatusItemStars',4);
  AddNimbus(1);
  AddQArmor(1);
  AddWBark(1249);
  AddFMucus(2);
  AddBicorn(1);
  AddBoomslang(1);
  AddPotions(99);
  AddBeans(342);
  AddHealthPotential(500);
  AddHealth(-150);
  AddHPointsG(1436);
  GiveAllCardsToHarry();
  ChallengeScore = ChallengeScoreManager(PlayerHarry.FancySpawn(Class'ChallengeScoreManager'));
  ChallengeScore.BeginChallenge();
}

exec function ShowTimer (bool bShow)
{
  local CountdownTimerManager TimerManager;

  foreach Viewport.Actor.AllActors(Class'CountdownTimerManager',TimerManager)
  {
    TimerManager.bShowNumericTime = bShow;
  }
}

exec function DrawScale (float fScale)
{
  harry(Viewport.Actor).DrawScale = fScale;
}

exec function Fatness (int iFatness)
{
  harry(Viewport.Actor).Fatness = iFatness;
}

exec function Opacity (float fOpacity)
{
  harry(Viewport.Actor).Opacity = fOpacity;
}

exec function GoyleMode ()
{
  harry(Viewport.Actor).bIsGoyle =  !harry(Viewport.Actor).bIsGoyle;
  harry(Viewport.Actor).SetNewMesh();
}

exec function FPSMode ()
{
  harry(Viewport.Actor).Cam.SetDistance(0.0);
  harry(Viewport.Actor).Cam.SetZOffset(32.0);
  harry(Viewport.Actor).Opacity = 0.0;
}

exec function SwordMode ()
{
  harry(Viewport.Actor).ToggleUseSword();
  if ( harry(Viewport.Actor).bHarryUsingSword )
  {
    harry(Viewport.Actor).bMSword = True;
    harry(Viewport.Actor).makeTarget();
    harry(Viewport.Actor).SpellCursor.bSpellCursorAlwaysOn = True;
  } 
  else 
  {
    harry(Viewport.Actor).bMSword = False;
    harry(Viewport.Actor).SpellCursor.bSpellCursorAlwaysOn = False;
    harry(Viewport.Actor).SpellCursor.EnableEmission(False);
    harry(Viewport.Actor).TurnOffSpellCursor();
  }
}

exec function DuelingMode ()
{
  if ( harry(Viewport.Actor).bInDuelingMode )
  {
    harry(Viewport.Actor).TurnOnDuelingMode(None);
  } 
  else 
  {
    harry(Viewport.Actor).TurnOffDuelingMode();
  }
}

//KW implemented this in baseConsole -AdamJD
/*
function ScaleAndDraw (Canvas C, float X, float Y, Texture Tex)
{
	local float FX;
	local float fy;
	local float Ratio;
	local float CRTScale;
	local float XOffset;
	local float YOffset;
	local float ResX;
	local float ResY;

	if ( Tex == None )
	{
		return;
	}

  //FX = C.SizeX / 640.0;
  //fy = C.SizeY / 480.0;
  //FX = C.SizeX / 640.0;
  //fy = C.SizeY / 480.0;
  //FX = 1.0;
  //fy = 1.0;
	
	FX = 1.0;
 	FY = 1.0;
	
	// Metallicafan212:	Scale it to 4/3
	//Ratio 	= C.SizeX / C.SizeY;
	
	//FX 		= Ratio; /// 1.3333;
	
	// Metallicafan212:	Center the loading screen and draw black behind it
	//					TODO!
	
	// Metallicafan212:	Rewrite this whole fucking system
	//					We want a perfect middle square
	Ratio 		= (1.3333333) / (C.Size.X / C.SizeY);
	//					Figure out a resolution in the middle of the screen
	//if(C.SizeX > C.SizeY)
	//{
	//	Ratio 		= (1.3333333) / (C.Size.X / C.SizeY);
		// Metallicafan212:	Use the height as the basis of the square
	//	ResY = C.SizeY;
	//	ResX = C.SizeX * Ratio;
	//}
	//else
	//{
	//	Ratio 		= (C.Size.X / C.SizeY) / 1.3333333;
	//	ResX = C.SizeX;
	//	ResY = C.SizeY * Ratio;
	//}
	
	// Metallicafan212:	Now draw it in the correct place
	//					We're considering the canvas a perfect 512x512 grid
	//X = 
	
	
	//FX 		= (C.SizeX / C.SizeY) / 1.33333;
	
	//log("X " $ C.SizeX $ " Y " $ C.SizeY);
	
	// Metallicafan212:	Check for thinner resolutions
	//					On these we need to stretch outwards
	
	//if(FX < 1.0)
	//{
	//	FX = 1.0;
	//	FY = (C.SizeX / C.SizeY);
	//	log("FY is " $ FY);
	//}
	//else
	//{
	//	FY = 1.0;
	//	log("FX is " $ FX);
	//}
			
	//FY		= FX;
	
	//C.DrawTileClipped(Tex, 
  
	Root.DrawStretchedTexture(C, (X * FX), (Y * FY), Tex.USize * FX, Tex.VSize * FY, Tex);
}
*/

function ToggleDebugMode ()
{
  if (  !Class'Version'.Default.bDebugEnabled )
  {
    return;
  }
  bDebugMode =  !bDebugMode;
}

function SaveSelectedSlot ()
{
  harry(Viewport.Actor).SloMo(1.0);
  menuBook.SaveSelectedSlot();
}

function LoadSelectedSlot ()
{
  menuBook.LoadSelectedSlot();
  harry(Viewport.Actor).SloMo(1.0);
}

function ShowConsole ()
{
  if (  !bDebugMode )
  {
    return;
  }
  bShowConsole = True;
  if ( bCreatedRoot )
  {
    ConsoleWindow.ShowWindow();
  }
}

function HideConsole ()
{
  bShowConsole = False;
  if ( bCreatedRoot )
  {
    ConsoleWindow.HideWindow();
  }
}

//KW implemented this in baseConsole -AdamJD
/*
function DrawLevelAction (Canvas C)
{
	local string BigMessage;
	local float fTextWidth;
	local float fTextHeight;

	if ( (Viewport.Actor.Level.Pauser != "") && Viewport.Actor.Level.LevelAction == LEVACT_None)
	{
		C.Font = C.MedFont;
		BigMessage = PausedMessage;
		PrintActionMessage(C,BigMessage);
		return;
	}
	if ( Viewport.Actor.Level.LevelAction == LEVACT_None )
	{
		BigMessage = "";
		return;
	} 
	else if ( Viewport.Actor.Level.LevelAction == LEVACT_Loading || Viewport.Actor.bShowLoadingScreen )
	{
		BigMessage = Localize("all","Options_0058","HPMenu");
		Viewport.Actor.bShowLoadingScreen = True;
		C.Style = 1;
		C.TextSize(BigMessage,fTextWidth,fTextHeight);
		if ( fTextWidth > C.SizeX - 32 )
		{
			C.Font = LocalMedFont;
		} 
		else 
		{
			C.Font = LocalBigFont;
		}
		
		ScaleAndDraw(C,0.0,0.0,LoadingBackground.p1);
		ScaleAndDraw(C,256.0,0.0,LoadingBackground.p2);
		ScaleAndDraw(C,512.0,0.0,LoadingBackground.p3);
		ScaleAndDraw(C,0.0,256.0,LoadingBackground.p4);
		ScaleAndDraw(C,256.0,256.0,LoadingBackground.p5);
		ScaleAndDraw(C,512.0,256.0,LoadingBackground.p6);
		PrintActionMessageInUpperLeft(C,BigMessage);
		return;
	} 
	else 
	{
		if ( Viewport.Actor.Level.LevelAction == LEVACT_Saving )
		{
			BigMessage = Localize("all","Options_0057","HPMenu");
		} 
		else if ( Viewport.Actor.Level.LevelAction == LEVACT_Connecting )
		{
			BigMessage = ConnectingMessage;
		} 
		else if ( Viewport.Actor.Level.LevelAction == LEVACT_Precaching )
		{
			BigMessage = PrecachingMessage;
		}
	}
	if ( BigMessage != "" )
	{
		C.Style = 1;
		C.TextSize(BigMessage,fTextWidth,fTextHeight);
		if ( fTextWidth > C.SizeX - 32 )
		{
			C.Font = LocalMedFont;
		} 
		else 
		{
			C.Font = LocalBigFont;
		}
		PrintActionMessage(C,BigMessage);
	}
}
*/

function ChangeLevel (string lev, bool flag)
{
	Log("Changing level to:" $ lev $ "," $ string(flag));
	Viewport.Actor.Level.ServerTravel(lev,flag);
	bLoadNewLevel = True;
  
	// Metallicafan212:	Fix the loading screen not showing up
	//Harry(Viewport.Actor).bShowLoadingScreen = true;
	//Viewport.Actor.bShowLoadingScreen = true;
	//Viewport.Actor.Level.LevelAction = LEVACT_Loading;
}

function LaunchUWindow (optional bool bPause)
{
  Super.LaunchUWindow(bPause);
}

function CloseUWindow ()
{
  Super.CloseUWindow();
}

event Tick (float Delta)
{
  if ( firstRun == False )
  {
    LaunchUWindow();
    firstRun = True;
  }
  HandleFastForward();
  if ( Root != None )
  {
    Root.DoTick(Delta);
  }
}

function StartFastForward ()
{
	local CutScene cut;

	if ( bFastForwarding )
	{
		return;
	}
	harry(Viewport.Actor).ClientMessage("*****STARING FASTFORWARD****************************");
	Log("*****STARING FASTFORWARD****************************");
	foreach Viewport.Actor.AllActors(Class'CutScene',cut)
	{
		if ( cut.bPlaying && cut.bSkipAllowed)
		{
			cut.FastForward();
			bFastForwarding = True;
		}
	}
}

function HandleFastForward ()
{
  local CutScene cut;
  local bool bStillFastForwarding;
  local int Count;

  if (  !bFastForwarding )
  {
    return;
  }
  bStillFastForwarding = False;
  Count = 0;
  foreach Viewport.Actor.AllActors(Class'CutScene',cut)
  {
    if ( cut.bFastForwarding )
    {
      bStillFastForwarding = True;
      Count++;
    }
  }
  if (  !bStillFastForwarding )
  {
    bFastForwarding = False;
    harry(Viewport.Actor).SloMo(1.0);
    Log("*****FINISHED FASTFORWARD****************************");
    harry(Viewport.Actor).ClientMessage("*****FINISHED FASTFORWARD****************************");
    HPHud(harry(Viewport.Actor).myHUD).managerCutScene.SetCutCommentText("");
    HPHud(harry(Viewport.Actor).myHUD).managerCutScene.bShowFF = False;
    HPHud(harry(Viewport.Actor).myHUD).managerCutScene.SetText("",0.01);
    harry(Viewport.Actor).bForceBlackScreen = False;
    harry(Viewport.Actor).ViewFlash(0.1);
    ConsoleCommand("UNMUTESOUNDS");
  } 
  else 
  {
    if ( CutSkippingString == "" )
    {
      CutSkippingString = Localize("all","SkipCS_0001","HPMenu");
    }
    HPHud(harry(Viewport.Actor).myHUD).managerCutScene.SetCutCommentText(CutSkippingString);
    HPHud(harry(Viewport.Actor).myHUD).managerCutScene.bShowFF = True;
    HPHud(harry(Viewport.Actor).myHUD).managerCutScene.SetText("",2.0);
    harry(Viewport.Actor).bForceBlackScreen = True;
    harry(Viewport.Actor).ViewFlash(0.1);
    ConsoleCommand("MUTESOUNDS");
  }
}

function doLevelSave (int I)
{
  local string savePauser;
  local PlayerPawn PlayerPawn;
  local GameSaveInfo GameSaveInfo;
  local int N;
  local int savePointID;

  harry(Viewport.Actor).SloMo(1.0);
  PlayerPawn = Viewport.Actor;
  savePauser = PlayerPawn.Level.Pauser;
  PlayerPawn.Level.Pauser = "";
  PlayerPawn.SaveGame();
  PlayerPawn.Level.Pauser = savePauser;
  GameSaveInfo = new class'GameSaveInfo';
  N = InStr(PlayerPawn.Level.LevelEnterText,".");
  if ( N == -1 )
  {
    GameSaveInfo.currentLevelString = PlayerPawn.Level.LevelEnterText;
  } 
  else 
  {
    GameSaveInfo.currentLevelString = Left(PlayerPawn.Level.LevelEnterText,N);
  }
  Log("LevelSave: Level Name is" $ GameSaveInfo.currentLevelString);
  savePointID = -1;
  savePointID = harry(Viewport.Actor).FindNearestSavePointID();
  Log("Found Savepoint ID = " $ string(savePointID));
  GameSaveInfo.savePointID = savePointID;
  PlayerPawn.SaveGameSaveInfo("GameSaveInfo" $ string(I),GameSaveInfo);
}

exec function LangBrowser ()
{
  menuBook.OpenBook("Lang");
}

function DrawE3DemoLockout (Canvas Canvas)
{
  local float W;
  local float H;
  local Font saveFont;

  saveFont = Canvas.Font;
  Canvas.Font = Root.Fonts[0];
  Canvas.SetPos(10.0,460.0);
  Canvas.DrawText("Locked");
  Canvas.Font = saveFont;
}

state UWindow
{
	event bool KeyType (EInputKey Key)
	{
		if ( Root != None )
		{
			Root.WindowEvent(WM_KeyType,None,MouseX,MouseY,Key);
		}
		return True;
	}
  
	event bool KeyEvent (EInputKey Key, EInputAction Action, float Delta)
	{
		local byte k;
  
		if ( ResTimeOutSettings != "" )
		{
			Log("HPConsole : setRes");
			Viewport.Actor.ConsoleCommand("SetRes " $ ResTimeOutSettings);
			ResTimeOutSettings = "";
			if ( FESoundVideoPage(menuBook.curPage) != None )
			{
				FESoundVideoPage(menuBook.curPage).LoadAvailableSettings();
			}	
		}
		k = Key;
		if ( menuBook.KeyEvent(Key,Action,Delta) )
		{
			return True;
		} 
		else 
		{
			switch (Action)
			{
				case IST_Release:
					switch (k)
					{
						case 1:
							if ( Root != None )
							{
								Root.WindowEvent(WM_LMouseUp,None,MouseX,MouseY,k);
							}
							break;
					}
					break;
				case IST_Press:
					switch (k)
					{
						case 115:
							SCWindow.Close();
							CloseUWindow();
							break;
						case 118:
							ToggleDebugMode();
							break;
					}
					break;
			}
			return Super.KeyEvent(Key,Action,Delta);
		}
	} 
}

exec function ShowPos ()
{
  bShowPos =  !bShowPos;
}

exec function giveAllCards ()
{
  GiveAllCardsToHarry();
}

function ExitFromGame ()
{
  menuBook.ExitFromGame();
}

function WarpHarryToCameraLocation ()
{
  local Rotator Rot;

  harry(Viewport.Actor).GotoLocation(harry(Viewport.Actor).Cam.Location);
  Rot.Yaw = harry(Viewport.Actor).Cam.Rotation.Yaw;
  harry(Viewport.Actor).SetRotation(Rot);
}

event bool KeyEvent (EInputKey Key, EInputAction Action, float Delta)
{
	local EInputKey k;
	//local EInputKey LocalConsoleKey;
	
	// Metallicafan212:	Force it to be typed
	//LocalConsoleKey = enum(ConsoleKey);
	
	//log("Key event! " $ Key $ " " $ Action);
	
	//if(Key == IK_Numpad4)
	//{
	//	log(bLeftKeyDown);
	//}
	

	if(Action == IST_Press && int(key) == ConsoleKey)
	{
		if ( bLocked )
		{
			return True;
		}
		Root.bAllowConsole = Class'Version'.Default.bDebugEnabled;
		if (  !bDebugMode )
		{
			return True;
		}
		if ( bShiftDown )
		{
			ShowCutConsole( !bShowCutConsole);
			return True;
		}
		bQuickKeyEnable = True;
		LaunchUWindow();
		if (  !bShowConsole )
		{
			ShowConsole();
		}
		return True;
	}

	k = Key;
	switch (Action)
	{
		case IST_Release:
			switch (k)
			{
				case IK_Delete:
					if ( bDebugMode )
					{
						if ( harry(Viewport.Actor).Cam.CameraMode != harry(Viewport.Actor).Cam.ECamMode.CM_Free )
						{
							harry(Viewport.Actor).Cam.SetCameraMode(harry(Viewport.Actor).Cam.ECamMode.CM_Free);
						} 
						else 
						{
							WarpHarryToCameraLocation();
							harry(Viewport.Actor).Cam.SetCameraMode(harry(Viewport.Actor).Cam.LastCamMode);
						}
					}
					break;
				case IK_LeftMouse:
					bSpaceReleased = True;
					break;
				case IK_Space:
					bSpacePressed = False;
					bBoostKeyPressed = False;
					break;
				case IK_Pause:
				case IK_Cancel:
					if ( bDebugMode )
					{
						harry(Viewport.Actor).ConsoleCommand("pause");
					}
					break;
				case IK_PageUp:
					if ( bDebugMode )
					{
						if ( fSlomoSpeed >= 1.0 )
						{
							if ( fSlomoSpeed < 20 )
							{
								fSlomoSpeed += 0.5;
							}
						}	 
						else 
						{
							fSlomoSpeed = 1.0;
						}
						harry(Viewport.Actor).SloMo(fSlomoSpeed);
						harry(Viewport.Actor).ClientMessage(" ^^^ Setting GameSpeed to: X" $ string(fSlomoSpeed));
					}
					break;
				case IK_PageDown:
					if ( bDebugMode )
					{
						if ( fSlomoSpeed <= 1.0 )
						{
							fSlomoSpeed *= 0.5;
						} 
						else 
						{
							fSlomoSpeed = 1.0;
						}
						harry(Viewport.Actor).SloMo(fSlomoSpeed);
						harry(Viewport.Actor).ClientMessage(" ^^^ Setting GameSpeed to: X" $ string(fSlomoSpeed));
					}
					break;
				case IK_Left:
					//stop free cam zooming off when using arrow keys -AdamJD
					bLeftKeyDown = False;
					break;
				case IK_Numpad4:
					bLeftKeyDown = False;
					break;
				case IK_Down:
					//stop free cam zooming off when using arrow keys -AdamJD
					bBackKeyDown = False;
					break;
				case IK_Numpad6:
					bRightKeyDown = False;
					break;
				case IK_Up:
					//stop free cam zooming off when using arrow keys -AdamJD
					bForwardKeyDown = False;
					break;
				case IK_NumPad8:
					bForwardKeyDown = False;
					break;
				case IK_Right:
					//stop free cam zooming off when using arrow keys -AdamJD
					bRightKeyDown = False;
					break;
				case IK_Numpad2:
					bBackKeyDown = False;
					break;
				case IK_Numpad1:
					bRotateLeftKeyDown = False;
					break;
				case IK_Numpad3:
					bRotateRightKeyDown = False;
					break;
				case IK_Numpad0:
					bRotateUpKeyDown = False;
					break;
				case IK_NumPadPeriod:
					bRotateDownKeyDown = False;
					break;
				case IK_Numpad7:
					bUpKeyDown = False;
					break;
				case IK_Numpad9:
					bDownKeyDown = False;
					break;
				case IK_Shift:
					bShiftDown = False;
					break;
			}
			break;
		case IST_Axis:
			if ( bVendorBar )
			{
				switch (Key)
				{
					case IK_MouseX:
						MouseX = MouseX + MouseScale * Delta;
						break;
					case IK_MouseY:
						MouseY = MouseY - MouseScale * Delta;
						break;
				}
			}
			break;
		case IST_Press:
			if ( harry(Viewport.Actor) != None )
			{
				harry(Viewport.Actor).KeyDownEvent(int(Key));
			}
			switch (k)
			{
				case IK_Shift:
					bShiftDown = True;
					break;
				case IK_Backspace:
					if ( bDebugMode )
					{
						LangBrowser();
						return True;
					}
					break;
				case IK_Tab:
					break;
				case IK_Left:
					//stop free cam zooming off when using arrow keys -AdamJD
					bLeftKeyDown = True;
					break;
				case IK_Numpad4:
					bLeftKeyDown = True;
					break;
				case IK_Right:
					//stop free cam zooming off when using arrow keys -AdamJD
					bRightKeyDown = True;
					break;
				case IK_Numpad6:
					bRightKeyDown = True;
					break;
				case IK_Up:
					//stop free cam zooming off when using arrow keys -AdamJD
					bForwardKeyDown = True;
					break;
				case IK_Numpad8:
					bForwardKeyDown = True;
					break;
				case IK_Down:
					//stop free cam zooming off when using arrow keys -AdamJD
					bBackKeyDown = True;
					break;
				case IK_Numpad2:
					bBackKeyDown = True;
					break;
				case IK_Numpad1:
					bRotateLeftKeyDown = True;
					break;
				case IK_Numpad3:
					bRotateRightKeyDown = True;
					break;
				case IK_Numpad0:
					bRotateUpKeyDown = True;
					break;
				case IK_NumPadPeriod:
					bRotateDownKeyDown = True;
					break;
				case IK_NumPad7:
					bUpKeyDown = True;
					break;
				case IK_Numpad9:
					bDownKeyDown = True;
					break;
				case IK_Insert:
					if ( bDebugMode )
					{
						Viewport.Actor.SShot();
					}
					break;
				case IK_RightMouse:
					break;
				case IK_Escape:
					menuBook.EscFromConsole();
					return True;
				/*
				case LocalConsoleKey:
					if ( bLocked )
					{
						return True;
					}
					Root.bAllowConsole = Class'Version'.Default.bDebugEnabled;
					if (  !bDebugMode )
					{
						return True;
					}
					if ( bShiftDown )
					{
						ShowCutConsole( !bShowCutConsole);
						return True;
					}
					bQuickKeyEnable = True;
					LaunchUWindow();
					if (  !bShowConsole )
					{
						ShowConsole();
					}
					return True;
				*/
				case IK_LeftMouse:
					bSpaceReleased = False;
					break;
				case IK_Space:
					bSpacePressed = True;
					bBoostKeyPressed = True;
					break;
				case IK_F4:
					if ( bDebugMode )
					{
						LaunchUWindow();
						ShortCut();
					}
					break;
				case IK_F6:
					if ( bDebugMode )
					{
						harry(Viewport.Actor).GetHealthStatusItem().SetCountToMaxPotential();
					}
					break;
				case IK_F7:
					ToggleDebugMode();
					break;
				case IK_F8:
					break;
				case IK_F9:
					if ( bDebugMode )
					{
						harry(Viewport.Actor).AddAllSpellsToSpellBook();
					}
					break;
				case IK_F10:
					break;
				case IK_F12:
					break;
			}
			break;
	}
	return False;
}

function handleMenuEvent ()
{
}

function drawLegal (Canvas Canvas)
{
}

function newDrawBack (Canvas Canvas)
{
}

function drawBack (Canvas Canvas)
{
}

function SetupLanguage ()
{
  local string f1;
  local string f2;
  local string f3;
  local string f4;
  local int f1s;
  local int f2s;
  local int f3s;
  local int f4s;

  LanguageCode = GetLanguage();
  Log("LanguageCode=" $ LanguageCode);
  switch (Caps(LanguageCode))
  {
    case "SIM":
    case "CHI":
    case "TRA":
    case "KOR":
    case "THA":
    case "JAP":
    case "GRE":
    case "RUS":
    case "CHE":
    case "CZE":
    case "POL":
    bUseAsianFont = True;
    f1 = Localize("all","Font1Name","SAPFont");
    f1s = int(Localize("all","Font1Size","SAPFont"));
    f2 = Localize("all","Font2Name","SAPFont");
    f2s = int(Localize("all","Font2Size","SAPFont"));
    f3 = Localize("all","Font3Name","SAPFont");
    f3s = int(Localize("all","Font3Size","SAPFont"));
    f4 = Localize("all","Font4Name","SAPFont");
    f4s = int(Localize("all","Font4Size","SAPFont"));
    Log("Font1:" $ f1 $ ":" $ string(f1s));
    Log("Font2:" $ f2 $ ":" $ string(f2s));
    Log("Font3:" $ f3 $ ":" $ string(f3s));
    Log("Font4:" $ f4 $ ":" $ string(f4s));
    LocalBigFont = CreateNativeFont(f1,f1s);
    LocalMedFont = CreateNativeFont(f2,f2s);
    LocalSmallFont = CreateNativeFont(f3,f3s);
    LocalTinyFont = CreateNativeFont(f4,f4s);
    LocalIconMessageFont = LocalBigFont;
    Root.Fonts[0] = LocalSmallFont;
    Root.Fonts[1] = LocalSmallFont;
    Root.Fonts[2] = LocalMedFont;
    Root.Fonts[3] = LocalMedFont;
    Root.Fonts[4] = LocalMedFont;
    break;
    case "ENG":
    case "INT":
    LocalBigFont = Font'HugeInkFont';
    LocalMedFont = Font'BigInkFont';
    LocalSmallFont = Font'MedInkFont';
    LocalTinyFont = Font'SmallInkFont';
    LocalIconMessageFont = LocalSmallFont;
    break;
    case "GER":
    default:
    LocalBigFont = Font'BigInkFont';
    LocalMedFont = Font'MedInkFont';
    LocalSmallFont = Font'SmallInkFont';
    LocalTinyFont = Font'TinyInkFont';
    LocalIconMessageFont = Font'SmallInkFont';
    break;
  }
  IntMedFont = Font'BigInkFont';
  SaveConfig();
}

function PostRender (Canvas Canvas)
{
  local LevelInfo lev;

  Super.PostRender(Canvas);
  if ( Root != None )
  {
    if ( menuBook.bIsOpen || bShowCutConsole || bVendorBar )
    {
      RenderUWindow(Canvas);
    }
  }
  if ( bShowPos )
  {
    Canvas.DrawColor.R = 255;
    Canvas.DrawColor.G = 255;
    Canvas.DrawColor.B = 255;
    Canvas.SetPos(Canvas.SizeX - 200,Canvas.SizeY - 40);
  }
}

function RenderUWindow (Canvas Canvas)
{
	local LevelInfo lev;
	local UWindowWindow NewFocusWindow;
	local Texture curTexture;

	Canvas.bNoSmooth = false;//True;
	Canvas.Z = 1.0;
	Canvas.Style = 1;
	Canvas.DrawColor.R = 255;
	Canvas.DrawColor.G = 255;
	Canvas.DrawColor.B = 255;
  
	if ( Viewport.bWindowsMouseAvailable && (Root != None) )
	{
		MouseX = Viewport.WindowsMouseX / Root.GUIScale;
		MouseY = Viewport.WindowsMouseY / Root.HGUIScale;//Root.GUIScale;
	}
  
	if (  !bCreatedRoot )
	{
		CreateRootWindow(Canvas);
		Root.SetScale(Root.RealWidth / 640);
		Root.NormalCursor.tex2 = Texture(DynamicLoadObject("HP2_Menu.Icons.WandSpark",Class'FireTexture'));
		Root.NormalCursor.Tex2XOffset = -32;
		Root.NormalCursor.Tex2YOffset = -32;
		Root.Cursor = Root.NormalCursor;
		SetupLanguage();
		menuBook = FEBook(Root.CreateWindow(Class'FEBook', 0.0, 0.0 ,640.0, 480.0, Root));
		menuBook.bGamePlaying = True;
		menuBook.CloseBook();
		HideConsole();
	}
	
	Root.bWindowVisible = True;
	Root.bUWindowActive = bUWindowActive;
	Root.bQuickKeyEnable = bQuickKeyEnable;
	if ( (Canvas.ClipX != OldClipX) || (Canvas.ClipY != OldClipY) )
	{
		OldClipX = Canvas.ClipX;
		OldClipY = Canvas.ClipY;
		Root.WinTop = 0.0;
		Root.WinLeft = 0.0;
		Root.WinWidth = Canvas.ClipX / Root.GUIScale;
		Root.WinHeight = Canvas.ClipY / Root.HGUIScale;//Root.GUIScale;
		Root.RealWidth = Canvas.ClipX;
		Root.RealHeight = Canvas.ClipY;
		Root.ClippingRegion.X = 0;
		Root.ClippingRegion.Y = 0;
		Root.ClippingRegion.W = Root.WinWidth;
		Root.ClippingRegion.H = Root.WinHeight;
		Root.Resized();
	}
  
	if ( MouseX > Root.WinWidth )
	{
		MouseX = Root.WinWidth;
	}
	
	if ( MouseY > Root.WinHeight )
	{
		MouseY = Root.WinHeight;
	}
	
	if ( MouseX < 0 )
	{
		MouseX = 0.0;
	}
 
	if ( MouseY < 0 )
	{
		MouseY = 0.0;
	}
  
	NewFocusWindow = Root.CheckKeyFocusWindow();
	if ( NewFocusWindow != Root.KeyFocusWindow )
	{
		Root.KeyFocusWindow.KeyFocusExit();
		Root.KeyFocusWindow = NewFocusWindow;
		Root.KeyFocusWindow.KeyFocusEnter();
	}
	
	Root.MoveMouse(MouseX,MouseY);
	Root.WindowEvent(WM_Paint,Canvas,MouseX,MouseY,0);
	
	if ( bUWindowActive || bQuickKeyEnable )
	{
		Root.DrawMouse(Canvas);
	}
}

event DrawLevelInfo (Canvas C, string URL)
{
  local float SizeX;
  local float SizeY;
  //local string Index;
  local string sIndex;
  local string Text;
  local int Dot;
  local int cards;
  local int secrets;

  SizeX = 256.0 * FrameX / 640.0;
  SizeY = 256.0 * FrameY / 480.0;
  Dot = InStr(URL,".");
  if ( Dot >= 0 )
  {
    URL = Left(URL,Dot);
  }
  Log("NextURL = " $ URL);
  C.bCenter = True;
  C.OrgX = FrameX * 0.151;
  C.ClipX = FrameX * 0.69999999;
  C.DrawColor.R = 0;
  C.DrawColor.G = 0;
  C.DrawColor.B = 0;
  sIndex = Localize("text","n_" $ URL,"Dobby");
  Text = Localize("text","level_name_" $ sIndex,"HGame");
  if ( Left(Text,1) != "<" )
  {
    C.CurX = FrameX * 0.34999999;
    C.CurY = FrameY * 0.25;
    C.Font = LocalBigFont;
    C.DrawText(Text);
  }
  Text = Localize("text","objective_" $ sIndex,"HGame");
  if ( Left(Text,1) != "<" )
  {
    C.CurX = FrameX * 0.34999999;
    C.CurY = FrameY * 0.5;
    C.Font = LocalMedFont;
    C.DrawText(Text);
  }
  if ( bInHubFlow )
  {
    Text = Localize("text","secret_" $ URL,"Dobby");
    cards = int(Left(Text,1));
    secrets = int(Mid(Text,2,1));
    C.Font = LocalSmallFont;
    C.CurY = FrameY * 0.69999999;
    if ( cards > 0 )
    {
      C.CurX = FrameX * 0.34999999;
      Text = Localize("all","find_wizard_text_0" $ cards,"Pickup");
      if ( Left(Text,1) != "<" )
      {
        C.DrawText(Text);
      }
      C.CurY = FrameY * 0.75;
    }
    if ( secrets > 0 )
    {
      C.CurX = FrameX * 0.34999999;
      Text = Localize("all","find_secret_text_0" $ secrets,"Pickup");
      if ( Left(Text,1) != "<" )
      {
        C.DrawText(Text);
      }
    }
  }
}

defaultproperties
{
    bShootingRange=True

    fSlomoSpeed=1.00

    FadeOutTime=0.50

    FadeInTime=1.00

    PausedMessage="PRESS ESC TO EXIT"

    PrecachingMessage="ENTERING"
	
	//is in baseConsole -AdamJD
	//bUseSystemFonts=True
	
	// Metallicafan212:	Fix this, as baseconsole just doesn't want to be compiled for some strange reason
	//
	//fixed the one in baseConsole -AdamJD
	//LoadingBackground=(p1=Texture'HGame.Icons.FELoadingBackground1',p2=Texture'HGame.Icons.FELoadingBackground2',p3=Texture'HGame.Icons.FELoadingBackground3',p4=Texture'HGame.Icons.FELoadingBackground4',p5=Texture'HGame.Icons.FELoadingBackground5',p6=Texture'HGame.Icons.FELoadingBackground6',durration=999999.00)
}