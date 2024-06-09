//================================================================================
// FEFolioPage.
//================================================================================

class FEFolioPage extends baseFEPage;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\CardGlowBronze.PNG	GROUP=Icons	Name=CardGlowBronze COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\CardGlowGold.PNG	GROUP=Icons	Name=CardGlowGold COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\CardGlowGoldBig.PNG	GROUP=Icons	Name=CardGlowGoldBig COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\CardGlowSilver.PNG	GROUP=Icons	Name=CardGlowSilver COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMissingBigTexture.PNG	GROUP=Icons	Name=WizCardMissingBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMissingSmallTexture.PNG	GROUP=Icons	Name=WizCardMissingSmallTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

const nCARDGLOW_BIG_OFFSET_Y= -64;
const nCARDGLOW_BIG_OFFSET_X= -64;
const nCARDGLOW_OFFSET_Y= -34;
const nCARDGLOW_OFFSET_X= -34;
const strPAGE4= "41 - 50";
const strPAGE3= "31 - 40";
const strPAGE2= "21 - 30";
const strPAGE1= "11 - 20";
const strPAGE0= "1 - 10";
const fVACANT_SMALL_CARD_SCALE= -0.53125;
const fSMALL_CARD_SCALE= -0.765625;
const fHARRY_CARD_SCALE= -0.5;
const nWIZARD_TEXT_H= 80;
const nWIZARD_TEXT_Y= 400;
const nWIZARD_TEXT_X= 0;
const nSTATUS_BAR_Y= 374;
const nLARGE_CARD_Y= 4;
const nLARGE_CARD_X= 192;
const nNUM_PAGES_GOLD= 1;
const nNUM_PAGES_SILVER= 4;
const nNUM_PAGES_BRONZE= 5;
const nCARDS_PER_SET= 10;
var enum ECardGroup 
{
  CardGroup_Bronze,
  CardGroup_Silver,
  CardGroup_Gold
} CurrCardGroup;

var int HarrysGold[11];
var int HarrysSilver[40];
var int HarrysBronze[50];
var int nHarrysGoldCount;
var int nHarrysSilverCount;
var int nHarrysBronzeCount;
var harry PlayerHarry;
var Color colorBronze;
var Color colorSilver;
var Color colorGold;
var HGameButton HarryCardBmp;
var HGameButton SmallCardBmp[10];
var HGameButton HilitedCard;
var float fHilitedCardScale;
var HGameButton ForwardButton;
var HGameButton BackButton;
var HGameLabelControl PreviousPageLabel;
var HGameLabelControl NextPageLabel;
var HGameButton BronzeButton;
var HGameButton SilverButton;
var HGameButton GoldButton;
var Texture textureDescBkgrd;
var Texture textureRightUp;
var Texture textureRightOver;
var Texture textureLeftUp;
var Texture textureLeftOver;
var Texture textureBronzeNormal;
var Texture textureBronzeHilite;
var Texture textureBronzeWet;
var Texture textureSilverNormal;
var Texture textureSilverHilite;
var Texture textureSilverWet;
var Texture textureGoldNormal;
var Texture textureGoldHilite;
var Texture textureGoldWet;
var Texture textureSilverKey;
var Texture textureBronzeHealth;
var Texture textureCurrLargeCard;
var Class<WizardCardIcon> classCurWC;
var string strCardCountBronze;
var string strCardCountSilver;
var string strCardCountGold;
var int nBronzeHealthBars;
var int nSilverKeys;
var int nCurrPage;
var int nCurrItemOnPage;
var int nCurrNumPages;
var string strCurrDesc;
var int nCardGlowLeft;
var int nCardGlowTop;
var Texture textureCurrGlow;

//specific card glow textures and empty wizard card textures -AdamJD
var Texture textureBronzeGlow;
var Texture textureSilverGlow;
var Texture textureGoldGlow;
var Texture textureGoldBigGlow;
var Texture textureBigEmptyCard;
var Texture textureSmallEmptyCard;


