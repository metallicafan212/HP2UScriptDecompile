//================================================================================
// FEFolioPage.
//================================================================================

class FEFolioPage extends baseFEPage;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\CardGlowBronze.PNG	GROUP=Icons	Name=CardGlowBronze COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\CardGlowGold.PNG	GROUP=Icons	Name=CardGlowGold COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\CardGlowGoldBig.PNG	GROUP=Icons	Name=CardGlowGoldBig COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\CardGlowSilver.PNG	GROUP=Icons	Name=CardGlowSilver COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\WizCardMissingBigTexture.PNG	GROUP=Icons	Name=WizCardMissingBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\WizCardMissingSmallTexture.PNG	GROUP=Icons	Name=WizCardMissingSmallTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914

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
enum ECardGroup {
  CardGroup_Bronze,
  CardGroup_Silver,
  CardGroup_Gold
};

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
var ECardGroup CurrCardGroup;
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


function Created ()
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
  
	HarryCardBmp = HGameButton(CreateWindow(Class'HGameButton',480.0,50.0,128.0,128.0));
	HarryCardBmp.Register(self);
	HarryCardBmp.bDisabled = True;
	HarryCardBmp.bStretched = True;
  
  
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
	
		// Metallicafan212:	Correct the card images
		SmallCardBmp[i].WW = 60.0 / GetHeightScale();
		SmallCardBmp[i].WH = 60.0 / GetHeightScale();
	}
	GoldButton = HGameButton(CreateWindow(Class'HGameButton',12.0,70.0,50.0,48.0));
	GoldButton.Register(self);
	GoldButton.UpTexture = textureGoldNormal;
	GoldButton.DownTexture = textureGoldNormal;
	GoldButton.OverTexture = textureGoldNormal;
	GoldButton.ToolTipString = GetLocalFEString("Folio_Menu_0003");
	GoldButton.DownSound = Sound'GUI_Esc_Click3';
	
	SilverButton = HGameButton(CreateWindow(Class'HGameButton',12.0,125.0,50.0,48.0));
	SilverButton.Register(self);
	SilverButton.UpTexture = textureSilverNormal;
	SilverButton.DownTexture = textureSilverNormal;
	SilverButton.OverTexture = textureSilverNormal;
	SilverButton.ToolTipString = GetLocalFEString("Folio_Menu_0004");
	SilverButton.DownSound = Sound'GUI_Esc_Click3';
  
	BronzeButton = HGameButton(CreateWindow(Class'HGameButton',12.0,180.0,50.0,48.0));
	BronzeButton.Register(self);
	BronzeButton.UpTexture = textureBronzeNormal;
	BronzeButton.DownTexture = textureBronzeNormal;
	BronzeButton.OverTexture = textureBronzeNormal;
	BronzeButton.ToolTipString = GetLocalFEString("Folio_Menu_0005");
	BronzeButton.DownSound = Sound'GUI_Esc_Click3';
  
	ForwardButton = HGameButton(CreateWindow(Class'HGameButton',605.0,316.0,32.0,32.0));
	ForwardButton.Register(self);
	ForwardButton.UpTexture = textureRightUp;
	ForwardButton.DownTexture = textureRightUp;
	ForwardButton.OverTexture = textureRightUp;
	ForwardButton.ToolTipString = GetLocalFEString("Folio_Menu_0001");
  
	BackButton = HGameButton(CreateWindow(Class'HGameButton',5.0,316.0,32.0,32.0));
	BackButton.Register(self);
	BackButton.UpTexture = textureLeftUp;
	BackButton.DownTexture = textureLeftUp;
	BackButton.OverTexture = textureLeftUp;
	BackButton.ToolTipString = GetLocalFEString("Folio_Menu_0002");
  
	NextPageLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',605.0 - 100 - 5,316.0 + 5,100.0,28.0));
	NextPageLabel.SetFont(4);
	NextPageLabel.TextColor.R = 255;
	NextPageLabel.TextColor.G = 255;
	NextPageLabel.TextColor.B = 255;
  
	NextPageLabel.Align = TA_Right; //from UWindowBase.uc in the proto -AdamJD 
	NextPageLabel.bShadowText = True;
	PreviousPageLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',5.0 + 32 + 5,316.0 + 5,100.0,28.0));
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

function SetCardCountData ()
{
  local HGameLabelControl LabelControl;

  strCardCountBronze = string(nHarrysBronzeCount) $ "/" $ string(50);
  nBronzeHealthBars = nHarrysBronzeCount / 10;
  strCardCountSilver = string(nHarrysSilverCount) $ "/" $ string(40);
  nSilverKeys = nHarrysSilverCount / 10;
  strCardCountGold = string(nHarrysGoldCount) $ "/" $ string(11);
}

