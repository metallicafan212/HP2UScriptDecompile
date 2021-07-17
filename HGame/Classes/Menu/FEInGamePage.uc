//================================================================================
// FEInGamePage.
//================================================================================

class FEInGamePage extends baseFEPage;

var HPMessageBox ConfirmQuit;
var bool bSetupAfterPageSwitch;
var HGameButton BeansButton;
var HGameButton HousepointsButton;
var HGameButton SecretsButton;
var HGameButton PotionsButton;
var HGameButton FMucusButton;
var HGameButton WBarkButton;
var HGameButton ChallengesButton;
var HGameButton DuelButton;
var HGameButton FolioButton;
var HGameButton MapButton;
var HGameButton QuidditchButton;
var HGameButton QuitButton;
var HGameButton InputButton;
var HGameButton CreditsButton;
var HGameButton SoundVideoButton;
var HGameSmallButton VersionButton;
var Texture textureChallengesRO;
var Texture textureMapRO;
var Texture textureDuelRO;
var Texture textureQuidRO;
var Texture textureQuitRO;
var Texture textureInputRO;
var Texture textureSoundRO;
var Texture textureCreditsRO;
var Texture textureFolioRO;
var Texture textureGryffRO;
var string strCurrToolTip;
var string strSecretsCount;
var Sound soundTopClick;
var Sound soundMiddleClick;
var Sound soundFolioClick;
var Sound soundBottomClick;
var Sound soundTopRO;
var Sound soundMiddleRO;
var Sound soundFolioRO;
var Sound soundBottomRO;
const nCOUNT_MID_Y= 58;
const nCOUNT_MID_X= 50;
const nTOOLTIP_TEXT_H= 46;
const nTOOLTIP_TEXT_Y= 424;
const nTOOLTIP_TEXT_X= 6;
const nOBJECTIVE_CLIP_X= 626;
const nOBJECTIVE_TEXT_H= 58;
const nOBJECTIVE_TEXT_W= 640;
const nOBJECTIVE_TEXT_Y= 416;
const nOBJECTIVE_TEXT_X= 14;
const nOBJECTIVE_LABEL_H= 16;
const nOBJECTIVE_LABEL_Y= 400;
const nBOTTOM_BAR_Y= 392;
const nTOP_BAR_Y=   0;
const nBAR_H=  88;
const nBAR_X=   0;

function Paint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;
	local bool bHaveObjectiveText;

	fScaleFactor = Canvas.SizeX / WinWidth;
	if ( strCurrToolTip != "" )
	{
		PaintToolTipText(Canvas,fScaleFactor);
	} 
	else 
	{
		PaintObjectiveText(Canvas,fScaleFactor);
	}
	
	Super.Paint(Canvas,X,Y);
}

function AfterPaint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;
	local bool bHaveObjectiveText;
	local int nSaveStyle;

	fScaleFactor = Canvas.SizeX / WinWidth;
	PaintCountText(Canvas,fScaleFactor);
	
	Super.AfterPaint(Canvas,X,Y);
}

function PaintToolTipText (Canvas Canvas, float fScaleFactor)
{
	local Font fontText;
	local Color colorText;
	local harry PlayerHarry;
	
	// Metallicafan212:	Move it up
	local float HScale;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	PlayerHarry = harry(Root.Console.Viewport.Actor);
	if ( Canvas.SizeX <= 512 )
	{
		fontText = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
	} 
	else 
	{
		if ( Canvas.SizeX <= 800 )
		{
			fontText = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
		} 
		else 
		{
			fontText = baseConsole(PlayerHarry.Player.Console).LocalBigFont;
		}
	}
	
	colorText.R = 255;
	colorText.G = 255;
	colorText.B = 255;
	HPHud(PlayerHarry.myHUD).DrawCutStyleText(Canvas, strCurrToolTip, 6 * fScaleFactor, 424 * fScaleFactor * HScale, 46 * fScaleFactor, colorText, fontText);
}