function Created()
{
	local int I;
	
	textureDescBkgrd 		= Texture(DynamicLoadObject("HGame.Icons.leftPanel",Class'Texture'));
	textureBronzeNormal 	= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioBronzeNormal",Class'Texture'));
	textureBronzeHilite 	= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioBronzeHilite",Class'Texture'));
	textureBronzeWet 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioBronzeWet",Class'WetTexture'));
	textureSilverNormal 	= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioSilverNormal",Class'Texture'));
	textureSilverHilite 	= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioSilverHilite",Class'Texture'));
	textureSilverWet 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioSilverWet",Class'WetTexture'));
	textureGoldNormal 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioGoldNormal",Class'Texture'));
	textureGoldHilite 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioGoldHilite",Class'Texture'));
	textureGoldWet 			= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioGoldWet",Class'WetTexture'));
	textureRightUp 			= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioRightOver",Class'Texture'));
	textureRightOver 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioRightOver",Class'Texture'));
	textureLeftUp 			= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioLeftOver",Class'Texture'));
	textureLeftOver 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioLeftOver",Class'Texture'));
	textureSilverKey 		= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2SilverCardKey",Class'Texture'));
	textureBronzeHealth 	= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2FolioBronzeHealth",Class'Texture'));
  
	HarryCardBmp = HGameButton(CreateAlignedControl(Class'HGameButton',480.0,50.0,128.0,128.0,,AT_Center));
	HarryCardBmp.Register(self);
	HarryCardBmp.bDisabled = True;
	HarryCardBmp.bStretched = True;
	
	//AdamJD(2023):	Correct the Harry card image in widescreen
	HarryCardBmp.WW = 128.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	HarryCardBmp.WH = 128.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
  
  
	SmallCardBmp[0] = HGameButton(CreateWindow(Class'HGameButton',5.0,254,60.0,60.0));
	SmallCardBmp[1] = HGameButton(CreateWindow(Class'HGameButton',68.0,254.0,60.0,60.0));
	SmallCardBmp[2] = HGameButton(CreateWindow(Class'HGameButton',131.0,254.0,60.0,60.0));
	SmallCardBmp[3] = HGameButton(CreateWindow(Class'HGameButton',194.0,254.0,60.0,60.0));
	SmallCardBmp[4] = HGameButton(CreateWindow(Class'HGameButton',257.0,254.0,60.0,60.0));
	SmallCardBmp[5] = HGameButton(CreateWindow(Class'HGameButton',320.0,254.0,60.0,60.0));
	SmallCardBmp[6] = HGameButton(CreateWindow(Class'HGameButton',383.0,254.0,60.0,60.0));
	SmallCardBmp[7] = HGameButton(CreateWindow(Class'HGameButton',446.0,254.0,60.0,60.0));
	SmallCardBmp[8] = HGameButton(CreateWindow(Class'HGameButton',509.0,254.0,60.0,60.0));
	SmallCardBmp[9] = HGameButton(CreateWindow(Class'HGameButton',572.0,254.0,60.0,60.0));
	for(I = 0; I !=10; ++I)
	{
		SmallCardBmp[I].Register(self);
		SmallCardBmp[I].bStretched = True;
		
		// Omega: Set up an alignment for it:
		SmallCardBmp[I].AlignmentType = AT_Center;
		SmallCardBmp[I].Resized();
	
		// Metallicafan212:	Correct the card images
		SmallCardBmp[i].WW = 60.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
		SmallCardBmp[i].WH = 60.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	}
	GoldButton = HGameButton(CreateAlignedControl(Class'HGameButton',12.0,70.0,50.0,48.0,,AT_Left));
	GoldButton.Register(self);
	GoldButton.UpTexture = textureGoldNormal;
	GoldButton.DownTexture = textureGoldNormal;
	GoldButton.OverTexture = textureGoldNormal;
	GoldButton.ToolTipString = GetLocalFEString("Folio_Menu_0003");
	GoldButton.DownSound = Sound'GUI_Esc_Click3';
	
	SilverButton = HGameButton(CreateAlignedControl(Class'HGameButton',12.0,125.0,50.0,48.0,,AT_Left));
	SilverButton.Register(self);
	SilverButton.UpTexture = textureSilverNormal;
	SilverButton.DownTexture = textureSilverNormal;
	SilverButton.OverTexture = textureSilverNormal;
	SilverButton.ToolTipString = GetLocalFEString("Folio_Menu_0004");
	SilverButton.DownSound = Sound'GUI_Esc_Click3';
  
	BronzeButton = HGameButton(CreateAlignedControl(Class'HGameButton',12.0,180.0,50.0,48.0,,AT_Left));
	BronzeButton.Register(self);
	BronzeButton.UpTexture = textureBronzeNormal;
	BronzeButton.DownTexture = textureBronzeNormal;
	BronzeButton.OverTexture = textureBronzeNormal;
	BronzeButton.ToolTipString = GetLocalFEString("Folio_Menu_0005");
	BronzeButton.DownSound = Sound'GUI_Esc_Click3';
  
	ForwardButton = HGameButton(CreateAlignedControl(Class'HGameButton',605.0,316.0,32.0,32.0,,AT_Right));
	ForwardButton.Register(self);
	ForwardButton.UpTexture = textureRightUp;
	ForwardButton.DownTexture = textureRightUp;
	ForwardButton.OverTexture = textureRightUp;
	ForwardButton.ToolTipString = GetLocalFEString("Folio_Menu_0001");
  
	BackButton = HGameButton(CreateAlignedControl(Class'HGameButton',5.0,316.0,32.0,32.0,,AT_Left));
	BackButton.Register(self);
	BackButton.UpTexture = textureLeftUp;
	BackButton.DownTexture = textureLeftUp;
	BackButton.OverTexture = textureLeftUp;
	BackButton.ToolTipString = GetLocalFEString("Folio_Menu_0002");
  
	NextPageLabel = HGameLabelControl(CreateAlignedControl(Class'HGameLabelControl',605.0 - 100 - 5,316.0 + 5,100.0,28.0,,AT_Right));
	NextPageLabel.SetFont(4);
	NextPageLabel.TextColor.R = 255;
	NextPageLabel.TextColor.G = 255;
	NextPageLabel.TextColor.B = 255;
  
	NextPageLabel.Align = TA_Right; //from UWindowBase.uc in the proto -AdamJD 
	NextPageLabel.bShadowText = True;
	PreviousPageLabel = HGameLabelControl(CreateAlignedControl(Class'HGameLabelControl',5.0 + 32 + 5,316.0 + 5,100.0,28.0,,AT_Left));
	PreviousPageLabel.SetFont(4);
	PreviousPageLabel.TextColor.R = 255;
	PreviousPageLabel.TextColor.G = 255;
	PreviousPageLabel.TextColor.B = 255;
  
	// PreviousPageLabel.Align = 0;
	PreviousPageLabel.Align = TA_Left; //from UWindowBase.uc in the proto -AdamJD 
	PreviousPageLabel.bShadowText = True;
	CreateBackPageButton(594,350);
	Super.Created();
}

