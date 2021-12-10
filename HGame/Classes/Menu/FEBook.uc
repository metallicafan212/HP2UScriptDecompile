//================================================================================
// FEBook.
//================================================================================

class FEBook extends baseFEBook; 

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\FEInGameBackTexture1.PNG	GROUP=Icons	Name=FEInGameBackTexture1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture2.PNG	GROUP=Icons	Name=FEInGameBackTexture2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture3.PNG	GROUP=Icons	Name=FEInGameBackTexture3 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture4.PNG	GROUP=Icons	Name=FEInGameBackTexture4 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture5.PNG	GROUP=Icons	Name=FEInGameBackTexture5 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture6.PNG	GROUP=Icons	Name=FEInGameBackTexture6 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture1.PNG	GROUP=Icons	Name=FEBack1Texture1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture2.PNG	GROUP=Icons	Name=FEBack1Texture2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture3.PNG	GROUP=Icons	Name=FEBack1Texture3 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture4.PNG	GROUP=Icons	Name=FEBack1Texture4 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture5.PNG	GROUP=Icons	Name=FEBack1Texture5 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture6.PNG	GROUP=Icons	Name=FEBack1Texture6 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0

struct Background
{
  var Texture p1;
  var Texture p2;
  var Texture p3;
  var Texture p4;
  var Texture p5;
  var Texture p6;
  var float durration;
};

var UWindowSmallButton DismissButton;
var HPMessageBox ConfirmQuitGame;
var baseFEPage MainPage;
var baseFEPage ReportPage;
var baseFEPage FolioPage;
var baseFEPage ChapterPage;
var baseFEPage SavePage;
var FEInGamePage InGamePage;
var baseFEPage SlotPage;
var baseFEPage CreditsPage;
var baseFEPage LoadPage;
var baseFEPage InputPage;
var baseFEPage SoundVideoPage;
var baseFEPage SplashPage;
var baseFEPage LangPage;
var baseFEPage MapPage;
var baseFEPage QuidPage;
var baseFEPage DuelPage;
var baseFEPage HousepointsPage;
var baseFEPage ChallengesPage;
var baseFEPage curPage;
var baseFEPage prevPage;
var string _URLToLoad;
var bool bTravelItemsOnLoad;
var Texture LogoTexture1;
var Texture LogoTexture2;
var bool bIsOpen;
var bool bShowBackground;
var bool bDrawLogo;
var bool bInEndGame;
var Background SplashScreens[5];
var int numSplashScreens;
var int curSplashScreen;
var bool bShowSplash;
var float fShowSplashTime;
var bool bNewGame;
var bool bGamePlaying;
var UWindowWrappedTextArea StatusBarTextWindow;
var bool bResolutionChanged;
var Background InGameBackground;
var Background Back1Background;
var Background curBackground;
var bool bPlayingQuidditch;
var bool bMapQuickLook;
var transient int nMusicHandle;
var transient bool bNeedToStartMusic;

function SaveSelectedSlot()
{
}

function LoadSelectedSlot()
{
}

function ToolTip (string strTip)
{
  StatusBarTextWindow.Clear();
  StatusBarTextWindow.AddText(strTip);
}

function ResolutionChanged (float W, float H)
{
  Super.ResolutionChanged(W,H);
  bResolutionChanged = True;
}

function ChangePage (baseFEPage Page)
{
  Log("ChangePage" @ string(Page));
  if ( curPage != Page )
  {
    prevPage = curPage;
    if ( curPage != None )
    {
      curPage.HideWindow();
    }
    curPage = Page;
    if ( curPage != None )
    {
      curPage.PreSwitchPage();
      if ( curPage != MainPage )
      {
        curPage.ShowWindow();
      }
    }
  }
  bShowBackground = False;
  switch (curPage)
  {
    case MainPage:
    bGamePlaying = False;
    break;
    case InputPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case SoundVideoPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case LangPage:
    break;
    case InGamePage:
    bShowBackground = True;
    curBackground = InGameBackground;
    break;
    case QuidPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case DuelPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case HousepointsPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case ChallengesPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case FolioPage:
    bShowBackground = True;
    curBackground = Back1Background;
    break;
    case CreditsPage:
    prevPage = InGamePage;
    break;
    case MapPage:
    break;
    case None:
    prevPage = None;
    break;
    default:
    Log("UnknownPage in FEBook: " $ string(Page));
    break;
  }
  if ( curPage != None )
  {
    StatusBarTextWindow.WinTop = curPage.GetStatusY();
  }
}