function ShowWindow ()
{
  UpdateDisplayDetails();
  Super.ShowWindow();
}

function PreOpenBook ()
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
  } else {
    strCurrDesc = GetLocalFEString(strDescId);
  }
}

function UpdateDisplayDetails ()
{
  UpdatePreviousNextButtons();
  UpdatePageCards();
  UpdateGroupButtonTextures();
}

function UpdatePreviousNextButtons ()
{
  BackButton.bDisabled = nCurrPage == 0;
  if ( CurrCardGroup == CardGroup_Gold )
  {
    ForwardButton.bDisabled = True;
  } else {
    ForwardButton.bDisabled = nCurrPage == nCurrNumPages - 1;
  }
  if ( BackButton.bDisabled == True )
  {
    BackButton.HideWindow();
  } else {
    BackButton.ShowWindow();
  }
  if ( ForwardButton.bDisabled == True )
  {
    ForwardButton.HideWindow();
  } else {
    ForwardButton.ShowWindow();
  }
  switch (nCurrPage)
  {
    case 0:
    PreviousPageLabel.SetText("");
    if ( CurrCardGroup == CardGroup_Gold )
    {
      NextPageLabel.SetText("");
    } else {
      NextPageLabel.SetText("11 - 20");
    }
    break;
    case 1:
    PreviousPageLabel.SetText("1 - 10");
    if ( CurrCardGroup == CardGroup_Gold )
    {
      NextPageLabel.SetText("");
    } else {
      NextPageLabel.SetText("21 - 30");
    }
    break;
    case 2:
    PreviousPageLabel.SetText("11 - 20");
    if ( CurrCardGroup == CardGroup_Gold )
    {
      NextPageLabel.SetText("");
    } else {
      NextPageLabel.SetText("31 - 40");
    }
    break;
    case 3:
    PreviousPageLabel.SetText("21 - 30");
    if ( CurrCardGroup == CardGroup_Bronze )
    {
      NextPageLabel.SetText("41 - 50");
    } else {
      NextPageLabel.SetText("");
    }
    break;
    case 4:
    PreviousPageLabel.SetText("31 - 40");
    NextPageLabel.SetText("");
    break;
    default:
    PreviousPageLabel.SetText("");
    NextPageLabel.SetText("");
    break;
  }
}

function UpdatePageCards ()
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
  // I = 0;
  // if ( I < 10 )
  for(I = 0; I < 10; I++)
  {
    nCardIdx = I + nCurrPage * 10;
    if ( CurrCardGroup == CardGroup_Bronze )
    {
      nCardId = HarrysBronze[nCardIdx];
    } else {
      if ( CurrCardGroup == CardGroup_Silver )
      {
        nCardId = HarrysSilver[nCardIdx];
      } else {
        nCardId = HarrysGold[nCardIdx];
      }
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
      } else {
        SmallCardBmp[I].UpTexture = textureSmallEmptyCard; 		//Texture'WizCardMissingSmallTexture';
      }
    } else {
      SmallCardBmp[I].UpTexture = textureSmallEmptyCard;		//Texture'WizCardMissingSmallTexture';
    }
    SmallCardBmp[I].DownTexture = SmallCardBmp[I].UpTexture;
    SmallCardBmp[I].OverTexture = SmallCardBmp[I].UpTexture;
    // I++;
    // goto JL00FF;
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
      if ( nCurrItemOnPage == 10 )
      {
        SetLargeCardProps(Class<WizardCardIcon>(classWC));
      }
    } else {
      HarryCardBmp.HideWindow();
      HarryCardBmp.bDisabled = True;
    }
  } else {
    HarryCardBmp.HideWindow();
    HarryCardBmp.bDisabled = True;
  }
  HiliteCurrCard();
}

function UpdateGroupButtonTextures ()
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

  if ( E == 2 )
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
        nCurrNumPages = 5;
        UpdateDisplayDetails();
      }
      break;
      case SilverButton:
      if ( CurrCardGroup != CardGroup_Silver )
      {
        CurrCardGroup = CardGroup_Silver;
        nCurrPage = 0;
        nCurrItemOnPage = 0;
        nCurrNumPages = 4;
        UpdateDisplayDetails();
      }
      break;
      case GoldButton:
      if ( CurrCardGroup != CardGroup_Gold )
      {
        CurrCardGroup = CardGroup_Gold;
        nCurrPage = 0;
        nCurrItemOnPage = 0;
        nCurrNumPages = 1;
        UpdateDisplayDetails();
      }
      break;
      case HarryCardBmp:
      nCurrItemOnPage = 10;
      UpdateDisplayDetails();
      break;
      case BackPageButton:
      FEBook(book).DoEscapeFromPage();
      break;
      default:
      // I = 0;
      // if ( I != 10 )
	  for(I = 0; I != 10; ++I)
      {
        if ( SmallCardBmp[I] == C )
        {
          nCurrItemOnPage = I;
          UpdateDisplayDetails();
        } 
      }
      break;
    }
  } else {
    if ( E == 12 )
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
    } else {
      if ( E == 9 )
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
    }
  }
  Super.Notify(C,E);
}

