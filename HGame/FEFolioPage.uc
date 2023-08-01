//================================================================================
// FEFolioPage.
//================================================================================

//AdamJD:	This is the demo version of FEFolioPage, replacing this with the one in Classes\Menu will compile and work
//			Is added here because it was virtually rewritten for the demo but you can't see cards you've collected when playing the normal game... 		

class FEFolioPage extends baseFEPage;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\CardGlowBronze.PNG	GROUP=Icons	Name=CardGlowBronze COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\CardGlowGold.PNG	GROUP=Icons	Name=CardGlowGold COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\CardGlowSilver.PNG	GROUP=Icons	Name=CardGlowSilver COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMissingBigTexture.PNG	GROUP=Icons	Name=WizCardMissingBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMissingSmallTexture.PNG	GROUP=Icons	Name=WizCardMissingSmallTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

const nGOLD_IDX= 2;
const nSILVER_IDX= 1;
const nBRONZE_IDX= 0;
const nCARDGLOW_OFFSET_Y= -34;
const nCARDGLOW_OFFSET_X= -34;
const fVACANT_SMALL_CARD_SCALE= -0.53125;
const fSMALL_CARD_SCALE= -0.765625;
const nWIZARD_TEXT_H= 80;
const nWIZARD_TEXT_Y= 400;
const nWIZARD_TEXT_X= 0;
const nSTATUS_BAR_Y= 374;
const nLARGE_CARD_Y= 4;
const nLARGE_CARD_X= 192;
var harry PlayerHarry;
var Color colorBronze;
var Color colorSilver;
var Color colorGold;
var int SmallCardId[3];
var UWindowButton SmallCardBmp[3];
var UWindowButton HilitedCard;
var float fHilitedCardScale;
var Texture textureDescBkgrd;
var Texture textureCurrLargeCard;
var Class<WizardCardIcon> classCurWC;
var int nCurrItemOnPage;
var string strCurrDesc;
var int nCardGlowLeft;
var int nCardGlowTop;
var Texture textureCurrGlow;

//specific card glow textures and empty wizard card textures -AdamJD
var Texture textureBronzeGlow;
var Texture textureSilverGlow;
var Texture textureGoldGlow;
var Texture textureBigEmptyCard;
var Texture textureSmallEmptyCard;