function PaintObjectiveText (Canvas Canvas, float fScaleFactor)
{
	local string strObjectiveId;
	local string strObjective;
	local Font fontText;
	local Color colorText;
	local harry PlayerHarry;
	

	PlayerHarry = harry(Root.Console.Viewport.Actor);
	strObjectiveId = PlayerHarry.strObjectiveId;
	if ( strObjectiveId != "" )
	{
		strObjective = Localize("All",strObjectiveId,"HPDialog");
		strObjective = PlayerHarry.HandleFacialExpression(strObjective,0,True);
		if ( Canvas.SizeX <= 512 )
		{
			fontText = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
		} 
		else 
		{
			fontText = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
		}
		colorText.R = 255;
		colorText.G = 255;
		colorText.B = 255;
	
		HPHud(PlayerHarry.myHUD).DrawCutStyleText(Canvas,GetLocalFEString("InGameMenu_0027"), 14 * fScaleFactor, 400 * fScaleFactor * Class'M212HScale'.Static.UWindowGetHeightScale(Root), 16 * fScaleFactor, colorText, fontText);
		HPHud(PlayerHarry.myHUD).DrawCutStyleText(Canvas,strObjective, 14 * fScaleFactor, 416 * fScaleFactor * Class'M212HScale'.Static.UWindowGetHeightScale(Root), 58 * fScaleFactor, colorText, fontText, 626.0 * fScaleFactor);
	}
}

function PaintCountText (Canvas Canvas, float fScaleFactor)
{
	local StatusManager managerStatus;
	local StatusItem si;
	
	local float hScale;
	
	// Metallicafan212:	Calc once
	hScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	managerStatus = harry(Root.Console.Viewport.Actor).managerStatus;
	si = managerStatus.GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts');
	si.DrawCount(Canvas,HousepointsButton.WinLeft * fScaleFactor, HousepointsButton.WinTop * fScaleFactor * hScale, fScaleFactor * hScale);
	si = managerStatus.GetStatusItem(Class'StatusGroupJellybeans',Class'StatusItemJellybeans');
	si.DrawCount(Canvas,BeansButton.WinLeft * fScaleFactor, BeansButton.WinTop * fScaleFactor * hScale, fScaleFactor * hScale);
	si = managerStatus.GetStatusItem(Class'StatusGroupPotions',Class'StatusItemWiggenwell');
	si.DrawCount(Canvas,PotionsButton.WinLeft * fScaleFactor, PotionsButton.WinTop * fScaleFactor * hScale, fScaleFactor * hScale);
	si = managerStatus.GetStatusItem(Class'StatusGroupPotionIngr',Class'StatusItemFlobberMucus');
	si.DrawCount(Canvas,FMucusButton.WinLeft * fScaleFactor, FMucusButton.WinTop * fScaleFactor * hScale, fScaleFactor * hScale);
	si = managerStatus.GetStatusItem(Class'StatusGroupPotionIngr',Class'StatusItemWiggenBark');
	si.DrawCount(Canvas,WBarkButton.WinLeft * fScaleFactor, WBarkButton.WinTop * fScaleFactor * hScale, fScaleFactor * hScale);
	DrawCount(Canvas, fScaleFactor, SecretsButton.WinLeft, SecretsButton.WinTop, strSecretsCount);
}

function DrawCount (Canvas Canvas, float fScaleFactor, int nButtonLeft, int nButtonTop, string strCount)
{
	local Font fontSave;
	local StatusManager managerStatus;
	local StatusItem si;
	local float fXTextLen;
	local float fYTextLen;
	
	local float hScale;
	
	// Metallicafan212:	Calc once
	hScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	fontSave = Canvas.Font;
	managerStatus = harry(Root.Console.Viewport.Actor).managerStatus;
	si = managerStatus.GetStatusItem(Class'StatusGroupJellybeans',Class'StatusItemJellybeans');
	Canvas.DrawColor = si.GetCountColor();
	Canvas.Font = si.GetCountFont(Canvas);
	Canvas.TextSize(strCount,fXTextLen,fYTextLen);
	Canvas.SetPos((nButtonLeft + 50) * fScaleFactor - fXTextLen / 2, (nButtonTop + 58) * (fScaleFactor * hScale) - fYTextLen / 2);
	Canvas.DrawShadowText(strCount, si.GetCountColor(), si.GetCountColor(True));
	Canvas.Font = fontSave;
}

function int GetObjectiveAreaTop (int nCanvasSizeX, int nCanvasSizeY)
{
	local float fScaleFactor;

	fScaleFactor = nCanvasSizeX / WinWidth;
	//return nCanvasSizeY - 88 * fScaleFactor = return;
	return (nCanvasSizeY - 88 * fScaleFactor * Class'M212HScale'.Static.UWindowGetHeightScale(Root));
}