function ChangePagePrevious()
{
  if ( (prevPage != None) && (prevPage != curPage) )
  {
    ChangePage(prevPage);
    prevPage = None;
  }
}

function ChangePageNamed (string Name)
{
  switch (Caps(Name))
  {
    case "MAIN":
    ChangePage(MainPage);
    break;
    case "INPUT":
    Log("changepagenamed input");
    ChangePage(InputPage);
    break;
    case "SOUNDVIDEO":
    Log("changepagenamed soundvideo");
    ChangePage(SoundVideoPage);
    break;
    case "LANG":
    case "LANGUAGE":
    ChangePage(LangPage);
    break;
    case "INGAME":
    ChangePage(InGamePage);
    break;
    case "FOLIO":
    Log("changepagenamed folio");
    ChangePage(FolioPage);
    break;
    case "MAP":
    ChangePage(MapPage);
    break;
    case "QUID":
    case "QUIDDITCH":
    ChangePage(QuidPage);
    break;
    case "DUEL":
    ChangePage(DuelPage);
    break;
    case "HPOINTS":
    ChangePage(HousepointsPage);
    break;
    case "CHALLENGES":
    ChangePage(ChallengesPage);
    break;
    case "CREDITSPAGE":
    ChangePage(CreditsPage);
    break;
    default:
    Log("UnknownPage in FEBook: " $ Name);
    break;
  }
}

event Tick (float Delta)
{
  local bool bTravelItems;

  if ( _URLToLoad != "" )
  {
    HPConsole(Root.Console).bInHubFlow = bTravelItemsOnLoad;
    if ( bNewGame )
    {
      bTravelItems = False;
      bNewGame = False;
    } 
	else 
	{
      bTravelItems = bTravelItemsOnLoad;
    }
    baseConsole(Root.Console).ChangeLevel(_URLToLoad,bTravelItems);
    _URLToLoad = "";
    if ( _URLToLoad ~= "startup.unr" )
    {
      OpenBook();
      ChangePageNamed("Main");
    } 
	else 
	{
      CloseBook();
    }
  }
}