function Created ()
{
  local int I;

  textureDescBkgrd = Texture(DynamicLoadObject("HGame.Icons.leftPanel",Class'Texture'));
  SmallCardBmp[0] = UWindowButton(CreateWindow(Class'UWindowButton',212.0,270.0,60.0,60.0));
  SmallCardBmp[1] = UWindowButton(CreateWindow(Class'UWindowButton',290.0,270.0,60.0,60.0));
  SmallCardBmp[2] = UWindowButton(CreateWindow(Class'UWindowButton',368.0,270.0,60.0,60.0));
  for(I = 0; I != ArrayCount(SmallCardBmp); ++I)
  {
    SmallCardBmp[I].Register(self);
    SmallCardBmp[I].bStretched = True;
  }
  CreateBackPageButton(590,350);
  Super.Created();
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
  local int I;
  local StatusGroupWizardCards sgCards;
  local StatusItemWizardCards siCards;
  local Class<Actor> classWC;
  local int nCardId;

  textureCurrLargeCard = textureBigEmptyCard; 	//Texture'WizCardMissingBigTexture';
  classCurWC = None;
  strCurrDesc = "";
  sgCards = StatusGroupWizardCards(PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
  switch (nCurrItemOnPage)
  {
    case nBRONZE_IDX:
    siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
    break;
    case nSILVER_IDX:
    siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
    break;
    case nGOLD_IDX:
    siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemGoldCards'));
    break;
    default:
    Log("ERROR: Invalid card index in FEFolioPage " $ string(nCurrItemOnPage));
    break;
  }	
  for(I = 0; I < ArrayCount(SmallCardBmp); I++)
  {
    nCardId = SmallCardId[I];
    if ( nCardId != 0 )
    {
      classWC = siCards.GetCardClassFromId(nCardId);
      SmallCardBmp[I].UpTexture = Class<WizardCardIcon>(classWC).Default.textureBig;
      if ( I == nCurrItemOnPage )
      {
        SetLargeCardProps(Class<WizardCardIcon>(classWC));
      }
    } else {
      SmallCardBmp[I].UpTexture = textureSmallEmptyCard; 	//Texture'WizCardMissingSmallTexture';
    }
    SmallCardBmp[I].DownTexture = SmallCardBmp[I].UpTexture;
    SmallCardBmp[I].OverTexture = SmallCardBmp[I].UpTexture;
  }
  HiliteCurrCard();
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  if ( E == DE_Click )
  {
    switch (C)
    {
      case BackPageButton:
      FEBook(book).DoEscapeFromPage();
      break;
      default:
      for( I = 0; I != ArrayCount(SmallCardBmp); ++I )
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
  Super.Notify(C,E);
}

function HiliteCurrCard ()
{
  nCardGlowLeft = SmallCardBmp[nCurrItemOnPage].WinLeft + nCARDGLOW_OFFSET_X;
  nCardGlowTop = SmallCardBmp[nCurrItemOnPage].WinTop + nCARDGLOW_OFFSET_Y;
  switch (nCurrItemOnPage)
  {
    case nBRONZE_IDX:
    textureCurrGlow = textureBronzeGlow; //Texture'CardGlowBronze';
    break;
    case nSILVER_IDX:
    textureCurrGlow = textureSilverGlow; //Texture'CardGlowSilver';
    break;
    case nGOLD_IDX:
    textureCurrGlow = textureGoldGlow;  //Texture'CardGlowGold';
    break;
    default:
  }
  HilitedCard = SmallCardBmp[nCurrItemOnPage];
  if ( SmallCardBmp[nCurrItemOnPage].UpTexture == textureSmallEmptyCard )	//Texture'WizCardMissingSmallTexture' )
  {
    fHilitedCardScale = fVACANT_SMALL_CARD_SCALE;
  } else {
    fHilitedCardScale = fSMALL_CARD_SCALE;
  }
}

function AfterPaint (Canvas Canvas, float X, float Y)
{
  local float fScaleFactor;

  Super.AfterPaint(Canvas,X,Y);
  fScaleFactor = Canvas.SizeX / WinWidth;
  PaintLargeCard(Canvas,fScaleFactor);
  PaintWizardText(Canvas,fScaleFactor);
  HiliteSelectedCard(Canvas);
}

function BeforePaint (Canvas Canvas, float X, float Y)
{
  local float fScaleFactor;
  local int nStyleSave;

  Super.BeforePaint(Canvas,X,Y);
  fScaleFactor = Canvas.SizeX / WinWidth;
  nStyleSave = Canvas.Style;
  Canvas.Style = 3;
  Canvas.SetPos(nCardGlowLeft * fScaleFactor,nCardGlowTop * fScaleFactor);
  Canvas.DrawIcon(textureCurrGlow,fScaleFactor);
  Canvas.Style = nStyleSave;
}

function HiliteSelectedCard (Canvas Canvas)
{
  local float fScaleFactor;
  local int nSaveStyle;

  if ( HilitedCard != None )
  {
    fScaleFactor = Canvas.SizeX / WinWidth;
    nSaveStyle = Canvas.Style;
    Canvas.Style = 3;
    Canvas.SetPos(HilitedCard.WinLeft * fScaleFactor,HilitedCard.WinTop * fScaleFactor);
    Canvas.DrawIcon(HilitedCard.OverTexture,fScaleFactor + (fHilitedCardScale * fScaleFactor));
    Canvas.Style = nSaveStyle;
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
    nLargeCardY = nLARGE_CARD_Y + (((textureCurrLargeCard.VSize * fScaleFactor) - textureCurrLargeCard.VSize) / 2);
	Canvas.SetPos(nLargeCardX,nLargeCardY);
    Canvas.DrawIcon(textureCurrLargeCard,1.0);
  } else {
    Canvas.SetPos(nLARGE_CARD_X * fScaleFactor,nLARGE_CARD_Y * fScaleFactor);
    Canvas.DrawIcon(textureCurrLargeCard,fScaleFactor);
  }
}

function PaintWizardText (Canvas Canvas, float fScaleFactor)
{
  local Color colorText;
  local Font fontText;

  switch (nCurrItemOnPage)
  {
    case nBRONZE_IDX:
    colorText = colorBronze;
    break;
    case nSILVER_IDX:
    colorText = colorSilver;
    break;
    case nGOLD_IDX:
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
  } else {
    fontText = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
  }
  HPHud(PlayerHarry.myHUD).DrawCutStyleText(Canvas,strCurrDesc,0,nWIZARD_TEXT_Y * fScaleFactor, nWIZARD_TEXT_H * fScaleFactor, colorText,fontText);
}

function int GetStatusY ()
{
  return nSTATUS_BAR_Y;
}

function PreSwitchPage ()
{
  PlayerHarry = harry(Root.Console.Viewport.Actor);
  InitHarryOwnedCards();
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
  SmallCardId[2] = siCards.GetCardId(0);
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemSilverCards'));
  SmallCardId[1] = siCards.GetCardId(0);
  siCards = StatusItemWizardCards(sgCards.GetStatusItem(Class'StatusItemBronzeCards'));
  SmallCardId[0] = siCards.GetCardId(0);
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
    nCurrItemOnPage = nGOLD_IDX;
    break;
    case sgCards.ECardType.CardType_Silver:
    nCurrItemOnPage = nSILVER_IDX;
    break;
    case sgCards.ECardType.CardType_Bronze:
    nCurrItemOnPage = nBRONZE_IDX;
    break;
    case sgCards.ECardType.CardType_None:
    nCurrItemOnPage = 0;
    break;
    default:
  }
}

defaultproperties
{
    colorBronze=(R=132,G=64,B=44,A=0)

    colorSilver=(R=115,G=123,B=140,A=0)

    colorGold=(R=181,G=115,B=0,A=0)

	//set the card glow textures and empty card textures -AdamJD
	//
	textureBronzeGlow=CardGlowBronze
	
	textureSilverGlow=CardGlowSilver
	
	textureGoldGlow=CardGlowGold
	
	textureBigEmptyCard=WizCardMissingBigTexture
	
	textureSmallEmptyCard=WizCardMissingSmallTexture
}
