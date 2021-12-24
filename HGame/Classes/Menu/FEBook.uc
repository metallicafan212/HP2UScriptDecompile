//================================================================================
// FEBook.
//================================================================================

class FEBook extends baseFEBook; 

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\FEInGameBackTexture1.PNG	GROUP=Icons	Name=FEInGameBackTexture1 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture2.PNG	GROUP=Icons	Name=FEInGameBackTexture2 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture3.PNG	GROUP=Icons	Name=FEInGameBackTexture3 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture4.PNG	GROUP=Icons	Name=FEInGameBackTexture4 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture5.PNG	GROUP=Icons	Name=FEInGameBackTexture5 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEInGameBackTexture6.PNG	GROUP=Icons	Name=FEInGameBackTexture6 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture1.PNG	GROUP=Icons	Name=FEBack1Texture1 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture2.PNG	GROUP=Icons	Name=FEBack1Texture2 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture3.PNG	GROUP=Icons	Name=FEBack1Texture3 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture4.PNG	GROUP=Icons	Name=FEBack1Texture4 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture5.PNG	GROUP=Icons	Name=FEBack1Texture5 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0
#exec Texture Import File=Textures\Icons\FEBack1Texture6.PNG	GROUP=Icons	Name=FEBack1Texture6 COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0

// Metallicafan212:	Textures for the new layout
#exec Texture Import File=Textures\InGamePage\Bottom.png	GROUP=FEBook	Name=FEBottom 	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\InGamePage\Top.png		GROUP=FEBook	Name=FETop 		COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\InGamePage\LTop.png		GROUP=FEBook	Name=FETLeft	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\InGamePage\LBot.png		GROUP=FEBook	Name=FEBLeft	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\InGamePage\RTop.png		GROUP=FEBook	Name=FETRight	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\InGamePage\RBot.png		GROUP=FEBook	Name=FEBRight	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\InGamePage\Back.png		GROUP=FEBook	Name=FEBack		COMPRESSION=1 UPSCALE=1 Mips=1 Flags=0

// Metallicafan212:	Test
//#exec Texture Import File=Textures\DeusEx.png				GROUP=FEBook	Name=FEDX		COMPRESSION=1 UPSCALE=1 MIPS=1 FLAGS=0

// Metallicafan212:	Texture vars for these
var Texture FEBot;
var Texture FETop;
var Texture FETL;
var Texture FEBL;
var Texture FETR;
var Texture FEBR;
var Texture FEBackground;

// Metallicafan212:	Optional middle "flavor" texture
var Texture FEMid;

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

var HGameSmallButton DismissButton;
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