function Created ()
{
	// Metallicafan212:	Move the buttons
	//local float HScale;
	
	//HScale = GetHeightScale();
	
	// Metallicafan212:	Weld button
	PotionsButton = HGameButton(CreateControl(Class'HGameButton', 30.0, 16.0, 64.0, 64.0));
	PotionsButton.ToolTipString = GetLocalFEString("InGameMenu_0020");
	PotionsButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuWPotion",Class'Texture'));
	PotionsButton.OverTexture = PotionsButton.UpTexture;
	PotionsButton.DownTexture = PotionsButton.OverTexture;
	PotionsButton.DownSound = None;
  
	FMucusButton = HGameButton(CreateControl(Class'HGameButton',110.0,16.0,64.0,64.0));
	FMucusButton.ToolTipString = GetLocalFEString("InGameMenu_0008");
	FMucusButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuFMucus",Class'Texture'));
	FMucusButton.OverTexture = FMucusButton.UpTexture;
	FMucusButton.DownTexture = FMucusButton.OverTexture;
	FMucusButton.DownSound = None;
	
	WBarkButton = HGameButton(CreateControl(Class'HGameButton',192.0,16.0,64.0,64.0));
	WBarkButton.ToolTipString = GetLocalFEString("InGameMenu_0019");
	WBarkButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuWBark",Class'Texture'));
	WBarkButton.OverTexture = WBarkButton.UpTexture;
	WBarkButton.DownTexture = WBarkButton.OverTexture;
	WBarkButton.DownSound = None;
  
	BeansButton = HGameButton(CreateControl(Class'HGameButton',416.0,16.0,64.0,64.0));
	BeansButton.ToolTipString = GetLocalFEString("InGameMenu_0013");
	BeansButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuJellyBeans",Class'Texture'));
	BeansButton.OverTexture = BeansButton.UpTexture;
	BeansButton.DownTexture = BeansButton.OverTexture;
	BeansButton.DownSound = None;
	
	SecretsButton = HGameButton(CreateControl(Class'HGameButton',532.0,16.0,64.0,64.0));
	SecretsButton.ToolTipString = GetLocalFEString("Report_Card_0006");
	SecretsButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuSecrets",Class'Texture'));
	SecretsButton.OverTexture = SecretsButton.UpTexture;
	SecretsButton.DownTexture = SecretsButton.OverTexture;
	SecretsButton.DownSound = None;
  
	HousepointsButton = HGameButton(CreateControl(Class'HGameButton',278.0,5.0,70.0,98.0));
	HousepointsButton.ToolTipString = GetLocalFEString("InGameMenu_0046");
	HousepointsButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2GriffindorCrest",Class'Texture'));
	HousepointsButton.OverTexture = HousepointsButton.UpTexture;
	HousepointsButton.DownTexture = HousepointsButton.OverTexture;
	HousepointsButton.DownSound = soundTopClick;
	
	ChallengesButton = HGameButton(CreateControl(Class'HGameButton',146.0,114.0,64.0,64.0));
	ChallengesButton.ToolTipString = GetLocalFEString("InGameMenu_0044");
	ChallengesButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuChallenges",Class'Texture'));
	ChallengesButton.OverTexture = ChallengesButton.UpTexture;
	ChallengesButton.DownTexture = ChallengesButton.OverTexture;
	ChallengesButton.DownSound = soundMiddleClick;
	
	DuelButton = HGameButton(CreateControl(Class'HGameButton',146.0,248.0,64.0,64.0));
	DuelButton.ToolTipString = GetLocalFEString("InGameMenu_0043");
	DuelButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuWizardDuel",Class'Texture'));
	DuelButton.OverTexture = DuelButton.UpTexture;
	DuelButton.DownTexture = DuelButton.OverTexture;
	DuelButton.DownSound = soundMiddleClick;
  
	FolioButton = HGameButton(CreateControl(Class'HGameButton',252.0,134.0,136.0,168.0));
	FolioButton.ToolTipString = GetLocalFEString("InGameMenu_0004");
	FolioButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuFolioButtonIdle",Class'Texture'));
	FolioButton.OverTexture = FolioButton.UpTexture;
	FolioButton.DownTexture = FolioButton.OverTexture;
	FolioButton.DownSound = soundFolioClick;
  
	MapButton = HGameButton(CreateControl(Class'HGameButton',438.0,114.0,64.0,64.0));
	MapButton.ToolTipString = GetLocalFEString("InGameMenu_0045");
	MapButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2Maps",Class'Texture'));
	MapButton.OverTexture = MapButton.UpTexture;
	MapButton.DownTexture = MapButton.OverTexture;
	MapButton.DownSound = soundMiddleClick;
  
	QuidditchButton = HGameButton(CreateControl(Class'HGameButton',438.0,248.0,64.0,64.0));
	QuidditchButton.ToolTipString = GetLocalFEString("InGameMenu_0042");
	QuidditchButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuQuidditch",Class'Texture'));
	QuidditchButton.OverTexture = QuidditchButton.UpTexture;
	QuidditchButton.DownTexture = QuidditchButton.OverTexture;
	QuidditchButton.DownSound = soundMiddleClick;
  
	QuitButton = HGameButton(CreateControl(Class'HGameButton',12.0,338.0,48.0,48.0));
	QuitButton.ToolTipString = GetLocalFEString("InGameMenu_0002");
	QuitButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuQuit",Class'Texture'));
	QuitButton.OverTexture = QuitButton.UpTexture;
	QuitButton.DownTexture = QuitButton.OverTexture;
	QuitButton.DownSound = soundBottomClick;
  
	InputButton = HGameButton(CreateControl(Class'HGameButton',72.0,338.0,48.0,48.0));
	InputButton.ToolTipString = GetLocalFEString("InGameMenu_0047");
	InputButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2Options",Class'Texture'));
	InputButton.OverTexture = InputButton.UpTexture;
	InputButton.DownTexture = InputButton.OverTexture;
	InputButton.DownSound = soundBottomClick;
  
	SoundVideoButton = HGameButton(CreateControl(Class'HGameButton',520.0,338.0,48.0,48.0));
	SoundVideoButton.ToolTipString = GetLocalFEString("InGameMenu_0048");
	SoundVideoButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuSoundOptions",Class'Texture'));
	SoundVideoButton.OverTexture = SoundVideoButton.UpTexture;
	SoundVideoButton.DownTexture = SoundVideoButton.OverTexture;
	SoundVideoButton.DownSound = soundBottomClick;
  
	textureChallengesRO = Texture(DynamicLoadObject("HP2_Menu.HP2ChallengesBarWet",Class'WetTexture'));
	textureMapRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MapsWet",Class'WetTexture'));
	textureDuelRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuWizardDuelWet",Class'WetTexture'));
	textureQuidRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuQuidditchWet",Class'WetTexture'));
	textureQuitRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuQuitWet",Class'WetTexture'));
	textureInputRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2OptionsWet",Class'WetTexture'));
	textureSoundRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuSoundOptionsWet",Class'WetTexture'));
	textureFolioRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuFolioButtonIdle",Class'Texture'));
	textureGryffRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2GriffindorCrestWet",Class'WetTexture'));
  
	CreateBackPageButton(578,338);
	
	if ( HPConsole(Root.Console).bDebugMode )
	{
		CreditsButton = HGameButton(CreateControl(Class'HGameButton',135.0,338.0,48.0,48.0));
		CreditsButton.ToolTipString = "Credits";
		CreditsButton.UpTexture = InputButton.UpTexture;
		CreditsButton.OverTexture = CreditsButton.UpTexture;
		CreditsButton.DownTexture = CreditsButton.DownTexture;
		textureCreditsRO = textureInputRO;
		SoundVideoButton.DownSound = soundBottomClick;
	}
  
	VersionButton = HGameSmallButton(CreateControl(Class'HGameSmallButton',550.0,462.0,84.0,25.0));
	VersionButton.SetFont(0);
	VersionButton.TextColor.R = 250;
	VersionButton.TextColor.G = 250;
	VersionButton.TextColor.B = 250;
	VersionButton.Align = TA_Right;
	VersionButton.SetText(Class'Version'.Default.Version);
	
	Super.Created();
}

