//================================================================================
// HPHud.
//================================================================================

class HPHud extends baseHUD
  Config(User);

var CutSceneManager managerCutScene;
var ChallengeScoreManager managerChallenge;
var QuidScoreManager managerQuidScore;
var MuggleMeterManager managerMuggleMeter;
var SpellLessonTrigger managerSpellLesson;
var MagicStrengthManager managerMagicStrength;
var EnemyHealthManager managerEnemyHealth;
var CountdownTimerManager managerCountdownTimer;
var SpellSelector managerSpellSelector;
var QuidditchBar managerQuidditchBar;
var VendorManager CurrVendorManager;
//var HProp propArray[20];
var Array<HProp> propArray;
var bool bHideStatus;
var bool bHideHud;

// Metallicafan212:	Hide the hud items in game, better than using the glitch all the time
exec function HideHud()
{
	//bHideStatus = !bHideStatus;
	
	bHideHud = !bHideHud;
	
	HPConsole(PlayerPawn(Owner).Player.Console).ShowCutConsole(bHideHud);
}

function StartCutScene()
{
	// Metallicafan212:	Don't allow this to show
	if(bHideHud)
		return;
		
	if ( harry(Owner).bIsCaptured)
	{
		bCutSceneMode = True;
	} 
	else 
	{
		bCutPopupMode = True;
	}
	managerCutScene.StartCutScene();
}

function EndCutScene()
{
  managerCutScene.EndCutScene();
  bCutSceneMode = False;
  bCutPopupMode = False;
}

function SetSubtitleText (string Text, float duration)
{
  managerCutScene.SetText(Text,duration);
}

function ClearSubtitleText()
{
  managerCutScene.ClearText();
}

function RegisterChallengeManager (ChallengeScoreManager Challenge)
{
  managerChallenge = Challenge;
}

function RegisterQuidScoreManager (QuidScoreManager QuidScore)
{
  managerQuidScore = QuidScore;
}

function RegisterMuggleMeter (MuggleMeterManager MuggleMeter)
{
  managerMuggleMeter = MuggleMeter;
}

function RegisterSpellLesson (SpellLessonTrigger SpellLesson)
{
  managerSpellLesson = SpellLesson;
}

function RegisterMagicStrength (MagicStrengthManager MagicStrength)
{
  managerMagicStrength = MagicStrength;
}

function RegisterEnemyHealth (EnemyHealthManager EnemyHealth)
{
  managerEnemyHealth = EnemyHealth;
}

function RegisterQuidditchBar (QuidditchBar QBar)
{
  managerQuidditchBar = QBar;
}

function RegisterCountdownTimerManager (CountdownTimerManager CountdownTimer)
{
  managerCountdownTimer = CountdownTimer;
}

function RegisterSpellSelector (SpellSelector RegSpellSelector)
{
  managerSpellSelector = RegSpellSelector;
}

function RegisterVendorManager (VendorManager VManager)
{
  CurrVendorManager = VManager;
}

function RegisterPickupProp (HProp Prop)
{
	/*
	local int I;
	local bool bFoundSlot;

	bFoundSlot = False;

	for(I = 0; I < 20; I++)
	{
		if ( propArray[I] == None )
		{
			bFoundSlot = True;
			propArray[I] = Prop;
			break;
		}
	}
	if ( bFoundSlot == False )
	{
		harry(Owner).ClientMessage("WARNING: Not enough prop slots in HPHud");
		Log("WARNING: Not enough prop slots in HPHud");
	}
	*/
	
	// Metallicafan212:	Add on the end
	propArray[propArray.length] = Prop;
}

function UnregisterPickupProp (HProp Prop)
{
	/*
  local int I;
  local int J;

  for(I = 0; I < 20; I++)
  {
    if ( propArray[I] == Prop )
    {
      propArray[I] = None;
	  for(J = I + 1; J < 20; J++)
      {
        propArray[J - 1] = propArray[J];
        propArray[J] = None;
      }
	  break;
    }
  }
  */
  
	local int i;
	
	for(i = 0; i < propArray.Length; i++)
	{
		if(PropArray[i] == Prop)
		{
			// Metallicafan212:	Remove it
			PropArray.Remove(i);
			
			break;
		}
	}
  
}

function bool IsCutSceneOrPopupInProgress()
{
  return bCutSceneMode || bCutPopupMode || managerCutScene.bPopupBorderActive || managerCutScene.bBothBordersActive;
}

event Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( bScoreCountup )
  {
    fScoreCountTime -= DeltaTime;
    if ( fScoreCountTime <= 0 )
    {
      fScoreCountTime = 0.0;
      bScoreCountup = False;
    }
  }
}

function DrawSpellIcon (Canvas Canvas)
{
  local Texture Icon;

  Icon = baseWand(PlayerPawn(Owner).Weapon).GetSpellIcon();
  if ( Icon != None )
  {
    Canvas.SetPos(5.0,(Canvas.SizeY - 64) - 5);
    Canvas.DrawIcon(Icon,1.0);
  }
}

function DrawHoops (Canvas Canvas, int iNumber, int iMaxNumber)
{
  local int Ox;
  local int Oy;

  Ox = 8;
  Oy = Canvas.SizeY - 156;
  if ( iNumber < 10 )
  {
    Canvas.SetPos(Ox + 94,Oy + 100);
  } else {
    Canvas.SetPos(Ox + 85,Oy + 100);
  }
  Canvas.DrawText(string(iNumber) $ "/" $ string(iMaxNumber),False);
}

simulated function PreBeginPlay()
{
	local int I;

	Super.PreBeginPlay();
	if ( managerCutScene == None )
	{
		managerCutScene = Spawn(Class'CutSceneManager');
	}
}

simulated function PostBeginPlay()
{
  Super.PostBeginPlay();
}

simulated function bool DisplayMessages (Canvas Canvas)
{
	if ( HPConsole(PlayerPawn(Owner).Player.Console).bDebugMode && !bHideHud )
	{
		return False;
	}
	
	return True;
}