// Metallicafan212:	To show the custom main page background
var bool bShowMainBack;
var bool bShowNewBack;

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
	
	// Metallicafan212:	Tell them to reposition their controls, if they're relatively positioned
	MainPage.RepositionChildControls();
	ReportPage.RepositionChildControls();
	FolioPage.RepositionChildControls();
	ChapterPage.RepositionChildControls();
	SavePage.RepositionChildControls();
	InGamePage.RepositionChildControls();
	SlotPage.RepositionChildControls();
	CreditsPage.RepositionChildControls();
	LoadPage.RepositionChildControls();
	InputPage.RepositionChildControls();
	SoundVideoPage.RepositionChildControls();
	SplashPage.RepositionChildControls();
	LangPage.RepositionChildControls();
	MapPage.RepositionChildControls();
	QuidPage.RepositionChildControls();
	DuelPage.RepositionChildControls();
	HousepointsPage.RepositionChildControls();
	ChallengesPage.RepositionChildControls();
	curPage.RepositionChildControls();
	prevPage.RepositionChildControls();
	
	// Metallicafan212:	Do it to all pages...
	MainPage.ResolutionChanged(W, H);
	ReportPage.ResolutionChanged(W, H);
	FolioPage.ResolutionChanged(W, H);
	ChapterPage.ResolutionChanged(W, H);
	SavePage.ResolutionChanged(W, H);
	InGamePage.ResolutionChanged(W, H);
	SlotPage.ResolutionChanged(W, H);
	CreditsPage.ResolutionChanged(W, H);
	LoadPage.ResolutionChanged(W, H);
	InputPage.ResolutionChanged(W, H);
	SoundVideoPage.ResolutionChanged(W, H);
	SplashPage.ResolutionChanged(W, H);
	LangPage.ResolutionChanged(W, H);
	MapPage.ResolutionChanged(W, H);
	QuidPage.ResolutionChanged(W, H);
	DuelPage.ResolutionChanged(W, H);
	HousepointsPage.ResolutionChanged(W, H);
	ChallengesPage.ResolutionChanged(W, H);
	curPage.ResolutionChanged(W, H);
	prevPage.ResolutionChanged(W, H);
	
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
	
	// Metallicafan212:	Default to false
	bShowBackground = False;
	
	bShowMainBack = false;
	bShowNewBack = false;
	
	switch (curPage)
	{
		case MainPage:
			bGamePlaying = False;			
			break;
			
		case InputPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
			break;
    
		case SoundVideoPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
			break;
    
		case LangPage:
			break;
		
		// Metallicafan212:	Slowly changing these to manual painting in the page themselves
		case InGamePage:
			//bShowBackground = True;
			//curBackground = InGameBackground;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = true;
			bShowNewBack = true;
			
			break;
    
		case QuidPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
			break;
    
		case DuelPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
			break;
    
		case HousepointsPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
			break;
    
		case ChallengesPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
			break;
		
		case FolioPage:
			//bShowBackground = True;
			//curBackground = Back1Background;
			
			// Metallicafan212:	New background stuff
			bShowMainBack = false;
			bShowNewBack = true;
			
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
	bNewGame 	= False;
	DismissButton = HGameSmallButton(CreateControl(Class'HGameSmallButton', WinWidth - 10, 0.0, 10.0, 10.0));
	DismissButton.SetFont(4);
	StatusBarTextWindow = UWindowWrappedTextArea(CreateControl(Class'UWindowWrappedTextArea', 0.0, WinHeight - 26, 500.0, 26.0));
	StatusBarTextWindow.Clear();
	StatusBarTextWindow.AddText("");
	StatusBarTextWindow.Font = 4;
	bShowBackground = True;
	InGamePage = FEInGamePage(CreateWindow(Class'FEInGamePage', 0.0, 0.0, WinWidth, WinHeight));
	InGamePage.book = self;
	InGamePage.HideWindow();
	FolioPage = baseFEPage(CreateWindow(Class'FEFolioPage', 0.0, 0.0, WinWidth, WinHeight));
	FolioPage.book = self;
	FolioPage.HideWindow();
	InputPage = baseFEPage(CreateWindow(Class'FEInputPage', 0.0, 0.0, WinWidth, WinHeight));
	InputPage.book = self;
	InputPage.HideWindow();
	SoundVideoPage = baseFEPage(CreateWindow(Class'FESoundVideoPage', 0.0, 0.0, WinWidth, WinHeight));
	SoundVideoPage.book = self;
	SoundVideoPage.HideWindow();
	QuidPage = baseFEPage(CreateWindow(Class'FEQuidPage', 0.0, 0.0, WinWidth, WinHeight));
	QuidPage.book = self;
	QuidPage.HideWindow();
	DuelPage = baseFEPage(CreateWindow(Class'FEDuelPage', 0.0, 0.0, WinWidth, WinHeight));
	DuelPage.book = self;
	DuelPage.HideWindow();
	HousepointsPage = baseFEPage(CreateWindow(Class'FEHousepointsPage', 0.0, 0.0, WinWidth, WinHeight));
	HousepointsPage.book = self;
	HousepointsPage.HideWindow();
	ChallengesPage = baseFEPage(CreateWindow(Class'FEChallengesPage', 0.0, 0.0, WinWidth, WinHeight));
	ChallengesPage.book = self;
	ChallengesPage.HideWindow();
	MainPage = baseFEPage(CreateWindow(Class'FEMainPage',0.0, 0.0, WinWidth, WinHeight));
	MainPage.book = self;
	OpenBook("MAIN");
	MapPage = baseFEPage(CreateWindow(Class'FEMapPage',0.0, 0.0, WinWidth, WinHeight));
	MapPage.book = self;
	MapPage.HideWindow();
	CreditsPage = baseFEPage(CreateWindow(Class'FECreditsPage', 0.0, 0.0, WinWidth, WinHeight));
	CreditsPage.book = self;
	CreditsPage.HideWindow();
	LangPage = baseFEPage(CreateWindow(Class'FESoundBrowser',0.0, 0.0, WinWidth, WinHeight));
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
	
	// Metallicafan212:	Fix the menus not being scaled right
	MainPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	ReportPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	FolioPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	ChapterPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	SavePage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	InGamePage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	SlotPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	CreditsPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	LoadPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	InputPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	SoundVideoPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	SplashPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	LangPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	MapPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	QuidPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	DuelPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	HousepointsPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	ChallengesPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	curPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	prevPage.ResolutionChanged(Root.RealWidth, Root.RealHeight);
	
	MainPage.RepositionChildControls();
	ReportPage.RepositionChildControls();
	FolioPage.RepositionChildControls();
	ChapterPage.RepositionChildControls();
	SavePage.RepositionChildControls();
	InGamePage.RepositionChildControls();
	SlotPage.RepositionChildControls();
	CreditsPage.RepositionChildControls();
	LoadPage.RepositionChildControls();
	InputPage.RepositionChildControls();
	SoundVideoPage.RepositionChildControls();
	SplashPage.RepositionChildControls();
	LangPage.RepositionChildControls();
	MapPage.RepositionChildControls();
	QuidPage.RepositionChildControls();
	DuelPage.RepositionChildControls();
	HousepointsPage.RepositionChildControls();
	ChallengesPage.RepositionChildControls();
	curPage.RepositionChildControls();
	prevPage.RepositionChildControls();
}

