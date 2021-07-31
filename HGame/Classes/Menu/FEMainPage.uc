//================================================================================
// FEMainPage.
//================================================================================

class FEMainPage extends baseFEPage;

struct LevelListItem
{
  var string LevelName;
  var string LevelUrl;
  var UWindowButton Button;
};

var UWindowButton NewGameButton;
var UWindowSmallButton LoadGameButton;
var UWindowButton OptionsButton;
var UWindowButton CreditsButton;
var UWindowButton ExitButton;
var UWindowButton LangButton;
var UWindowButton LogoWindow;
var string LegalText;
var HPMessageBox ConfirmExit;
var UWindowSmallButton VersionButton;
var bool bE3DemoMode;
var UWindowButton E3DemoStartButton;
var LevelListItem LevelList[30];
var int FirstPreviewIndex;

function BeforePaint (Canvas C, float X, float Y)
{
  Super.BeforePaint(C,X,Y);
  if ( HPConsole(Root.Console).bDebugMode != CreditsButton.bWindowVisible )
  {
    if ( HPConsole(Root.Console).bDebugMode )
    {
      VersionButton.ShowWindow();
    } else {
      LangButton.HideWindow();
      CreditsButton.HideWindow();
      VersionButton.HideWindow();
    }
  }
}

function Paint (Canvas Canvas, float X, float Y)
{
  local float W;
  local float H;
  local Font saveFont;

  saveFont = Canvas.Font;
  Canvas.Font = Root.Fonts[0];
  TextSize(Canvas,LegalText,W,H);
  Root.SetPosScaled(Canvas,WinWidth - W - 8,WinHeight - H - 8);
  Canvas.DrawText(LegalText);
  Canvas.Font = saveFont;
}

function Created()
{
  local int I;
  local Texture tempTexture;
  local float X;
  local float Y;
  local float W;
  local float H;
  local int LevelButtonHeight;

  Super.Created();
  LegalText = Localize("all","legal_title_01","Pickup");
  VersionButton = UWindowSmallButton(CreateControl(Class'UWindowSmallButton',WinWidth - 84,WinHeight - 30,84.0,25.0));
  VersionButton.SetFont(0);
  VersionButton.TextColor.R = 250;
  VersionButton.TextColor.G = 250;
  VersionButton.TextColor.B = 250;
  // VersionButton.Align = 2;
  VersionButton.Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD 
  VersionButton.SetText(Class'Version'.Default.Version);
  X = 470.0;
  Y = 220.0;
  W = 150.0;
  H = 14.0;
  if (  !bE3DemoMode )
  {
	for(I = 0; I < FirstPreviewIndex; I++)
    {
      if ( LevelList[I].LevelName != "" )
      {
        LevelList[I].Button = UWindowButton(CreateControl(Class'UWindowButton',X,Y,W,H));
        LevelList[I].Button.SetFont(4);
        LevelList[I].Button.TextColor.R = 250;
        LevelList[I].Button.TextColor.G = 250;
        LevelList[I].Button.TextColor.B = 250;
        LevelList[I].Button.bColorOver = True;
        LevelList[I].Button.OverColor.R = 250;
        LevelList[I].Button.OverColor.G = 5;
        LevelList[I].Button.OverColor.B = 5;
        // LevelList[I].Button.Align = 2;
		LevelList[I].Button.Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD
        LevelList[I].Button.SetText(LevelList[I].LevelName);
        LevelList[I].Button.ToolTipString = LevelList[I].LevelName;
        Y += H;
      }
    }
    Y += H;
    ExitButton = UWindowButton(CreateControl(Class'UWindowButton',X,Y,W,H));
    ExitButton.SetFont(4);
    ExitButton.TextColor.R = 250;
    ExitButton.TextColor.G = 250;
    ExitButton.TextColor.B = 250;
    ExitButton.bColorOver = True;
    ExitButton.OverColor.R = 250;
    ExitButton.OverColor.G = 5;
    ExitButton.OverColor.B = 5;
    // ExitButton.Align = 2;
	ExitButton.Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD
    ExitButton.SetText("Exit");
    ExitButton.ToolTipString = "Exit To Windows";
    X = 32.0;
    Y = 210.0;

	for(I = FirstPreviewIndex; I < 30; I++)
    {
      if ( LevelList[I].LevelName != "" )
      {
        LevelList[I].Button = UWindowButton(CreateControl(Class'UWindowButton',X,Y,W,H));
        LevelList[I].Button.SetFont(4);
        LevelList[I].Button.TextColor.R = 96;
        LevelList[I].Button.TextColor.G = 96;
        LevelList[I].Button.TextColor.B = 112;
        LevelList[I].Button.TextColor.A = 192;
        LevelList[I].Button.bColorOver = True;
        LevelList[I].Button.OverColor.R = 128;
        LevelList[I].Button.OverColor.G = 96;
        LevelList[I].Button.OverColor.B = 5;
        // LevelList[I].Button.Align = 2;
		LevelList[I].Button.Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD
        LevelList[I].Button.SetText(LevelList[I].LevelName);
        LevelList[I].Button.ToolTipString = LevelList[I].LevelName;
        Y += H;
      }
    }
  } else {
    E3DemoStartButton = UWindowButton(CreateControl(Class'UWindowButton',WinWidth / 2 - 80,WinHeight - 100,160.0,60.0));
    E3DemoStartButton.ToolTipString = "Start Demo";
    ExitButton = UWindowButton(CreateControl(Class'UWindowButton',WinWidth - 50,WinHeight - 60,50.0,30.0));
    ExitButton.SetFont(4);
    ExitButton.TextColor.R = 250;
    ExitButton.TextColor.G = 250;
    ExitButton.TextColor.B = 250;
    ExitButton.bColorOver = True;
    ExitButton.OverColor.R = 250;
    ExitButton.OverColor.G = 5;
    ExitButton.OverColor.B = 5;
    // ExitButton.Align = 2;
	ExitButton.Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD
    ExitButton.SetText("Exit");
    ExitButton.ToolTipString = "Exit To Windows";
  }
}