function Created()
{
  local int I;
  local Texture tempTexture;
  local LevelInfo lev;

  Super.Created();
  bNewGame = False;
  DismissButton = UWindowSmallButton(CreateControl(Class'UWindowSmallButton',WinWidth - 10,0.0,10.0,10.0));
  DismissButton.SetFont(F_HPMenuLarge);
  StatusBarTextWindow = UWindowWrappedTextArea(CreateControl(Class'UWindowWrappedTextArea',0.0,WinHeight - 26,500.0,26.0));
  StatusBarTextWindow.Clear();
  StatusBarTextWindow.AddText("");
  StatusBarTextWindow.Font = F_HPMenuLarge;
  bShowBackground = True;
  InGamePage = FEInGamePage(CreateWindow(Class'FEInGamePage',0.0,0.0,640.0,480.0));
  InGamePage.book = self;
  InGamePage.HideWindow();
  FolioPage = baseFEPage(CreateWindow(Class'FEFolioPage',0.0,0.0,640.0,480.0));
  FolioPage.book = self;
  FolioPage.HideWindow();
  InputPage = baseFEPage(CreateWindow(Class'FEInputPage',0.0,0.0,640.0,480.0));
  InputPage.book = self;
  InputPage.HideWindow();
  SoundVideoPage = baseFEPage(CreateWindow(Class'FESoundVideoPage',0.0,0.0,640.0,480.0));
  SoundVideoPage.book = self;
  SoundVideoPage.HideWindow();
  QuidPage = baseFEPage(CreateWindow(Class'FEQuidPage',0.0,0.0,640.0,480.0));
  QuidPage.book = self;
  QuidPage.HideWindow();
  DuelPage = baseFEPage(CreateWindow(Class'FEDuelPage',0.0,0.0,640.0,480.0));
  DuelPage.book = self;
  DuelPage.HideWindow();
  HousepointsPage = baseFEPage(CreateWindow(Class'FEHousepointsPage',0.0,0.0,640.0,480.0));
  HousepointsPage.book = self;
  HousepointsPage.HideWindow();
  ChallengesPage = baseFEPage(CreateWindow(Class'FEChallengesPage',0.0,0.0,640.0,480.0));
  ChallengesPage.book = self;
  ChallengesPage.HideWindow();
  MainPage = baseFEPage(CreateWindow(Class'FEMainPage',0.0,0.0,640.0,480.0));
  MainPage.book = self;
  OpenBook("MAIN");
  MapPage = baseFEPage(CreateWindow(Class'FEMapPage',0.0,0.0,640.0,480.0));
  MapPage.book = self;
  MapPage.HideWindow();
  CreditsPage = baseFEPage(CreateWindow(Class'FECreditsPage',0.0,0.0,640.0,480.0));
  CreditsPage.book = self;
  CreditsPage.HideWindow();
  LangPage = baseFEPage(CreateWindow(Class'FESoundBrowser',0.0,0.0,640.0,480.0));
  LangPage.book = self;
  LangPage.HideWindow();
  lev = GetLevel();
  if ( InStr(Caps(lev.GetLocalURL()),"AUTOPLAY") >= 0 )
  {
    Log("autoplay");
    bGamePlaying = True;
    bShowSplash = False;
    CloseBook();
  }
}

function ScaleAndDraw (Canvas Canvas, float X, float Y, Texture Tex)
{
  local float FX;
  local float fy;

  if ( Tex == None )
  {
    return;
  }
  FX = Canvas.SizeX / 640.0; 
  fy = Canvas.SizeY / 480.0;
  FX = Canvas.SizeX / 640.0;
  fy = Canvas.SizeY / 480.0;
  FX = 1.0;
  fy = 1.0;
  DrawStretchedTexture(Canvas,X * FX,Y * fy,Tex.USize * FX,Tex.VSize * fy,Tex);
}

function Paint (Canvas Canvas, float X, float Y)
{
  local int Width;
  local int I;
  local int Ox;
  local int Oy;
  local Color saveColor;

  if ( bNeedToStartMusic )
  {
    if ( nMusicHandle == 0 )
    {
      nMusicHandle = GetPlayerOwner().PlayMusic("sm_dia_Ambient02_01.ogg",0.5);
    }
    bNeedToStartMusic = False;
  }
  if ( bResolutionChanged )
  {
    Root.SetScale(Root.RealWidth / 640);
    bResolutionChanged = False;
  }
  if ( bShowBackground )
  {
    ScaleAndDraw(Canvas,0.0,0.0,curBackground.p1);
    ScaleAndDraw(Canvas,256.0,0.0,curBackground.p2);
    ScaleAndDraw(Canvas,512.0,0.0,curBackground.p3);
    ScaleAndDraw(Canvas,0.0,256.0,curBackground.p4);
    ScaleAndDraw(Canvas,256.0,256.0,curBackground.p5);
    ScaleAndDraw(Canvas,512.0,256.0,curBackground.p6);
  }
}

function OpenBook (optional string pageName)
{
  if ( HPConsole(Root.Console).bLocked )
  {
    return;
  }
  HPConsole(Root.Console).bQuickKeyEnable = False;
  harry(HPConsole(Root.Console).Viewport.Actor).StopAiming();
  HPConsole(Root.Console).LaunchUWindow();
  bIsOpen = True;
  if ( pageName != "" )
  {
    ChangePageNamed(pageName);
  }
  Log("OpenBook" @ pageName $ "," @ string(curPage));
  if ( curPage != None )
  {
    curPage.PreOpenBook();
  }
  if (!(pageName ~= "MAIN" ))
  {
    bNeedToStartMusic = True;
  }
}