function WindowDone (UWindowWindow W)
{
	if ( W == ConfirmQuit )
	{
		if ( ConfirmQuit.Result == ConfirmQuit.button1.Text )
		{
			Root.DoQuitGame();
		}
		ConfirmQuit = None;
	}
}

function bool KeyEvent (byte Key, byte Action, float Delta)
{
	return False;
}

function Notify (UWindowDialogControl C, byte E)
{
	local int I;

	if ( E == 2 )
	{
		switch (C)
		{
			case InputButton:
				FEBook(book).ChangePageNamed("INPUT");
				break;
      
			case SoundVideoButton:
				FEBook(book).ChangePageNamed("SOUNDVIDEO");
				break;
      
			case QuitButton:
				ConfirmQuit = doHPMessageBox(GetLocalFEString("InGameMenu_0026"),GetLocalFEString("Shared_Menu_0003"),GetLocalFEString("Shared_Menu_0004"));
				break;
      
			case BackPageButton:
				FEBook(book).CloseBook();
				break;
      
			case FolioButton:
				FEBook(book).ChangePageNamed("FOLIO");
				break;
      
			case QuidditchButton:
				FEBook(book).ChangePageNamed("QUIDDITCH");
				break;
      
			case DuelButton:
				FEBook(book).ChangePageNamed("DUEL");
				break;
      
			case ChallengesButton:
				FEBook(book).ChangePageNamed("CHALLENGES");
				break;
      
			case MapButton:
				FEBook(book).ChangePageNamed("MAP");
				break;
      
			case CreditsButton:
				FEBook(book).ChangePageNamed("CREDITSPAGE");
				break;
     
			case HousepointsButton:
				FEBook(book).ChangePageNamed("HPOINTS");
				break;
			
			default:
				break;
		}
	} 
	else 
	{
		if ( E == 12 )
		{
			switch (C)
			{
				case DuelButton:
					SetRollover(DuelButton,textureDuelRO,soundMiddleRO,True);
					break;
				
				case ChallengesButton:
					SetRollover(ChallengesButton,textureChallengesRO,soundMiddleRO,True);
					break;
				
				case MapButton:
					SetRollover(MapButton,textureMapRO,soundMiddleRO,True);
					break;
				
				case QuidditchButton:
					SetRollover(QuidditchButton,textureQuidRO,soundMiddleRO,True);
					break;
				
				case QuitButton:
					SetRollover(QuitButton,textureQuitRO,soundBottomRO,True);
					break;
				
				case InputButton:
					SetRollover(InputButton,textureInputRO,soundBottomRO,True);
					break;
				
				case SoundVideoButton:
					SetRollover(SoundVideoButton,textureSoundRO,soundBottomRO,True);
					break;
				
				case FolioButton:
					SetRollover(FolioButton,textureFolioRO,soundFolioRO,False);
					break;
				
				case CreditsButton:
					SetRollover(CreditsButton,textureCreditsRO,soundBottomRO,True);
					break;
				
				case HousepointsButton:
					SetRollover(HousepointsButton,textureGryffRO,soundTopRO,True);
					break;
			}
		} 
		else 
		{
			if ( E == 9 )
			{
				switch (C)
				{
					case DuelButton:
					case ChallengesButton:
					case MapButton:
					case QuidditchButton:
					case QuitButton:
					case InputButton:
					case SoundVideoButton:
					case FolioButton:
					case CreditsButton:
					case HousepointsButton:
						ClearRollover();
						break;
				}
			}
		}
	}
	
	Super.Notify(C,E);
}