function WindowDone (UWindowWindow W)
{
  if ( W == ConfirmExit )
  {
    if ( ConfirmExit.Result == ConfirmExit.button1.Text )
    {
      Root.DoQuitGame();
    }
    ConfirmExit = None;
  }
}

function bool KeyEvent (byte Key, byte Action, float Delta)
{
  if ( (Action == 1) && (Key == 27) )
  {
    ConfirmExit = doHPMessageBox("Are you sure you want to exit?","Yes","No");
  } else {
    if ( (Action == 1) && (Key == 123) )
    {
      FEBook(book).CloseBook();
    }
  }
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  if ( E == DE_Click )
  {
	for(I = 0; I < 30; I++)
    {
      if ( LevelList[I].Button == C )
      {
        FEBook(book).RunURL(LevelList[I].LevelUrl,False);
      }
    }
    if ( E3DemoStartButton == C )
    {
      FEBook(book).RunURL("e3demo.unr",False);
    }
    switch (C)
    {
      case NewGameButton:
      break;
      case LoadGameButton:
      FEBook(book).ChangePageNamed("load");
      break;
      case OptionsButton:
      FEBook(book).ChangePageNamed("options");
      break;
      case CreditsButton:
      if ( HPConsole(Root.Console).bDebugMode )
      {
        FEBook(book).ShowCredits();
      }
      break;
      case ExitButton:
      Root.DoQuitGame();
      if ( HPConsole(Root.Console).bDebugMode )
      {
        Root.DoQuitGame();
      } else {
        ConfirmExit = doHPMessageBox(GetLocalFEString("Main_Menu_0006"),GetLocalFEString("Shared_Menu_0003"),GetLocalFEString("Shared_Menu_0004"));
      }
      break;
      case LangButton:
      FEBook(book).ChangePageNamed("LANG");
      break;
      default:
    }
  }
}

function PreSwitchPage()
{
}

defaultproperties
{
    LevelList(0)=(LevelName="Privet Drive",LevelUrl="PrivetDr.unr",Button=None)

    LevelList(1)=(LevelName="Whomping Willow",LevelUrl="adv1Willow.unr",Button=None)

    LevelList(2)=(LevelName="Ch1 Rictusempra",LevelUrl="Ch1Rictusempra.unr",Button=None)

    LevelList(3)=(LevelName="Ch2 Skurge",LevelUrl="Ch2Skurge.unr",Button=None)

    LevelList(4)=(LevelName="Dungeon Ingredient",LevelUrl="Adv3DungeonQuest.unr",Button=None)

    LevelList(5)=(LevelName="Ch3 Diffindo",LevelUrl="Ch3Diffindo.unr",Button=None)

    LevelList(6)=(LevelName="Greenhouse Ingredient",LevelUrl="Adv4Greenhouse.unr",Button=None)

    LevelList(7)=(LevelName="A Bit of Goyle",LevelUrl="Adv6Goyle.unr",Button=None)

    LevelList(8)=(LevelName="Slytherin Common Room",LevelUrl="Adv7SlythComRoom.unr",Button=None)

    LevelList(9)=(LevelName="Ch4 Spongify",LevelUrl="Ch4Spongify.unr",Button=None)

    LevelList(10)=(LevelName="Forbidden Forest",LevelUrl="Adv8Forest.unr",Button=None)

    LevelList(11)=(LevelName="Aragog",LevelUrl="Adv9Aragog.unr",Button=None)

    LevelList(12)=(LevelName="Corridor of Secrets A",LevelUrl="Adv11aCorridor.unr",Button=None)

    LevelList(13)=(LevelName="Corridor of Secrets B",LevelUrl="Adv11bSecrets.unr",Button=None)

    LevelList(14)=(LevelName="Chamber of Secrets",LevelUrl="Adv12Chamber.unr",Button=None)

    LevelList(15)=(LevelName="Test Level",LevelUrl="Studies\TestLevel.unr",Button=None)

    LevelList(16)=(LevelName="Quidditch Lesson",LevelUrl="Quidditch_Intro.unr",Button=None)

    LevelList(17)=(LevelName="Quidditch",LevelUrl="Quidditch.unr",Button=None)

    LevelList(18)=(LevelName="Wizard Dueling",LevelUrl="Arena.unr",Button=None)

    LevelList(19)=(LevelName="Bean Bonus",LevelUrl="BeanRewardRoom.unr",Button=None)

    LevelList(20)=(LevelName="Gold Wizard Card",LevelUrl="Ch6WizardCard.unr",Button=None)

    LevelList(21)=(LevelName="Entry Hall",LevelUrl="Entryhall_hub.unr",Button=None)

    LevelList(22)=(LevelName="Grandstaircase",LevelUrl="grandstaircase_hub.unr",Button=None)

    LevelList(23)=(LevelName="Grounds Hub",LevelUrl="Grounds_Hub.unr",Button=None)

    LevelList(24)=(LevelName="Grounds (Night)",LevelUrl="grounds_night.unr",Button=None)

    LevelList(25)=(LevelName="Gryffindor Challenge Chamber",LevelUrl="Ch7Gryffindor.unr",Button=None)

    FirstPreviewIndex=15

}