function CloseBook()
{
  if ( nMusicHandle != 0 )
  {
    bNeedToStartMusic = False;
    GetPlayerOwner().StopMusic(nMusicHandle,0.0);
    nMusicHandle = 0;
  }
  Log(" */**/** CloseBook Called!!! ");
  curPage.ClearRollover();
  if ( bInEndGame == False )
  {
    Root.Console.CloseUWindow();
    bIsOpen = False;
    ChangePage(None);
    bShowBackground = False;
  } 
  else 
  {
    ShowCredits();
  }
}

function bool IsInGameMenuShowing()
{
  return bIsOpen && ((curPage == InGamePage) || (curPage == FolioPage));
}

function bool IsInGameSubMenuShowing()
{
  return bIsOpen && (curPage != InGamePage);
}

function HPMessageBox doHPMessageBox (string Msg, string textButton1, optional string textButton2, optional float TimeOut)
{
  local HPMessageBox W;

  W = HPMessageBox(Root.CreateWindow(Class'HPMessageBox',(640.0 - 246) / 2,(480.0 - 102) / 2,246.0,150.0,self));
  W.Setup(Msg,textButton1,textButton2,TimeOut);
  Root.ShowModal(W);
  return W;
}

function ExitFromGame()
{
  if ( HPConsole(Root.Console).bLocked )
  {
    return;
  }
  HPConsole(Root.Console).bQuickKeyEnable = False;
  HPConsole(Root.Console).LaunchUWindow();
  bGamePlaying = False;
  ChangePage(MainPage);
}

function WindowDone (UWindowWindow W)
{
  bShowBackground = True;
  if ( W == ConfirmQuitGame )
  {
    if ( ConfirmQuitGame.Result == ConfirmQuitGame.button1.Text )
    {
      CloseBook();
      baseConsole(Root.Console).ChangeLevel("startup.unr",False);
      bGamePlaying = False;
      OpenBook();
      ChangePage(MainPage);
    } else {
      CloseBook();
    }
    ConfirmQuitGame = None;
  }
}

function OnLevelLoadDone()
{
  if ( bIsOpen && (curPage == MainPage) )
  {
    MainPage.ShowWindow();
  }
}

function EscFromConsole()
{
  if ( HPConsole(Root.Console).bLocked )
  {
    return;
  }
  HPConsole(Root.Console).bQuickKeyEnable = False;
  HPConsole(Root.Console).LaunchUWindow(True);
  OpenBook("INGAME");
  ChangePage(InGamePage);
}

function TurnMapOn()
{
  if ( curPage != MapPage )
  {
    HPConsole(Root.Console).bQuickKeyEnable = False;
    HPConsole(Root.Console).LaunchUWindow(True);
    OpenBook("MAP");
    ChangePage(MapPage);
  }
}

function TurnMapOff()
{
  if ( curPage == MapPage )
  {
    CloseBook();
  }
}

function ToggleMap()
{
  if ( curPage == MapPage )
  {
    CloseBook();
  } 
  else 
  {
    HPConsole(Root.Console).bQuickKeyEnable = False;
    HPConsole(Root.Console).LaunchUWindow(True);
    OpenBook("MAP");
    ChangePage(MapPage);
  }
}

function DoMapFromConsole()
{
  if ( HPConsole(Root.Console).bLocked )
  {
    return;
  }
  HPConsole(Root.Console).bQuickKeyEnable = False;
  HPConsole(Root.Console).LaunchUWindow(True);
  OpenBook("MAP");
  ChangePage(MapPage);
}

function ExitFromConsole()
{
  if ( HPConsole(Root.Console).bLocked )
  {
    return;
  }
  HPConsole(Root.Console).bQuickKeyEnable = False;
  HPConsole(Root.Console).LaunchUWindow();
  bShowBackground = False;
  ConfirmQuitGame = doHPMessageBox("Are you sure you want to quit","Yes","No");
  return;
}