function PreSwitchPage ()
{
	Super.PreSwitchPage();
	strSecretsCount = GetSecretsCount();
	if ( HPConsole(Root.Console).bDebugMode )
	{
		VersionButton.ShowWindow();
	} 
	else 
	{
		VersionButton.HideWindow();
	}
}

function ToolTip (string strSetTip)
{
	strCurrToolTip = strSetTip;
}

function string GetSecretsCount ()
{
	local string strSecrets;
	local int nNumSecrets;
	local int nNumSecretsFound;
	local SecretAreaMarker Marker;

	foreach Root.Console.Viewport.Actor.AllActors(Class'SecretAreaMarker',Marker)
	{
		nNumSecrets++;
		if ( Marker.bFound )
		{
			nNumSecretsFound++;
		}
	}
	
	strSecrets = string(nNumSecretsFound) $ "/" $ string(nNumSecrets);
  
	return strSecrets;
}

defaultproperties
{
    soundTopClick=Sound'HPSounds.menu_sfx.GUI_Esc_Click3'

    soundMiddleClick=Sound'HPSounds.menu_sfx.GUI_Esc_Click1'

    soundFolioClick=Sound'HPSounds.menu_sfx.GUI_Esc_Click2'

    soundBottomClick=Sound'HPSounds.menu_sfx.GUI_Esc_Click5'

    soundTopRO=Sound'HPSounds.menu_sfx.GUI_Esc_Rollover1'

    soundMiddleRO=Sound'HPSounds.menu_sfx.GUI_Esc_Rollover2'

    soundFolioRO=Sound'HPSounds.menu_sfx.GUI_Esc_Rollover3'

    soundBottomRO=Sound'HPSounds.menu_sfx.GUI_Esc_Rollover4'

}