function SetCardCountData()
{
	local HGameLabelControl LabelControl;

	strCardCountBronze = string(nHarrysBronzeCount) $ "/" $ string(ArrayCount(HarrysBronze));
	nBronzeHealthBars = nHarrysBronzeCount / nCARDS_PER_SET;
	strCardCountSilver = string(nHarrysSilverCount) $ "/" $ string(ArrayCount(HarrysSilver));
	nSilverKeys = nHarrysSilverCount / nCARDS_PER_SET;
	strCardCountGold = string(nHarrysGoldCount) $ "/" $ string(ArrayCount(HarrysGold));
}

function ShowWindow()
{
	UpdateDisplayDetails();
	Super.ShowWindow();
}

function PreOpenBook()
{
  	ShowWindow();
}

function SetLargeCardProps (Class<WizardCardIcon> classWC)
{
	local string strDescId;

	classCurWC = classWC;
	textureCurrLargeCard = classWC.Default.textureBig;
	strDescId = classWC.Default.strDescriptionId;
	if ( strDescId == "" )
	{
		strCurrDesc = "";
	}
	else
	{
		strCurrDesc = GetLocalFEString(strDescId);
	}
}

function UpdateDisplayDetails()
{
	UpdatePreviousNextButtons();
	UpdatePageCards();
	UpdateGroupButtonTextures();
}

function UpdatePreviousNextButtons()
{
	BackButton.bDisabled = nCurrPage == 0;
	if ( CurrCardGroup == CardGroup_Gold )
	{
		ForwardButton.bDisabled = True;
	} 
	else 
	{
		ForwardButton.bDisabled = nCurrPage == (nCurrNumPages - 1);
	}
	if ( BackButton.bDisabled == True )
	{
		BackButton.HideWindow();
	} 
	else 
	{
		BackButton.ShowWindow();
	}
	if ( ForwardButton.bDisabled == True )
	{
		ForwardButton.HideWindow();
	} 
	else 
	{
		ForwardButton.ShowWindow();
	}
	switch (nCurrPage)
	{
		case 0:
			PreviousPageLabel.SetText("");
			if ( CurrCardGroup == CardGroup_Gold )
			{
				NextPageLabel.SetText("");
			} 
			else 
			{
				NextPageLabel.SetText(strPAGE1);
			}
			break;
		case 1:
			PreviousPageLabel.SetText(strPAGE0);
			if ( CurrCardGroup == CardGroup_Gold )
			{
				NextPageLabel.SetText("");
			} 
			else 
			{
				NextPageLabel.SetText(strPAGE2);
			}
			break;
		case 2:
			PreviousPageLabel.SetText(strPAGE1);
			if ( CurrCardGroup == CardGroup_Gold )
			{
				NextPageLabel.SetText("");
			} 
			else 
			{
				NextPageLabel.SetText(strPAGE3);
			}
			break;
		case 3:
			PreviousPageLabel.SetText(strPAGE2);
			if ( CurrCardGroup == CardGroup_Bronze )
			{
				NextPageLabel.SetText(strPAGE4);
			} 
			else 
			{
				NextPageLabel.SetText("");
			}
			break;
		case 4:
			PreviousPageLabel.SetText(strPAGE3);
			NextPageLabel.SetText("");
			break;
		default:
			PreviousPageLabel.SetText("");
			NextPageLabel.SetText("");
			break;
	}
	
	// Omega: Hack to fix the elements breaking on page change
	ResolutionChanged(Root.RealWidth, Root.RealHeight);
}