function ScaleAndDraw (Canvas Canvas, float X, float Y, Texture Tex)
{
	local float FX;
	local float fy;
	
	//Log("Width " $ WinWidth $ " Height " $ WinHeight);
	
	/*
	local float XScale, YScale;
	
	Log("Width " $ WinWidth $ " Height " $ WinHeight);
	
	XScale = (4.0 / 3.0) / (WinWidth / WinHeight);
	YScale = XScale;//(WinHeight / WinWidth) / (3.0 / 4.0);
	*/

	if ( Tex == None )
	{
		return;
	}
	//FX = Canvas.SizeX / 640.0; 
	//fy = Canvas.SizeY / 480.0;
	//FX = Canvas.SizeX / 640.0;
	//fy = Canvas.SizeY / 480.0;
	//FX = 1.0;
	//fy = 1.0;
  
	// Metallicafan212: We need to reduce based on our real size
	//					4/3 uses 1.0, so use that as our scale
	
	//FX = (3.0 / 4.0) * (Canvas.SizeX / float(Canvas.SizeY));
	//FY = (4.0 / 3.0) * (Canvas.SizeY / float(Canvas.SizeX));
	
	//FX = XScale;
	//FY = YScale;
	FX = 1.0;
	//FY = 1.0;
	FY = (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);

	DrawStretchedTexture(Canvas, X * FX, Y * FY, Tex.USize * FX, Tex.VSize * FY, Tex);
}