function Notify (UWindowDialogControl C, byte E)
{
  if ( E == DE_Click )
  {
    switch (C)
    {
      case DismissButton:
      CloseBook();
      break;
      default:
	  Log("FEBook::Notify " $ string(C));
	  break;
    }
  }
}

function WindowEvent (WinMessage Msg, Canvas C, float X, float Y, int Key)
{
  if ( (Msg == WM_Paint) ||  !Root.WaitModal() )
  {
    Super.WindowEvent(Msg,C,X,Y,Key);
  }
}

function bool KeyEvent (byte Key, byte Action, float Delta)
{
  if ( (Action == 1) && (Key == 118) )
  {
    if ( HPConsole(Root.Console).bShiftDown )
    {
      HPConsole(Root.Console).bDebugMode =  !HPConsole(Root.Console).bDebugMode;
    }
    return True;
  }
  if ( Root.ModalWindow != None )
  {
    return False;
  }
  if ( bShowSplash && HPConsole(Root.Console).bDebugMode )
  {
    if ( Action == 1 )
    {
      fShowSplashTime = -1.0;
      return True;
    }
  }
  if ( curPage != None )
  {
    if ( curPage.KeyEvent(Key,Action,Delta) )
    {
      return True;
    }
  }
  if ( (Action == 1) && (Key == 27) )
  {
    Log("febook escape");
    if ( bInEndGame == False )
    {
      return DoEscapeFromPage();
    } 
	else 
	{
      if ( curPage == CreditsPage )
      {
        ChangePagePrevious();
      } 
	  else 
	  {
        ShowCredits();
      }
      return True;
    }
  }
  if ( (Action == 3) && (Key == 9) )
  {
    Log("febook backspace");
    if ( curPage == MapPage )
    {
      TurnMapOff();
      return True;
    }
  }
  return False;
}

function bool DoEscapeFromPage()
{
  if ( curPage == InGamePage )
  {
    CloseBook();
    return True;
  } 
  else if ( curPage != MainPage )
  {
    if ( prevPage == None )
    {
      CloseBook();
    } 
	else 
	{
      ChangePagePrevious();
    }
    Log("FEBook: curPage == " $ string(curPage) $ " prevPage == " $ string(prevPage));
    return True;
  } 
  else 
  {
    return True;
  }
}

function RunURL (string levURL, bool bTravelItems)
{
  Log("runurl");
  bTravelItemsOnLoad = bTravelItems;
  _URLToLoad = levURL;
  bGamePlaying = True;
}

function EndGame()
{
  bInEndGame = True;
}

function RunTheCredits()
{
  if ( HPConsole(Root.Console).bLocked )
  {
    return;
  }
  HPConsole(Root.Console).bQuickKeyEnable = False;
  OpenBook();
  ShowCredits();
}

function ShowCredits()
{
  bInEndGame = True;
  if ( CreditsPage == None )
  {
    CreditsPage = baseFEPage(CreateWindow(Class'FECreditsPage',0.0,0.0,640.0,480.0));
    CreditsPage.book = self;
    CreditsPage.HideWindow();
  }
  ChangePageNamed("CREDITSPAGE");
}

function DoStoryBookInterlude (int StoryBookIdx, name EventWhenDone)
{
}

defaultproperties
{
    InGameBackground=(p1=Texture'HGame.Icons.FEInGameBackTexture1',p2=Texture'HGame.Icons.FEInGameBackTexture2',p3=Texture'HGame.Icons.FEInGameBackTexture3',p4=Texture'HGame.Icons.FEInGameBackTexture4',p5=Texture'HGame.Icons.FEInGameBackTexture5',p6=Texture'HGame.Icons.FEInGameBackTexture6',durration=999999.00)

    Back1Background=(p1=Texture'HGame.Icons.FEBack1Texture1',p2=Texture'HGame.Icons.FEBack1Texture2',p3=Texture'HGame.Icons.FEBack1Texture3',p4=Texture'HGame.Icons.FEBack1Texture4',p5=Texture'HGame.Icons.FEBack1Texture5',p6=Texture'HGame.Icons.FEBack1Texture6',durration=999999.00)
}