simulated function PostRender (Canvas Canvas)
{
	local FEBook menuBook;
	local int I;
	local bool bInGameMenuUp;
	local bool bFullCutMode;
	local bool bHalfCutMode;

	HUDSetup(Canvas);
	bFullCutMode = !bHideHud && ((bCutSceneMode) || managerCutScene.bBothBordersActive);
	bHalfCutMode = !bHideHud && ((bCutPopupMode) || managerCutScene.bPopupBorderActive);
	
	if ( PlayerPawn(Owner) != None )
	{
		if ( PlayerPawn(Owner).PlayerReplicationInfo == None )
		{
			return;
		}
	}
	
	menuBook = HPConsole(PlayerPawn(Owner).Player.Console).menuBook;
	
	if ( menuBook != None )
	{
		if ( menuBook.bIsOpen )
		{
			bInGameMenuUp = menuBook.IsInGameMenuShowing();
			if (  !bInGameMenuUp )
			{
				return;
			}
		}
	}
	
	if (  !bInGameMenuUp )
	{
		if ( bHalfCutMode )
		{
			managerCutScene.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		}
		
		if ( bFullCutMode )
		{
			managerCutScene.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		} 
		else 
		{
			if ( managerEnemyHealth != None )
			{
				managerEnemyHealth.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
			}
			if ( managerQuidditchBar != None )
			{
				managerQuidditchBar.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
			}
			if ( managerMagicStrength != None )
			{
				managerMagicStrength.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
			}
			if ( managerCountdownTimer != None )
			{
				managerCountdownTimer.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
			}
			if ( managerSpellSelector != None )
			{
				managerSpellSelector.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
			}
		}
    
		if ( (managerSpellLesson == None) && (managerMagicStrength == None) &&  !bHideStatus && !bHideHud )
		{
			harry(Owner).managerStatus.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		}

		for(i = 0; i < propArray.Length; i++)
		{
			propArray[I].RenderHud(Canvas);
		}
    
		if ( CurrVendorManager != None )
		{
			CurrVendorManager.RenderHud(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		}
    
		if ( managerChallenge != None )
		{
			managerChallenge.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		}
    
		if ( managerQuidScore != None )
		{
			managerQuidScore.RenderHudItemManager(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		}
    
		if ( managerSpellLesson != None )
		{
			managerSpellLesson.RenderHudItems(Canvas,bInGameMenuUp,bFullCutMode,bHalfCutMode);
		}
		
		DrawPopup(Canvas);
	}
}

function DrawCutStyleText (Canvas Canvas, string strText, int nXPos, int nYPos, int nHeight, Color colorText, optional Font fontText, optional float fClipX)
{
  local Font fontSave;
  local Color colorSave;
  local int nStyleSave;
  local float fClipXSave;
  local float fTextW;
  local float fTextH;
  local int nLines;
  local int nAvailLines;
  local string strTextLine;
  local string strSearch;
  local int nOrgPos;
  local int nNewPos;

  if ( strText == "" )
  {
    return;
  }
  if ( fClipX != 0 )
  {
    fClipXSave = Canvas.ClipX;
    Canvas.ClipX = fClipX;
  }
  fontSave = Canvas.Font;
  colorSave = Canvas.DrawColor;
  nStyleSave = Canvas.Style;
  if ( fontText == None )
  {
    Canvas.Font = baseConsole(PlayerPawn(Owner).Player.Console).LocalMedFont;
  } else {
    Canvas.Font = fontText;
  }
  Canvas.Style = 2;
  Canvas.DrawColor = colorText;
  Canvas.TextSize(strText,fTextW,fTextH);
  nLines = ((fTextW + 90) / Canvas.SizeX) + 1;
  nAvailLines = nHeight / fTextH;
  if ( nLines > nAvailLines )
  {
    Canvas.Font = baseConsole(PlayerPawn(Owner).Player.Console).LocalMedFont;
    Canvas.TextSize(strText,fTextW,fTextH);
    nLines = ((fTextW + 90) / Canvas.SizeX) + 1;
	nAvailLines = nHeight / fTextH;
	if ( nLines > nAvailLines )
    {
      Canvas.Font = baseConsole(PlayerPawn(Owner).Player.Console).LocalSmallFont;
      Canvas.TextSize(strText,fTextW,fTextH);
      nLines = ((fTextW + 90) / Canvas.SizeX) + 1;
	  if ( nLines > nAvailLines )
      {
        Canvas.Font = baseConsole(PlayerPawn(Owner).Player.Console).LocalTinyFont;
        Canvas.TextSize(strText,fTextW,fTextH);
        nLines = ((fTextW + 90) / Canvas.SizeX) + 1;
        nAvailLines = nHeight / fTextH;
	  }
	}
  }
  if((Caps(GetLanguage()) == "THA") && InStr(strText, "_") > -1)
  {
    strTextLine = "";
    nOrgPos = 0;
    Canvas.SetPos(nXPos,nYPos);
    strSearch = strText;
    // if ( nOrgPos <= Len(strText) )
	while ( nOrgPos <= Len(strText) )
    {
       nNewPos = InStr(strSearch,"_");
       if ( nNewPos != -1 )
       {
          strTextLine = strTextLine $ Left(strSearch,nNewPos);
       } else {
          strTextLine = strTextLine $ strSearch;
       }
       Canvas.TextSize(strTextLine,fTextW,fTextH);
       if ( fTextW > Canvas.SizeX - 16 - nXPos )
       {
          strTextLine = Left(strTextLine,nOrgPos);
          Canvas.DrawText(strTextLine,False);
          nYPos += fTextH;
		  Canvas.SetPos(nXPos,nYPos);
          strTextLine = "";
       } else {
         if ( nNewPos != -1 )
         {
           nOrgPos += nNewPos;
           strSearch = Right(strSearch,Len(strSearch) - nNewPos - 1);
         } else {
// JL0380:
           // goto JL04B6;
		   break;
         }
        }
            // goto JL0380;
    } 
	Canvas.TextSize(strTextLine,fTextW,fTextH);
    if ( fTextW < Canvas.SizeX - 16 - nXPos )
    {
      nXPos = (Canvas.SizeX - fTextW - nXPos) / 2;
    }
	Canvas.SetPos(nXPos, nYPos);
    Canvas.DrawText(strTextLine,False);
  }
    else {
    if ( fTextW < Canvas.SizeX - 16 - nXPos )
    {
     nXPos = (Canvas.SizeX - fTextW - nXPos) / 2;
    }
    Canvas.SetPos(nXPos, nYPos);
    Canvas.DrawText(strText,False);
  }
  Canvas.Font = fontSave;
  Canvas.DrawColor = colorSave;
  Canvas.Style = nStyleSave;
  if ( fClipX != 0 )
  {
    Canvas.ClipX = fClipXSave;
  }
}

auto state Loading
{
  event BeginState()
  {
    local CutScene aCut;
  
    foreach AllActors(Class'CutScene',aCut)
    {
      if ( aCut.bLevelLoadStarts )
      {
        bHideStatus = True;
		break;
      } //else {
      //}
    }
  }
  
begin:
  if ( bHideStatus )
  {
    Sleep(2.0);
    bHideStatus = False;
    GotoState('Idle');
  }
}

state Idle
{
  event BeginState()
  {
    bHideStatus = False;
  }
  
}