function UpdatePageCards()
{
	local int I;
	local StatusGroupWizardCards sgCards;
	local StatusItemWizardCards siCards;
	local Class<Actor> classWC;
	local int nCardId;
	local int nCardIdx;

	sgCards = StatusGroupWizardCards(PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
	switch (CurrCardGroup)
	{
		case CardGroup_Bronze:
			siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
			break;
		case CardGroup_Silver:
			siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
			break;
		case CardGroup_Gold:
			siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemGoldCards'));
			break;
		default:
			Log("ERROR: Invalid card group in FEFoliPage " $ string(CurrCardGroup));
			break;
	}
	textureCurrLargeCard = textureBigEmptyCard;	 //Texture'WizCardMissingBigTexture';
	classCurWC = None;
	strCurrDesc = "";

	for(I = 0; I < ArrayCount(SmallCardBmp); I++)
	{
		nCardIdx = I + (nCurrPage * ArrayCount(SmallCardBmp));
		if ( CurrCardGroup == CardGroup_Bronze )
		{
			nCardId = HarrysBronze[nCardIdx];
		} 
		else
		if ( CurrCardGroup == CardGroup_Silver )
		{
			nCardId = HarrysSilver[nCardIdx];
		} 
		else 
		{
			nCardId = HarrysGold[nCardIdx];
		}
		
		if ( nCardId != 0 )
		{
			classWC = siCards.GetCardClassFromId(nCardId);
			if ( classWC != Class'WCPotter' )
			{
				SmallCardBmp[I].UpTexture = Class<WizardCardIcon>(classWC).Default.textureBig;
				if ( I == nCurrItemOnPage )
				{
					SetLargeCardProps(Class<WizardCardIcon>(classWC));
				}
			} 
			else 
			{
				SmallCardBmp[I].UpTexture = textureSmallEmptyCard; 		//Texture'WizCardMissingSmallTexture';
			}
		}
		else 
		{
			SmallCardBmp[I].UpTexture = textureSmallEmptyCard;		//Texture'WizCardMissingSmallTexture';
		}

		SmallCardBmp[I].DownTexture = SmallCardBmp[I].UpTexture;
		SmallCardBmp[I].OverTexture = SmallCardBmp[I].UpTexture;
	}
	if ( CurrCardGroup == CardGroup_Gold )
	{
		classWC = Class'WCPotter';
		if ( siCards.IsOwnedByHarry(Class<WizardCardIcon>(classWC).Default.Id) )
		{
			HarryCardBmp.ShowWindow();
			HarryCardBmp.bDisabled = False;
			HarryCardBmp.UpTexture = Class<WizardCardIcon>(classWC).Default.textureBig;
			HarryCardBmp.DownTexture = HarryCardBmp.UpTexture;
			HarryCardBmp.OverTexture = HarryCardBmp.UpTexture;
			if ( nCurrItemOnPage == ArrayCount(SmallCardBmp) )
			{
				SetLargeCardProps(Class<WizardCardIcon>(classWC));
			}
		} 
		else 
		{
			HarryCardBmp.HideWindow();
			HarryCardBmp.bDisabled = True;
		}
	} 
	else 
	{
		HarryCardBmp.HideWindow();
		HarryCardBmp.bDisabled = True;
	}
	HiliteCurrCard();
}

function UpdateGroupButtonTextures()
{
	switch (CurrCardGroup)
	{
		case CardGroup_Bronze:
			GoldButton.UpTexture = textureGoldNormal;
			GoldButton.DownTexture = textureGoldNormal;
			GoldButton.OverTexture = textureGoldNormal;
			SilverButton.UpTexture = textureSilverNormal;
			SilverButton.DownTexture = textureSilverNormal;
			SilverButton.OverTexture = textureSilverNormal;
			BronzeButton.UpTexture = textureBronzeHilite;
			BronzeButton.DownTexture = textureBronzeHilite;
			BronzeButton.OverTexture = textureBronzeHilite;
			break;
		case CardGroup_Silver:
			GoldButton.UpTexture = textureGoldNormal;
			GoldButton.DownTexture = textureGoldNormal;
			GoldButton.OverTexture = textureGoldNormal;
			SilverButton.UpTexture = textureSilverHilite;
			SilverButton.DownTexture = textureSilverHilite;
			SilverButton.OverTexture = textureSilverHilite;
			BronzeButton.UpTexture = textureBronzeNormal;
			BronzeButton.DownTexture = textureBronzeNormal;
			BronzeButton.OverTexture = textureBronzeNormal;
			break;
		case CardGroup_Gold:
			GoldButton.UpTexture = textureGoldHilite;
			GoldButton.DownTexture = textureGoldHilite;
			GoldButton.OverTexture = textureGoldHilite;
			SilverButton.UpTexture = textureSilverNormal;
			SilverButton.DownTexture = textureSilverNormal;
			SilverButton.OverTexture = textureSilverNormal;
			BronzeButton.UpTexture = textureBronzeNormal;
			BronzeButton.DownTexture = textureBronzeNormal;
			BronzeButton.OverTexture = textureBronzeNormal;
			break;
		default:
			break;
	}
}

function Notify (UWindowDialogControl C, byte E)
{
	local int I;

	if ( E == DE_Click )
	{
		switch (C)
		{
			case ForwardButton:
				if ( nCurrPage < nCurrNumPages - 1 )
				{
					++nCurrPage;
					UpdateDisplayDetails();
				}
				break;
			case BackButton:
				if ( nCurrPage > 0 )
				{
					--nCurrPage;
					UpdateDisplayDetails();
				}
				break;
			case BronzeButton:
				if ( CurrCardGroup != CardGroup_Bronze )
				{
					CurrCardGroup = CardGroup_Bronze;
					nCurrPage = 0;
					nCurrItemOnPage = 0;
					nCurrNumPages = nNUM_PAGES_BRONZE;
					UpdateDisplayDetails();
				}
				break;
			case SilverButton:
				if ( CurrCardGroup != CardGroup_Silver )
				{
					CurrCardGroup = CardGroup_Silver;
					nCurrPage = 0;
					nCurrItemOnPage = 0;
					nCurrNumPages = nNUM_PAGES_SILVER;
					UpdateDisplayDetails();
				}
				break;
			case GoldButton:
				if ( CurrCardGroup != CardGroup_Gold )
				{
					CurrCardGroup = CardGroup_Gold;
					nCurrPage = 0;
					nCurrItemOnPage = 0;
					nCurrNumPages = nNUM_PAGES_GOLD;
					UpdateDisplayDetails();
				}
				break;
			case HarryCardBmp:
				nCurrItemOnPage = ArrayCount(SmallCardBmp);
				UpdateDisplayDetails();
				break;
				case BackPageButton:
				FEBook(book).DoEscapeFromPage();
				break;
			default:
				for(I = 0; I != ArrayCount(SmallCardBmp); ++I)
				{
					if ( SmallCardBmp[I] == C )
					{
					nCurrItemOnPage = I;
					UpdateDisplayDetails();
					break;
					}
				}
				break;
		}
	} 
	else
		if ( E == DE_MouseEnter )
		{
			switch (C)
			{
				case ForwardButton:
					SetRollover(ForwardButton,textureRightOver,None,False);
					break;
				case BackButton:
					SetRollover(BackButton,textureLeftOver,None,False);
					break;
				case GoldButton:
					SetRollover(GoldButton,textureGoldWet,Sound'GUI_Esc_Rollover1',True);
					break;
				case SilverButton:
					SetRollover(SilverButton,textureSilverWet,Sound'GUI_Esc_Rollover1',True);
					break;
				case BronzeButton:
					SetRollover(BronzeButton,textureBronzeWet,Sound'GUI_Esc_Rollover1',True);
					break;
				default:
			}
		}
		else
		if ( E == DE_MouseLeave )
		{
			switch (C)
			{
				case ForwardButton:
				case BackButton:
				case GoldButton:
				case SilverButton:
				case BronzeButton:
					ClearRollover();
					break;
				default:
			}
		}
	Super.Notify(C,E);
}

function float GetDHeightScale()
{
	return Class'M212HScale'.Static.UWindowGetHeightScale(Root) * Class'M212HScale'.Static.UWindowGetHeightScale(Root);
}

function RepositionChildControls()
{
	local int i;
	
	Super.RepositionChildControls();
	
	// Metallicafan212:	Readjust the pos of the current highlight
	HiliteCurrCard();
	
	// Metallicafan212:	Correct the card images
	for(I = 0; I < ArrayCount(SmallCardBmp); I++)
	{
		SmallCardBmp[i].WW = 60.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
		SmallCardBmp[i].WH = 60.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	}
	
	//AdamJD(2023):	Correct the Harry card image in widescreen
	HarryCardBmp.WW = 128.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	HarryCardBmp.WH = 128.0 / Class'M212HScale'.Static.UWindowGetHeightScale(Root);
}

function HiliteCurrCard()
{
	if ( nCurrItemOnPage < ArrayCount(SmallCardBmp) )
	{
		nCardGlowLeft = SmallCardBmp[nCurrItemOnPage].WinLeft + (nCARDGLOW_OFFSET_X * Class'M212HScale'.Static.UWindowGetHeightScale(Root));
		nCardGlowTop = SmallCardBmp[nCurrItemOnPage].WinTop + (nCARDGLOW_OFFSET_Y * Class'M212HScale'.Static.UWindowGetHeightScale(Root));;

		switch (CurrCardGroup)
		{
			case CardGroup_Bronze:
				textureCurrGlow = textureBronzeGlow;
				break;
			
			case CardGroup_Silver:
				textureCurrGlow = textureSilverGlow;
				break;
      
			case CardGroup_Gold:
				textureCurrGlow = textureGoldGlow;
				break;
		}
    
		HilitedCard = SmallCardBmp[nCurrItemOnPage];
		if ( SmallCardBmp[nCurrItemOnPage].UpTexture == textureSmallEmptyCard )
		{
			fHilitedCardScale = fVACANT_SMALL_CARD_SCALE;
		} 
		else 
		{
			fHilitedCardScale = fSMALL_CARD_SCALE;
		}
	} 
	else 
	{
		nCardGlowLeft 		= HarryCardBmp.WinLeft + (nCARDGLOW_BIG_OFFSET_X * Class'M212HScale'.Static.UWindowGetHeightScale(Root));
		nCardGlowTop 		= HarryCardBmp.WinTop + (nCARDGLOW_BIG_OFFSET_Y * Class'M212HScale'.Static.UWindowGetHeightScale(Root));
		textureCurrGlow 	= textureGoldBigGlow;
		HilitedCard 		= HarryCardBmp;
		fHilitedCardScale 	= fHARRY_CARD_SCALE;
	}
}

function AfterPaint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;

	Super.AfterPaint(Canvas,X,Y);
	fScaleFactor = (Canvas.SizeX / WinWidth) * Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	PaintLargeCard(Canvas,fScaleFactor);
	PaintWizardText(Canvas,fScaleFactor);
	PaintCardStatData(Canvas,fScaleFactor);
	HiliteSelectedCard(Canvas);
}