function float GetDHeightScale()
{
	return GetHeightScale() * GetHeightScale();
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
		SmallCardBmp[i].WW = 60.0 / GetHeightScale();
		SmallCardBmp[i].WH = 60.0 / GetHeightScale();
	}
	
}

function HiliteCurrCard()
{
	if ( nCurrItemOnPage < 10 )
	{
		nCardGlowLeft = SmallCardBmp[nCurrItemOnPage].WinLeft + (-33 * GetHeightScale());
		nCardGlowTop = SmallCardBmp[nCurrItemOnPage].WinTop + (-33 * GetHeightScale());;

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
			fHilitedCardScale = -0.53125;
		} 
		else 
		{
			fHilitedCardScale = -0.765625;
		}
	} 
	else 
	{
		nCardGlowLeft 		= HarryCardBmp.WinLeft + (-64 * GetHeightScale());
		nCardGlowTop 		= HarryCardBmp.WinTop + (-64 * GetHeightScale());
		textureCurrGlow 	= textureGoldBigGlow;
		HilitedCard 		= HarryCardBmp;
		fHilitedCardScale 	= -0.5;
	}
}

function AfterPaint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;

	Super.AfterPaint(Canvas,X,Y);
	fScaleFactor = (Canvas.SizeX / WinWidth) * GetHeightScale();
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
	Canvas.DrawIcon(textureCurrGlow, fScaleFactor * GetHeightScale());
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
		
		Canvas.DrawIcon(HilitedCard.OverTexture, (fScaleFactor + fHilitedCardScale * fScaleFactor) * GetHeightScale() );
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
		nLargeCardY = 4 + (textureCurrLargeCard.VSize * fScaleFactor - textureCurrLargeCard.VSize) / 2;
		if ( (classCurWC != None) && classCurWC.Default.bIsLayered )
		{
			GetMouseXY(MouseX,MouseY);
			offX = (MouseX - Canvas.SizeX / 2) / Canvas.SizeX / 2;
			offY = (MouseY - Canvas.SizeY / 2) / Canvas.SizeY / 2;
			offX *= 6;
			offY *= 6;
			if ( classCurWC.Default.bLastLayerIsFire )
			{
				Canvas.SetPos(nLargeCardX,nLargeCardY);
			} 
			else 
			{
				Canvas.SetPos(nLargeCardX + offX * 2,nLargeCardY + offY * 2);
			}
			
			Canvas.DrawIcon(classCurWC.Default.textureLayers[2],1.0);
			Canvas.SetPos(nLargeCardX + offX * 1,nLargeCardY + offY * 1);
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
		Canvas.SetPos(192.0 * fScaleFactor,4.0 * fScaleFactor);
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
  Canvas.SetPos(0.0,400.0 * fScaleFactor);
  Canvas.DrawTile(textureDescBkgrd,Canvas.SizeX,80.0 * fScaleFactor,0.0,0.0,1.0,1.0);
  if ( Canvas.SizeX <= 512 )
  {
    fontText = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
  } else {
    fontText = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
  }
  HPHud(PlayerHarry.myHUD).DrawCutStyleText(Canvas,strCurrDesc,0,400 * fScaleFactor, 80 * fScaleFactor, colorText,fontText);
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

  fontSave = Canvas.Font;
  fWindowScaleFactor = Canvas.SizeX / WinWidth;
  colorBlack.R = 0;
  colorBlack.G = 0;
  colorBlack.B = 0;
  colorOffWhite.R = 206;
  colorOffWhite.G = 200;
  colorOffWhite.B = 190;
  if ( Canvas.SizeX <= 512 )
  {
    Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
  } else {
    if ( Canvas.SizeX <= 640 )
    {
      Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
    } else {
      Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalBigFont;
    }
  }
  Canvas.TextSize(strCardCountGold,fXTextLen,fYTextLen);
  Canvas.SetPos(GoldButton.WinLeft * fWindowScaleFactor + 40 * fWindowScaleFactor - fXTextLen / 2,GoldButton.WinTop * fWindowScaleFactor + 40 * fWindowScaleFactor - fYTextLen / 2);
  Canvas.DrawShadowText(strCardCountGold,colorOffWhite,colorBlack);
  Canvas.TextSize(strCardCountSilver,fXTextLen,fYTextLen);
  Canvas.SetPos(SilverButton.WinLeft * fWindowScaleFactor + 40 * fWindowScaleFactor - fXTextLen / 2,SilverButton.WinTop * fWindowScaleFactor + 40 * fWindowScaleFactor - fYTextLen / 2);
  Canvas.DrawShadowText(strCardCountSilver,colorOffWhite,colorBlack);
  Canvas.TextSize(strCardCountBronze,fXTextLen,fYTextLen);
  Canvas.SetPos(BronzeButton.WinLeft * fWindowScaleFactor + 38 * fWindowScaleFactor - fXTextLen / 2,BronzeButton.WinTop * fWindowScaleFactor + 38 * fWindowScaleFactor - fYTextLen / 2);
  Canvas.DrawShadowText(strCardCountBronze,colorOffWhite,colorBlack);
  nXPos = (BronzeButton.WinLeft + BronzeButton.WinWidth + 24) * fWindowScaleFactor; 
  nYPos = BronzeButton.WinTop * fWindowScaleFactor;
  // if ( I < nBronzeHealthBars )
  for(I = 0; I < nBronzeHealthBars; i++)
  {
    Canvas.SetPos(nXPos,nYPos);
    Canvas.DrawIcon(textureBronzeHealth,fWindowScaleFactor);
    nXPos += 14 * fWindowScaleFactor;
    // goto JL038C;
  }
  nXPos = (SilverButton.WinLeft + SilverButton.WinWidth + 24) * fWindowScaleFactor;
  nYPos = SilverButton.WinTop * fWindowScaleFactor;
  // if ( I < nSilverKeys )
  for(I = 0; I < nSilverKeys; I++)
  {
    Canvas.SetPos(nXPos,nYPos);
    Canvas.DrawIcon(textureSilverKey,fWindowScaleFactor - 0.31);
    nXPos += 28 * (fWindowScaleFactor - 0.31);
    // goto JL0441;
  }
  Canvas.Font = fontSave;
}