function Paint (Canvas Canvas, float X, float Y)
{
	local int Width;
	local int I;
	local int Ox;
	local int Oy;
	local Color saveColor;
	
	local float fScaleFactor;
	local bool bHaveObjectiveText;
	
	local float HScale, MidUSize, MidVSize;

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
		
		// Metallicafan212:	We need to work through all our controls
	}
	
	HScale = Class'M212HScale'.Static.CanvasGetHeightScale(Canvas);

	fScaleFactor = Canvas.SizeX / WinWidth;
	
	// Metallicafan212:	Height scale
	fScaleFactor *= HScale;
	
	Canvas.bNoUVClamp = false;
	
	// Metallicafan212:	Custom layering functions, for customizing how stuff is drawn
	if(CurPage.ExBackLayering != None)
		CurPage.ExBackLayering.static.BeforeBackgroundDraw(Canvas, CurPage);
		
	// Metallicafan212:	Moved from FEInGamePage
	Canvas.bNoUVClamp = true;
	
	if(bShowNewBack)
	{
		// Metallicafan212:	Paint the background layer
		Canvas.SetPos(0, 0);
		Canvas.SetClip(Canvas.SizeX, Canvas.SizeY);
		Canvas.DrawTileClipped(FEBackground, Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, Canvas.SizeX * 2.5, Canvas.SizeY * 2.5);
		
		// Metallicafan212:	We need to scale the pos to the middle of the screen
		if(FEMid != none)
		{
			if(FEMid.USize > FEMid.VSize)
			{
				MidUSize = 137.0 * fScaleFactor * (FEMid.USize / float(FEMid.VSize));
				MidVSize = 137.0 * fScaleFactor;
				
				//Log(MidUSize $ " " $ MidVSize);
				
				// Metallicafan212:	Optional middle icon
				Canvas.SetPos((Canvas.SizeX / 2.0) - MidUSize, (Canvas.SizeY / 2.0) - MidVSize);
				Canvas.DrawTile(FEMid, fScaleFactor * 274.0 * (FEMid.USize / float(FEMid.VSize)), fScaleFactor * 274.0, 0.0, 0.0, FEMid.USize, FEMid.VSize);
			}
			else
			{
				MidUSize = 137.0 * fScaleFactor;
				MidVSize = 137.0 * fScaleFactor * (FEMid.VSize / float(FEMid.USize));
				
				//Log(MidUSize $ " " $ MidVSize);
				
				// Metallicafan212:	Optional middle icon
				Canvas.SetPos((Canvas.SizeX / 2.0) - MidUSize, (Canvas.SizeY / 2.0) - MidVSize);
				Canvas.DrawTile(FEMid, fScaleFactor * 274.0, fScaleFactor * 274.0 * (FEMid.VSize / float(FEMid.USize)), 0.0, 0.0, FEMid.USize, FEMid.VSize);
			}
		}
	}
	
	// Metallicafan212:	Render on top the background fill layer
	if(CurPage.ExBackLayering != None)
		CurPage.ExBackLayering.static.AfterBackgroundLayer(Canvas, CurPage);
	
	if(bShowMainBack)
	{
		// Metallicafan212:	Now draw the top
		// 					Middle first
		Canvas.SetPos(0, 0);
		Canvas.DrawTile(FETop, Canvas.SizeX, 128 * fScaleFactor, 0.0, 0.0, FETop.USize, FETop.VSize);
			
		// Metallicafan212:	Left bracket
		Canvas.SetPos(0, 0);
		Canvas.DrawIcon(FETL, fScaleFactor * (128.0 / FETL.VSize));
			
		// Metallicafan212:	Right bracket
		Canvas.SetPos(Canvas.SizeX - (128.0 * fScaleFactor), 0);
		Canvas.DrawIcon(FETR, fScaleFactor * (128.0 / FETL.VSize));
			
		// Metallicafan212:	Draw the bottom
		//					Middle first
		Canvas.SetPos(0, Canvas.SizeY - (128.0 * fScaleFactor));
			
		Canvas.DrawTile(FEBot, Canvas.SizeX, 128 * fScaleFactor, 0.0, 0.0, FETop.USize, FETop.VSize);
			
		// Metallicafan212:	Left bracket
		Canvas.SetPos(0, Canvas.SizeY - (128.0 * fScaleFactor));
		Canvas.DrawIcon(FEBL, fScaleFactor * (128.0 / FETL.VSize));
			
		// Metallicafan212:	Right bracket
		Canvas.SetPos(Canvas.SizeX - (128.0 * fScaleFactor), Canvas.SizeY - (128.0 * fScaleFactor));
		Canvas.DrawIcon(FEBR, fScaleFactor * (128.0 / FETL.VSize));
	}
	
	// Metallicafan212:	After the InGamePage bars, render on top
	if(CurPage.ExBackLayering != None)
		CurPage.ExBackLayering.static.AfterLayering(Canvas, CurPage);
	
	Canvas.bNoUVClamp = false;
	
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

function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY;
	
	local bool bOldNoSmooth;
	
	// Metallicafan212:	Disable no smooth
	bOldNoSmooth = C.bNoSmooth;
	C.bNoSmooth = false;

	OrgX = C.OrgX;
	OrgY = C.OrgY;
	ClipX = C.ClipX;
	ClipY = C.ClipY;

	C.SetOrigin(OrgX + ClippingRegion.X * Root.GUIScale, OrgY + ClippingRegion.Y * Root.HGUIScale);//Root.GUIScale);
	C.SetClip(Root.RealWidth, Root.RealHeight);//ClippingRegion.W * Root.GUIScale, ClippingRegion.H * Root.HGUIScale);//Root.GUIScale);

	C.SetPos((X - ClippingRegion.X) * Root.GUIScale, (Y - ClippingRegion.Y) * Root.HGUIScale);//Root.GUIScale);
	C.DrawTileClipped( Tex, W * Root.GUIScale, H * Root.HGUIScale, tX, tY, tW, tH);//Root.GUIScale, tX, tY, tW, tH);
	
	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
	
	C.bNoSmooth = bOldNoSmooth;
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
	
	FEBot=Texture'HGame.FEBook.FEBottom'
	FETop=Texture'HGame.FEBook.FETop'
	FETL=Texture'HGame.FEBook.FETLeft'
	FEBL=Texture'HGame.FEBook.FEBLeft'
	FETR=Texture'HGame.FEBook.FETRight'
    FEBR=Texture'HGame.FEBook.FEBRight'
	FEBackground=Texture'HGame.FEBook.FEBack'
	//FEMid=Texture'HGame.FEBook.FEDX'
}