function BeforePaint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;
	local int nStyleSave;

	Super.BeforePaint(Canvas,X,Y);
	fScaleFactor 	= Canvas.SizeX / WinWidth;
	nStyleSave 		= Canvas.Style;
	Canvas.Style 	= 3;
	
	// Metallicafan212:	Move it down
	Canvas.SetPos(nCardGlowLeft * fScaleFactor, (nCardGlowTop * fScaleFactor));
	Canvas.DrawIcon(textureCurrGlow, fScaleFactor * Class'M212HScale'.Static.UWindowGetHeightScale(Root));
	Canvas.Style 	= nStyleSave;
}

function HiliteSelectedCard (Canvas Canvas)
{
	local float fScaleFactor;
	local int nSaveStyle;
	if ( HilitedCard != None )
	{
		fScaleFactor 	= (Canvas.SizeX / WinWidth);
		nSaveStyle 		= Canvas.Style;
		
		Canvas.Style 	= 3;
		Canvas.SetPos(HilitedCard.WinLeft * fScaleFactor, HilitedCard.WinTop * fScaleFactor);
		
		Canvas.DrawIcon(HilitedCard.OverTexture, (fScaleFactor + fHilitedCardScale * fScaleFactor) * Class'M212HScale'.Static.UWindowGetHeightScale(Root) );
		Canvas.Style 	= nSaveStyle;
	}
}