function int GetStatusY ()
{
  // return 374;
  return nSTATUS_BAR_Y;
}

function PreSwitchPage ()
{
  PlayerHarry = harry(Root.Console.Viewport.Actor);
  InitHarryOwnedCards();
  SetCardCountData();
  SetInitialSelection();
  Super.PreSwitchPage();
}

function InitHarryOwnedCards ()
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
  // I = 0;
  // if ( I < 11 )
  for(I = 0; I < 11; I++)
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
    // I++;
    // goto JL0069;
  }
  // I = nHarrysGoldCount;
  // if ( I < 11 )
  for(I = nHarrysGoldCount; I < 11; I++)
  {
    HarrysGold[I] = 0;
    // I++;
    // goto JL00DE;
  }
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
  nHarrysSilverCount = 0;
  // I = 0;
  // if ( I < 40 )
  for(I = 0; I < 40; I++)
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
    // I++;
    // goto JL012E;
  }
  // I = nHarrysSilverCount;
  // if ( I < 40 )
  for(I = nHarrysSilverCount; I < 40; I++)
  {
    HarrysSilver[I] = 0;
    // I++;
    // goto JL01A6;
  }
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
  nHarrysBronzeCount = 0;
  // I = 0;
  // if ( I < 50 )
  for(I = 0; I < 50; I++)
  {
    nCardId = siCards.GetCardId(I);
    if ( nCardId > 0 )
    {
      if ( siCards.IsOwnedByHarry(nCardId) == True )
      {
        HarrysBronze[nHarrysBronzeCount] = nCardId;
        nHarrysBronzeCount++;
      }
    } //else {
      //I++;
    //}
    // I++;
    // goto JL01F6;
  }
  // I = nHarrysBronzeCount;
  // if ( I < 50 )
  for(I = nHarrysBronzeCount; I < 50; I++)
  {
    HarrysBronze[I] = 0;
    // I++;
    // goto JL0278;
  }
}

function SetInitialSelection ()
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
	
	nNumSmallPerPage = 10;
  
	if ( CurrCardGroup == CardGroup_Gold )
	{
		nCurrPage = 0;
	} 
	else if ( nCardCount <= 1 * 10 )
	{
		nCurrPage = 0;
	} else if ( nCardCount <= 2 * 10 )
	{
		nCurrPage = 1;
	} 
	else if ( nCardCount <= 3 * 10 )
	{
		nCurrPage = 2;
	} 
	else if ( nCardCount <= 4 * 10 )
	{
		nCurrPage = 3;
	} 
	else if ( nCardCount <= 5 * 10 )
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
				nCurrItemOnPage = 10 + 1;
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