function PaintLargeCard (Canvas Canvas, float fScaleFactor)
{
	local int nLargeCardX;
	local int nLargeCardY;
	local float MouseX;
	local float MouseY;
	local float offX;
	local float offY;

	if ( Canvas.SizeX > WinWidth )
	{
		nLargeCardX = Canvas.SizeX / 2 - textureCurrLargeCard.USize / 2;
		nLargeCardY = nLARGE_CARD_Y + ((textureCurrLargeCard.VSize * fScaleFactor - textureCurrLargeCard.VSize) / 2);

		// Omega: 3D Card drawing:
		if ( (classCurWC != None) && classCurWC.Default.bIsLayered )
		{
			GetMouseXY(MouseX,MouseY);
			offX = (MouseX - (Canvas.SizeX / 2)) / (Canvas.SizeX / 2);
			offY = (MouseY - (Canvas.SizeY / 2)) / (Canvas.SizeY / 2);
			offX *= 6;
			offY *= 6;
			if ( classCurWC.Default.bLastLayerIsFire )
			{
				Canvas.SetPos(nLargeCardX,nLargeCardY);
			} 
			else 
			{
				Canvas.SetPos(nLargeCardX + (offX * 2),nLargeCardY + (offY * 2));
			}
			
			Canvas.DrawIcon(classCurWC.Default.textureLayers[2],1.0);
			Canvas.SetPos(nLargeCardX + offX * 1,nLargeCardY + (offY * 1));
			Canvas.DrawIcon(classCurWC.Default.textureLayers[1],1.0);
			Canvas.SetPos(nLargeCardX,nLargeCardY);
			Canvas.DrawIcon(classCurWC.Default.textureLayers[0],1.0);
		} 
		else 
		{
			Canvas.SetPos(nLargeCardX,nLargeCardY);
			Canvas.DrawIcon(textureCurrLargeCard,1.0);
		}
	} 
	else 
	{
		Canvas.SetPos(nLARGE_CARD_X * fScaleFactor,nLargeCardY * fScaleFactor);
		Canvas.DrawIcon(textureCurrLargeCard,fScaleFactor);
	}
}

function PaintWizardText (Canvas Canvas, float fScaleFactor)
{
	local Color colorText;
	local Font fontText;

	switch (CurrCardGroup)
	{
		case CardGroup_Bronze:
			colorText = colorBronze;
			break;
		case CardGroup_Silver:
			colorText = colorSilver;
			break;
		case CardGroup_Gold:
			colorText = colorGold;
			break;
		default:
			break;
	}
	Canvas.SetPos(nWIZARD_TEXT_X,nWIZARD_TEXT_Y * fScaleFactor);
	Canvas.DrawTile(textureDescBkgrd,Canvas.SizeX,80.0 * fScaleFactor,0.0,0.0,1.0,1.0);
	if ( Canvas.SizeX <= 512 )
	{
		fontText = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
	} 
	else 
	{
		fontText = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
	}
	HPHud(PlayerHarry.myHUD).DrawCutStyleText(Canvas,strCurrDesc,0,nWIZARD_TEXT_Y * fScaleFactor, nWIZARD_TEXT_H * fScaleFactor, colorText,fontText);
}

function PaintCardStatData (Canvas Canvas, float fCanvasScaleFactor)
{
	local Font fontSave;
	local int nXPos;
	local int nYPos;
	local float fXTextLen;
	local float fYTextLen;
	local int I;
	local float fWindowScaleFactor;
	local Color colorOffWhite;
	local Color colorBlack;
  
	// Metallicafan212:	Height scaling
	local float HScale;
	
	local float fHWindowScaleFactor, FourByThreeDiv;
	
	// Metallicafan212:	Cache this stupid value
	local float Over;

	
	HScale = Class'M212HScale'.Static.CanvasGetHeightScale(Canvas);

	fontSave = Canvas.Font;
	fWindowScaleFactor = Canvas.SizeX / WinWidth;
	
	fHWindowScaleFactor = fWindowScaleFactor * HScale;

	FourByThreeDiv = HUDScaledHScale();
	
	Over = fHWindowScaleFactor * 40;
	
	colorBlack.R = 0;
	colorBlack.G = 0;
	colorBlack.B = 0;
	colorOffWhite.R = 206;
	colorOffWhite.G = 200;
	colorOffWhite.B = 190;
	
	if ( Canvas.SizeX <= 512 )
	{
		Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
	} 
	else if ( Canvas.SizeX <= 640 )
	{
		Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
    } 
	else 
	{
		Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalBigFont;
    }
  
	// Metallicafan212:	Gold count
	Canvas.TextSize(strCardCountGold, fXTextLen, fYTextLen);
	Canvas.SetPos(GoldButton.WinLeft * fWindowScaleFactor + Over - fXTextLen / 2, (GoldButton.WinTop * fWindowScaleFactor + Over - fYTextLen / 2));
	Canvas.DrawShadowText(strCardCountGold,colorOffWhite,colorBlack);
	
	// Metallicafan212:	Silver count
	Canvas.TextSize(strCardCountSilver, fXTextLen, fYTextLen);
	Canvas.SetPos(SilverButton.WinLeft * fWindowScaleFactor + Over - fXTextLen / 2, (SilverButton.WinTop * fWindowScaleFactor + Over - fYTextLen / 2));
	Canvas.DrawShadowText(strCardCountSilver,colorOffWhite,colorBlack);
	
	// Metallicafan212:	Bronze count
	Canvas.TextSize(strCardCountBronze, fXTextLen, fYTextLen);
	Canvas.SetPos(BronzeButton.WinLeft * fWindowScaleFactor + Over - fXTextLen / 2, (BronzeButton.WinTop * fWindowScaleFactor + Over - fYTextLen / 2));
	Canvas.DrawShadowText(strCardCountBronze,colorOffWhite,colorBlack);
	
	//nXPos = (BronzeButton.WinLeft + BronzeButton.WinWidth + 24) * fHWindowScaleFactor; 

	// Omega: Scale by the 4:3 div. This really isn't right but I'm not sure why the math is really wrong in the first place...
	nXPos = ((BronzeButton.WinLeft/FourByThreeDiv) + BronzeButton.WinWidth + (24 * FourByThreeDiv)) * fHWindowScaleFactor;
	//nYPos = BronzeButton.WinTop * fWindowScaleFactor * HScale;
	
	//AdamJD(2023):	Scale the health bars near the bronze card button in widescreen
	nYPos = (BronzeButton.WinTop / HScale) * fHWindowScaleFactor;
	
	for(I = 0; I < nBronzeHealthBars; i++)
	{
		Canvas.SetPos(nXPos,nYPos);
		Canvas.DrawIcon(textureBronzeHealth, fHWindowScaleFactor);
		nXPos += 14 * fHWindowScaleFactor;
	}
	
	//nXPos = (SilverButton.WinLeft + SilverButton.WinWidth + 24) * fHWindowScaleFactor;

	// Omega: Scale by the 4:3 div
	nXPos = ((SilverButton.WinLeft/FourByThreeDiv) + SilverButton.WinWidth + (24 * FourByThreeDiv)) * fHWindowScaleFactor;
	//nYPos = SilverButton.WinTop * fWindowScaleFactor * HScale;
	
	//AdamJD(2023):	Scale the keys near the silver card button in widescreen
	nYPos = (SilverButton.WinTop / HScale) * fHWindowScaleFactor;
	
	for(I = 0; I < nSilverKeys; I++)
	{
		Canvas.SetPos(nXPos,nYPos);
		Canvas.DrawIcon(textureSilverKey, fHWindowScaleFactor - 0.31);
		nXPos += 28 * (fHWindowScaleFactor - 0.3);
	}
	
	Canvas.Font = fontSave;
}

function int GetStatusY()
{
	local float HScale;
	// Omega: Scale the GetStatusY function
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	return nSTATUS_BAR_Y * HScale;
}

function PreSwitchPage()
{
	PlayerHarry = harry(Root.Console.Viewport.Actor);
	InitHarryOwnedCards();
	SetCardCountData();
	SetInitialSelection();
	Super.PreSwitchPage();
}

function InitHarryOwnedCards()
{
	local int I;
	local int J;
	local int nCardId;
	local StatusGroupWizardCards sgCards;
	local StatusItemWizardCards siCards;

	sgCards = StatusGroupWizardCards(PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
	
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemGoldCards'));
	StatusItemGoldCards(siCards).MoveHarryCardToEnd();
	nHarrysGoldCount = 0;
	for(I = 0; I < ArrayCount(HarrysGold); I++)
	{
		nCardId = siCards.GetCardId(I);
		if ( nCardId > 0 )
		{
			if ( siCards.IsOwnedByHarry(nCardId) )
			{
				HarrysGold[nHarrysGoldCount] = nCardId;
				nHarrysGoldCount++;
			}
		}
	}
	for(I = nHarrysGoldCount; I < ArrayCount(HarrysGold); I++)
	{
		HarrysGold[I] = 0;
	}
	
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
	nHarrysSilverCount = 0;
	for(I = 0; I < ArrayCount(HarrysSilver); I++)
	{
		nCardId = siCards.GetCardId(I);
		if ( nCardId > 0 )
		{
			if ( siCards.IsOwnedByHarry(nCardId) == True )
			{
				HarrysSilver[nHarrysSilverCount] = nCardId;
				nHarrysSilverCount++;
			}
		}
	}
	for(I = nHarrysSilverCount; I < ArrayCount(HarrysSilver); I++)
	{
		HarrysSilver[I] = 0;
	}
	
	siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
	nHarrysBronzeCount = 0;
	for(I = 0; I < ArrayCount(HarrysBronze); I++)
	{
		nCardId = siCards.GetCardId(I);
		if ( nCardId > 0 )
		{
			if ( siCards.IsOwnedByHarry(nCardId) == True )
			{
				HarrysBronze[nHarrysBronzeCount] = nCardId;
				nHarrysBronzeCount++;
			}
		}
		else
		{
			I++;
		}
	}
	for(I = nHarrysBronzeCount; I < ArrayCount(HarrysBronze); I++)
	{
		HarrysBronze[I] = 0;
	}
}

function SetInitialSelection()
{
	local StatusGroupWizardCards sgCards;
	local StatusItemWizardCards siCards;
	local int nNumSmallPerPage;
	local int nCardCount;
	
	sgCards = StatusGroupWizardCards(PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
	
	switch (sgCards.GetLastObtainedCardType())
	{
		case sgCards.ECardType.CardType_Gold:
			CurrCardGroup = CardGroup_Gold;
			nCardCount = nHarrysGoldCount;
			nCurrNumPages = 1;
			break;
		case sgCards.ECardType.CardType_Silver:
			CurrCardGroup = CardGroup_Silver;
			nCardCount = nHarrysSilverCount;
			nCurrNumPages = 4;
			break;
		case sgCards.ECardType.CardType_Bronze:
			CurrCardGroup = CardGroup_Bronze;
			nCardCount = nHarrysBronzeCount;
			nCurrNumPages = 5;
			break;
		case sgCards.ECardType.CardType_None:
			CurrCardGroup = CardGroup_Bronze;
			nCardCount = nHarrysBronzeCount;
			nCurrNumPages = 5;
			break;
	}
	
	nNumSmallPerPage = ArrayCount(SmallCardBmp);
  
	if ( CurrCardGroup == CardGroup_Gold )
	{
		nCurrPage = 0;
	} 
	else if ( nCardCount <= 1 * nCARDS_PER_SET )
	{
		nCurrPage = 0;
	} else if ( nCardCount <= 2 * nCARDS_PER_SET )
	{
		nCurrPage = 1;
	} 
	else if ( nCardCount <= 3 * nCARDS_PER_SET )
	{
		nCurrPage = 2;
	} 
	else if ( nCardCount <= 4 * nCARDS_PER_SET )
	{
		nCurrPage = 3;
	} 
	else if ( nCardCount <= 5 * nCARDS_PER_SET )
	{
		nCurrPage = 4;
	}
	
	if ( nCardCount == 0 )
	{
		nCurrItemOnPage = 0;
	} 
	else 
	{
		if ( CurrCardGroup == CardGroup_Gold )
		{
			siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemGoldCards'));
			if ( StatusItemGoldCards(siCards).HaveHarryCard() )
			{
				nCurrItemOnPage = ArrayCount(SmallCardBmp) + 1;
			} 
			else 
			{
				nCurrItemOnPage = nCardCount - 1;
			}
		} 
		else 
		{
			if ( nCardCount % nNumSmallPerPage == 0 )
			{
				nCurrItemOnPage = nNumSmallPerPage - 1;
			} 
			else 
			{
				nCurrItemOnPage = nCardCount % nNumSmallPerPage - 1;
				return;
			}
		}
	}
}

defaultproperties
{
    colorBronze=(R=132,G=64,B=44,A=0)

    colorSilver=(R=115,G=123,B=140,A=0)

    colorGold=(R=181,G=115,B=0,A=0)

    nCurrNumPages=5
	
	//set the card glow textures and empty card textures -AdamJD
	//
	textureBronzeGlow=CardGlowBronze
	
	textureSilverGlow=CardGlowSilver
	
	textureGoldGlow=CardGlowGold
	
	textureGoldBigGlow=CardGlowGoldBig
	
	textureBigEmptyCard=WizCardMissingBigTexture
	
	textureSmallEmptyCard=WizCardMissingSmallTexture
}
