//================================================================================
// FEMapPage.
//================================================================================

class FEMapPage extends baseFEPage;

//texture shape imports -AdamJD
#exec Texture Import File=Textures\Icons\CircleTexture.PNG	GROUP=Icons	Name=CircleTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\DiamondTexture.PNG	GROUP=Icons	Name=DiamondTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\DiffindoTexture.PNG	GROUP=Icons	Name=DiffindoTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\DownArrowTexture.PNG	GROUP=Icons	Name=DownArrowTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\HarryLocationTexture.PNG	GROUP=Icons	Name=HarryLocationTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\HexTexture.PNG	GROUP=Icons	Name=HexTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\LeftArrowTexture.PNG	GROUP=Icons	Name=LeftArrowTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\RectangleTexture.PNG	GROUP=Icons	Name=RectangleTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\RictusempraTexture.PNG	GROUP=Icons	Name=RictusempraTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\RightArrowTexture.PNG	GROUP=Icons	Name=RightArrowTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\SkurgeTexture.PNG	GROUP=Icons	Name=SkurgeTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\SquareGreenTexture.PNG	GROUP=Icons	Name=SquareGreenTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\tSpongifyTexture.PNG	GROUP=Icons	Name=tSpongifyTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\UpArrowTexture.PNG	GROUP=Icons	Name=UpArrowTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

//texture background imports -AdamJD
#exec Texture Import File=Textures\Icons\Map0Texture1.PNG	GROUP=Icons	Name=Map0Texture1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map0Texture2.PNG	GROUP=Icons	Name=Map0Texture2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map0Texture3.PNG	GROUP=Icons	Name=Map0Texture3 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map0Texture4.PNG	GROUP=Icons	Name=Map0Texture4 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map0Texture5.PNG	GROUP=Icons	Name=Map0Texture5 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map0Texture6.PNG	GROUP=Icons	Name=Map0Texture6 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map1Texture1.PNG	GROUP=Icons	Name=Map1Texture1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map1Texture2.PNG	GROUP=Icons	Name=Map1Texture2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map1Texture3.PNG	GROUP=Icons	Name=Map1Texture3 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map1Texture4.PNG	GROUP=Icons	Name=Map1Texture4 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map1Texture5.PNG	GROUP=Icons	Name=Map1Texture5 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map1Texture6.PNG	GROUP=Icons	Name=Map1Texture6 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map2Texture1.PNG	GROUP=Icons	Name=Map2Texture1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map2Texture2.PNG	GROUP=Icons	Name=Map2Texture2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map2Texture3.PNG	GROUP=Icons	Name=Map2Texture3 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map2Texture4.PNG	GROUP=Icons	Name=Map2Texture4 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map2Texture5.PNG	GROUP=Icons	Name=Map2Texture5 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map2Texture6.PNG	GROUP=Icons	Name=Map2Texture6 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map3Texture1.PNG	GROUP=Icons	Name=Map3Texture1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map3Texture2.PNG	GROUP=Icons	Name=Map3Texture2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map3Texture3.PNG	GROUP=Icons	Name=Map3Texture3 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map3Texture4.PNG	GROUP=Icons	Name=Map3Texture4 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map3Texture5.PNG	GROUP=Icons	Name=Map3Texture5 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0
#exec Texture Import File=Textures\Icons\Map3Texture6.PNG	GROUP=Icons	Name=Map3Texture6 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0

const NUM_HARRYLOC_INFO= 43;
const MAX_MAP_BUTTONS= 40;
const strPAGE3= "4";
const strPAGE2= "3";
const strPAGE1= "2";
const strPAGE0= "1";

struct sHarryLocInfo
{
  var int MapIdx;
  var string UnrName;
  var int X;
  var int Y;
  var name Tag;
};

struct sButtonInfo
{
  var UWindowButton MapButton;
  var int MapLink;
  var string ButtonText;
};

var harry PlayerHarry;
var sButtonInfo Buttons[40];
var int TotalNumMapButtons;
var int MapButtonIdx[4];
var int NumMapButtons[4];
var sHarryLocInfo HarryLocInfo[43];
var UWindowButton HarryLocationButton;
var UWindowWrappedTextArea StatusBarTextWindow;
var int nCurrPage;
var int HarryLocX;
var int HarryLocY;

//map shape texture vars -AdamJD
var Texture MapCircleImage;
var Texture MapDiamondImage;
var Texture MapDiffindoImage;
var Texture MapDownArrowImage;
var Texture MapHarryLocationImage;
var Texture MapHexImage;
var Texture MapLeftArrowImage;
var Texture MapRectangleImage;
var Texture MapRictusempraImage;
var Texture MapRightArrowImage;
var Texture MapSkurgeImage;
var Texture MapSquareImage;
var Texture MapSpongifyImage;
var Texture MapUpArrowImage;

//map background texture vars -AdamJD
var Texture Map0BackgroundImage1;
var Texture Map0BackgroundImage2;
var Texture Map0BackgroundImage3;
var Texture Map0BackgroundImage4;
var Texture Map0BackgroundImage5;
var Texture Map0BackgroundImage6;
var Texture Map1BackgroundImage1;
var Texture Map1BackgroundImage2;
var Texture Map1BackgroundImage3;
var Texture Map1BackgroundImage4;
var Texture Map1BackgroundImage5;
var Texture Map1BackgroundImage6;
var Texture Map2BackgroundImage1;
var Texture Map2BackgroundImage2;
var Texture Map2BackgroundImage3;
var Texture Map2BackgroundImage4;
var Texture Map2BackgroundImage5;
var Texture Map2BackgroundImage6;
var Texture Map3BackgroundImage1;
var Texture Map3BackgroundImage2;
var Texture Map3BackgroundImage3;
var Texture Map3BackgroundImage4;
var Texture Map3BackgroundImage5;
var Texture Map3BackgroundImage6;


function Created()
{
  local int I;
  
  /*
  MapButtonIdx[0] = TotalNumMapButtons;
  AddMapButton(97,81,42,72,Texture'DiamondTexture',"17");
  AddMapButton(91,299,42,72,Texture'DiamondTexture',"2");
  AddMapButton(413,350,46,42,Texture'SquareGreenTexture',"19");
  AddMapButton(273,209,75,34,Texture'RectangleTexture',"18");
  AddMapButton(402,206,83,42,Texture'RightArrowTexture',"10","1");
  NumMapButtons[0] = TotalNumMapButtons - MapButtonIdx[0];
  MapButtonIdx[1] = TotalNumMapButtons;
  AddMapButton(460,218,64,56,Texture'RictusempraTexture',"6");
  AddMapButton(476,343,46,42,Texture'SquareGreenTexture',"5");
  AddMapButton(282,295,75,34,Texture'RectangleTexture',"4");
  AddMapButton(525,151,75,34,Texture'RectangleTexture',"7");
  AddMapButton(508,31,66,73,Texture'SkurgeTexture',"8");
  AddMapButton(74,224,53,52,Texture'HexTexture',"16");
  AddMapButton(54,53,56,66,Texture'tSpongifyTexture',"1");
  AddMapButton(267,347,42,83,Texture'DownArrowTexture',"3","3");
  AddMapButton(298,8,42,83,Texture'UpArrowTexture',"9","2");
  AddMapButton(122,343,83,42,Texture'LeftArrowTexture',"18","0");
  NumMapButtons[1] = TotalNumMapButtons - MapButtonIdx[1];
  MapButtonIdx[2] = TotalNumMapButtons;
  AddMapButton(334,185,40,36,Texture'CircleTexture',"27");
  AddMapButton(409,295,40,36,Texture'CircleTexture',"29");
  AddMapButton(225,187,40,36,Texture'CircleTexture',"28");
  AddMapButton(131,292,40,36,Texture'CircleTexture',"26");
  AddMapButton(263,255,75,34,Texture'RectangleTexture',"9");
  AddMapButton(485,360,75,34,Texture'RectangleTexture',"30");
  AddMapButton(498,53,75,34,Texture'RectangleTexture',"32");
  AddMapButton(147,33,46,42,Texture'SquareGreenTexture',"22");
  AddMapButton(475,197,46,42,Texture'SquareGreenTexture',"31");
  AddMapButton(70,278,42,72,Texture'DiamondTexture',"24");
  AddMapButton(286,316,42,83,Texture'DownArrowTexture',"10","1");
  NumMapButtons[2] = TotalNumMapButtons - MapButtonIdx[2];
  MapButtonIdx[3] = TotalNumMapButtons;
  AddMapButton(81,241,46,42,Texture'SquareGreenTexture',"12");
  AddMapButton(249,171,75,34,Texture'RectangleTexture',"3");
  AddMapButton(460,221,75,34,Texture'RectangleTexture',"15");
  AddMapButton(97,113,49,64,Texture'DiffindoTexture',"11");
  AddMapButton(149,336,42,72,Texture'DiamondTexture',"13");
  AddMapButton(385,360,42,72,Texture'DiamondTexture',"14");
  AddMapButton(288,73,42,83,Texture'UpArrowTexture',"10","1");
  NumMapButtons[3] = TotalNumMapButtons - MapButtonIdx[3];
  HarryLocationButton = UWindowButton(CreateWindow(Class'UWindowButton',0.0,0.0,64.0,64.0));
  HarryLocationButton.Register(self);
  HarryLocationButton.UpTexture = Texture'HarryLocationTexture';
  HarryLocationButton.DownTexture = Texture'HarryLocationTexture';
  HarryLocationButton.OverTexture = Texture'HarryLocationTexture';
  HarryLocationButton.ToolTipString = GetLocalFEString("Maps_0033");
  HarryLocationButton.bDisabled = True;
  HarryLocationButton.HideWindow();
  CreateBackPageButton();
  StatusBarTextWindow = UWindowWrappedTextArea(CreateControl(Class'UWindowWrappedTextArea',16.0,WinHeight - 26,500.0,26.0));
  StatusBarTextWindow.Clear();
  StatusBarTextWindow.AddText("");
  StatusBarTextWindow.Font = 4;
  StatusBarTextWindow.WinTop = GetStatusY();
  */
  
  //add the map shape textures -AdamJD
  //
  MapButtonIdx[0] = TotalNumMapButtons;
  AddMapButton(97,81,42,72,MapDiamondImage,"17");
  AddMapButton(91,299,42,72,MapDiamondImage,"2");
  AddMapButton(413,350,46,42,MapSquareImage,"19");
  AddMapButton(273,209,75,34,MapRectangleImage,"18");
  AddMapButton(402,206,83,42,MapRightArrowImage,"10","1");
  NumMapButtons[0] = TotalNumMapButtons - MapButtonIdx[0];
  MapButtonIdx[1] = TotalNumMapButtons;
  AddMapButton(460,218,64,56,MapRictusempraImage,"6");
  AddMapButton(476,343,46,42,MapSquareImage,"5");
  AddMapButton(282,295,75,34,MapRectangleImage,"4");
  AddMapButton(525,151,75,34,MapRectangleImage,"7");
  AddMapButton(508,31,66,73,MapSkurgeImage,"8");
  AddMapButton(74,224,53,52,MapHexImage,"16");
  AddMapButton(54,53,56,66,MapSpongifyImage,"1");
  AddMapButton(267,347,42,83,MapDownArrowImage,"3","3");
  AddMapButton(298,8,42,83,MapUpArrowImage,"9","2");
  AddMapButton(122,343,83,42,MapLeftArrowImage,"18","0");
  NumMapButtons[1] = TotalNumMapButtons - MapButtonIdx[1];
  MapButtonIdx[2] = TotalNumMapButtons;
  AddMapButton(334,185,40,36,MapCircleImage,"27");
  AddMapButton(409,295,40,36,MapCircleImage,"29");
  AddMapButton(225,187,40,36,MapCircleImage,"28");
  AddMapButton(131,292,40,36,MapCircleImage,"26");
  AddMapButton(263,255,75,34,MapRectangleImage,"9");
  AddMapButton(485,360,75,34,MapRectangleImage,"30");
  AddMapButton(498,53,75,34,MapRectangleImage,"32");
  AddMapButton(147,33,46,42,MapSquareImage,"22");
  AddMapButton(475,197,46,42,MapSquareImage,"31");
  AddMapButton(70,278,42,72,MapDiamondImage,"24");
  AddMapButton(286,316,42,83,MapDownArrowImage,"10","1");
  NumMapButtons[2] = TotalNumMapButtons - MapButtonIdx[2];
  MapButtonIdx[3] = TotalNumMapButtons;
  AddMapButton(81,241,46,42,MapSquareImage,"12");
  AddMapButton(249,171,75,34,MapRectangleImage,"3");
  AddMapButton(460,221,75,34,MapRectangleImage,"15");
  AddMapButton(97,113,49,64,MapDiffindoImage,"11");
  AddMapButton(149,336,42,72,MapDiamondImage,"13");
  AddMapButton(385,360,42,72,MapDiamondImage,"14");
  AddMapButton(288,73,42,83,MapUpArrowImage,"10","1");
  NumMapButtons[3] = TotalNumMapButtons - MapButtonIdx[3];
  HarryLocationButton = UWindowButton(CreateWindow(Class'UWindowButton',0.0,0.0,64.0,64.0));
  HarryLocationButton.Register(self);
  HarryLocationButton.UpTexture = MapHarryLocationImage;
  HarryLocationButton.DownTexture = MapHarryLocationImage;
  HarryLocationButton.OverTexture = MapHarryLocationImage;
  HarryLocationButton.ToolTipString = GetLocalFEString("Maps_0033");
  HarryLocationButton.bDisabled = True;
  HarryLocationButton.HideWindow();
  CreateBackPageButton();
  StatusBarTextWindow = UWindowWrappedTextArea(CreateControl(Class'UWindowWrappedTextArea',16.0,WinHeight - 26,500.0,26.0));
  StatusBarTextWindow.Clear();
  StatusBarTextWindow.AddText("");
  StatusBarTextWindow.Font = F_HPMenuLarge;
  StatusBarTextWindow.WinTop = GetStatusY();
}

function AddMapButton (int X, int Y, int W, int H, Texture t, string ButtonText, optional string MapLink)
{
  if ( TotalNumMapButtons >= MAX_MAP_BUTTONS )
  {
    TotalNumMapButtons = MAX_MAP_BUTTONS - 1;
  }
  Buttons[TotalNumMapButtons].MapButton = UWindowButton(CreateWindow(Class'UWindowButton',X,Y,W,H));
  Buttons[TotalNumMapButtons].MapButton.DownTexture = t;
  Buttons[TotalNumMapButtons].MapButton.OverTexture = t;
  Buttons[TotalNumMapButtons].MapButton.Register(self);
  // if ( Len(ButtonText) < 4 )
  while ( Len(ButtonText) < 4 )
  {
    ButtonText = "0" $ ButtonText;
    // goto JL00A9;
  }
  ButtonText = "Maps_" $ ButtonText;
  Buttons[TotalNumMapButtons].MapButton.ToolTipString = GetLocalFEString(ButtonText);
  if ( MapLink != "" )
  {
    Buttons[TotalNumMapButtons].MapLink = int(MapLink);
  } else {
    Buttons[TotalNumMapButtons].MapLink = -1;
    Buttons[TotalNumMapButtons].MapButton.DownSound = None;
  }
  if ( ButtonText != "" )
  {
    Buttons[TotalNumMapButtons].ButtonText = ButtonText;
  } else {
    Buttons[TotalNumMapButtons].ButtonText = "NO BUTTON TEXT";
  }
  TotalNumMapButtons++;
}

function ToolTip (string strTip)
{
  StatusBarTextWindow.Clear();
  StatusBarTextWindow.AddText(strTip);
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

function UpdateDisplayDetails()
{
  local int I;
  local string S;
  local bool bHarryShownOnMap;
  local name N;

  for(I = 0; I < TotalNumMapButtons; I++)
  {
    if ( (I >= MapButtonIdx[nCurrPage]) && (I < MapButtonIdx[nCurrPage] + NumMapButtons[nCurrPage]) )
    {
      Buttons[I].MapButton.bDisabled = False;
      Buttons[I].MapButton.ShowWindow();
    } else {
      Buttons[I].MapButton.bDisabled = True;
      Buttons[I].MapButton.HideWindow();
    }
  }
  S = GetCurrentUnrFileName();
  N = PlayerHarry.HarryAtMapMarker();

  for(I = 0; I < NUM_HARRYLOC_INFO; I++)
  {
    if ( (nCurrPage == HarryLocInfo[I].MapIdx) && (S ~= HarryLocInfo[I].UnrName) && (HarryLocInfo[I].Tag == N) )
    {
      bHarryShownOnMap = True;
      HarryLocationButton.bDisabled = False;
      HarryLocationButton.ShowWindow();
      HarryLocX = HarryLocInfo[I].X * 640 / 800 - 32;
      HarryLocY = HarryLocInfo[I].Y * 480 / 600 - 32;
      HarryLocationButton.WinLeft = HarryLocX;
      HarryLocationButton.WinTop = HarryLocY;
	  break;
    } 
  }
  if (  !bHarryShownOnMap )
  {
    HarryLocationButton.bDisabled = True;
    HarryLocationButton.HideWindow();
    if ( N != 'None' )
    {
      PlayerHarry.ClientMessage("**** Error: MenuMapLocationMarker.tag=" $ string(N) $ ", but no table entry found.");
    }
  }
}

function string GetCurrentUnrFileName()
{
  local string S;
  local string S2;
  local int I;

  S = GetLevel().LevelEnterText;
  while ( True )
  {
    I = InStr(S,"\\");
    if ( I >= 0 )
    {
      S = Mid(S,I + 1);
    } else {
	 break;
    }
  }
  S2 = Caps(S);
  if ( InStr(S2,".UNR") < 0 )
  {
    S = S $ ".UNR";
  }
  return S;
}

function Tick (float dtime)
{
  if (  !HarryLocationButton.bDisabled )
  {
    HarryLocationButton.WinLeft = HarryLocX + 4 * Cos(GetLevel().TimeSeconds * 7);
    HarryLocationButton.WinTop = HarryLocY + 4 * 0.69999999 * Sin(GetLevel().TimeSeconds * 2 * 7);
  }
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  if ( E == DE_Click )
  {
    for(I = MapButtonIdx[nCurrPage]; I < MapButtonIdx[nCurrPage] + NumMapButtons[nCurrPage]; I++)
	{
      if ( (C == Buttons[I].MapButton) && (Buttons[I].MapLink != -1) )
      {
        nCurrPage = Buttons[I].MapLink;
        UpdateDisplayDetails();
      }
    }
    if ( C == BackPageButton )
    {
      FEBook(book).DoEscapeFromPage();
    }
  }
  Super.Notify(C,E);
}

function Paint (Canvas Canvas, float X, float Y)
{
  local float fScaleFactor;

  fScaleFactor = Canvas.SizeX / WinWidth;
  DrawBackground(Canvas);
  Super.Paint(Canvas,X,Y);
}

function DrawBackground (Canvas Canvas)
{
  /*
  switch (nCurrPage)
  {
    case 0:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Texture'Map0Texture1');
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Texture'Map0Texture2');
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Texture'Map0Texture3');
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Texture'Map0Texture4');
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Texture'Map0Texture5');
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Texture'Map0Texture6');
		break;
    case 1:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Texture'Map1Texture1');
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Texture'Map1Texture2');
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Texture'Map1Texture3');
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Texture'Map1Texture4');
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Texture'Map1Texture5');
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Texture'Map1Texture6');
		break;
    case 2:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Texture'Map2Texture1');
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Texture'Map2Texture2');
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Texture'Map2Texture3');
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Texture'Map2Texture4');
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Texture'Map2Texture5');
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Texture'Map2Texture6');
		break;
    case 3:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Texture'Map3Texture1');
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Texture'Map3Texture2');
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Texture'Map3Texture3');
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Texture'Map3Texture4');
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Texture'Map3Texture5');
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Texture'Map3Texture6');
		break;
    default:
  }
  */
  
  //add the map background textures -AdamJD
  //
  switch (nCurrPage)
  {
    case 0:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Map0BackgroundImage1);
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Map0BackgroundImage2);
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Map0BackgroundImage3);
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Map0BackgroundImage4);
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Map0BackgroundImage5);
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Map0BackgroundImage6);
		break;
    case 1:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Map1BackgroundImage1);
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Map1BackgroundImage2);
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Map1BackgroundImage3);
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Map1BackgroundImage4);
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Map1BackgroundImage5);
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Map1BackgroundImage6);
		break;
    case 2:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Map2BackgroundImage1);
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Map2BackgroundImage2);
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Map2BackgroundImage3);
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Map2BackgroundImage4);
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Map2BackgroundImage5);
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Map2BackgroundImage6);
		break;
    case 3:
		DrawStretchedTexture(Canvas,0.0,0.0,256.0,256.0,Map3BackgroundImage1);
		DrawStretchedTexture(Canvas,256.0,0.0,256.0,256.0,Map3BackgroundImage2);
		DrawStretchedTexture(Canvas,512.0,0.0,256.0,256.0,Map3BackgroundImage3);
		DrawStretchedTexture(Canvas,0.0,256.0,256.0,256.0,Map3BackgroundImage4);
		DrawStretchedTexture(Canvas,256.0,256.0,256.0,256.0,Map3BackgroundImage5);
		DrawStretchedTexture(Canvas,512.0,256.0,256.0,256.0,Map3BackgroundImage6);
		break;
    default:
  }
}

function PreSwitchPage()
{
  PlayerHarry = harry(Root.Console.Viewport.Actor);
  SetInitialSelection();
  Super.PreSwitchPage();
}

function SetInitialSelection()
{
  local string S;
  local int I;
  local name HarryAtMapMarkerName;

  S = GetCurrentUnrFileName();
  nCurrPage = -1;
  HarryAtMapMarkerName = PlayerHarry.HarryAtMapMarker();

  for(I = 0; I < NUM_HARRYLOC_INFO; I++)
  {
    if ( (S ~= HarryLocInfo[I].UnrName) && (HarryLocInfo[I].Tag != 'None') && (HarryLocInfo[I].Tag == HarryAtMapMarkerName) )
    {
      nCurrPage = HarryLocInfo[I].MapIdx;
	  break;
    }
  }
  if ( nCurrPage == -1 )
  {
	for(I = 0; I < NUM_HARRYLOC_INFO; I++)
    {
      if ( (S ~= HarryLocInfo[I].UnrName) && (HarryLocInfo[I].Tag == HarryAtMapMarkerName) )
      {
        nCurrPage = HarryLocInfo[I].MapIdx;
		break;
      } 
    }
  }
  if ( nCurrPage == -1 )
  {
    nCurrPage = 1;
  }
}

defaultproperties
{
    HarryLocInfo(0)=(MapIdx=0,UnrName="Adv3DungeonQuest.unr",X=220,Y=423,Tag=None)

    HarryLocInfo(1)=(MapIdx=0,UnrName="Adv6Goyle.unr",X=220,Y=143,Tag=None)

    HarryLocInfo(2)=(MapIdx=0,UnrName="Entryhall_hub.unr",X=393,Y=333,Tag=DungeonHallway)

    HarryLocInfo(3)=(MapIdx=0,UnrName="Sepia_Hallway.unr",X=393,Y=333,Tag=None)

    HarryLocInfo(4)=(MapIdx=0,UnrName="Adv7SlythComRoom.unr",X=393,Y=333,Tag=None)

    HarryLocInfo(5)=(MapIdx=0,UnrName="Entryhall_hub.unr",X=540,Y=402,Tag=PotionsClass)

    HarryLocInfo(6)=(MapIdx=1,UnrName="Entryhall_hub.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(7)=(MapIdx=1,UnrName="BeanRewardRoom.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(8)=(MapIdx=1,UnrName="Ch4Spongify.unr",X=160,Y=109,Tag=None)

    HarryLocInfo(9)=(MapIdx=1,UnrName="Arena.unr",X=553,Y=456,Tag=None)

    HarryLocInfo(10)=(MapIdx=1,UnrName="Ch1Rictusempra.unr",X=533,Y=311,Tag=None)

    HarryLocInfo(11)=(MapIdx=1,UnrName="Ch2Skurge.unr",X=607,Y=104,Tag=None)

    HarryLocInfo(12)=(MapIdx=1,UnrName="Entryhall_hub.unr",X=217,Y=309,Tag=HousePntCrmny)

    HarryLocInfo(13)=(MapIdx=1,UnrName="Entryhall_hub.unr",X=622,Y=211,Tag=GCommonRoom)

    HarryLocInfo(14)=(MapIdx=1,UnrName="Ch7Gryffindor.unr",X=622,Y=211,Tag=None)

    HarryLocInfo(15)=(MapIdx=1,UnrName="duel01.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(16)=(MapIdx=1,UnrName="duel02.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(17)=(MapIdx=1,UnrName="duel03.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(18)=(MapIdx=1,UnrName="duel04.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(19)=(MapIdx=1,UnrName="duel05.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(20)=(MapIdx=1,UnrName="duel06.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(21)=(MapIdx=1,UnrName="duel07.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(22)=(MapIdx=1,UnrName="duel08.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(23)=(MapIdx=1,UnrName="duel09.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(24)=(MapIdx=1,UnrName="duel10.unr",X=396,Y=300,Tag=None)

    HarryLocInfo(25)=(MapIdx=2,UnrName="Grandstaircase_hub.unr",X=376,Y=395,Tag=None)

    HarryLocInfo(26)=(MapIdx=2,UnrName="ch6wizardcard.unr",X=79,Y=387,Tag=None)

    HarryLocInfo(27)=(MapIdx=2,UnrName="Grandstaircase_hub.unr",X=214,Y=119,Tag=dada)

    HarryLocInfo(28)=(MapIdx=2,UnrName="Grandstaircase_hub.unr",X=655,Y=413,Tag=infirmiry)

    HarryLocInfo(29)=(MapIdx=2,UnrName="Grandstaircase_hub.unr",X=622,Y=220,Tag=charms)

    HarryLocInfo(30)=(MapIdx=2,UnrName="Grandstaircase_hub.unr",X=671,Y=127,Tag=MoaningMyrtle)

    HarryLocInfo(31)=(MapIdx=2,UnrName="Adv11aCorridor.unr",X=671,Y=127,Tag=None)

    HarryLocInfo(32)=(MapIdx=2,UnrName="Adv11bSecrets.unr",X=671,Y=127,Tag=None)

    HarryLocInfo(33)=(MapIdx=2,UnrName="Adv12Chamber.unr",X=671,Y=127,Tag=None)

    HarryLocInfo(34)=(MapIdx=3,UnrName="Grounds_hub.unr",X=364,Y=283,Tag=None)

    HarryLocInfo(35)=(MapIdx=3,UnrName="Grounds_night.unr",X=364,Y=283,Tag=None)

    HarryLocInfo(36)=(MapIdx=3,UnrName="Ch3Diffindo.unr",X=223,Y=193,Tag=None)

    HarryLocInfo(37)=(MapIdx=3,UnrName="Adv1Willow.unr",X=320,Y=503,Tag=None)

    HarryLocInfo(38)=(MapIdx=3,UnrName="Adv8Forest.unr",X=659,Y=489,Tag=None)

    HarryLocInfo(39)=(MapIdx=3,UnrName="Adv9Aragog.unr",X=659,Y=489,Tag=None)

    HarryLocInfo(40)=(MapIdx=3,UnrName="quidditch.unr",X=623,Y=188,Tag=None)

    HarryLocInfo(41)=(MapIdx=3,UnrName="Grounds_hub.unr",X=194,Y=309,Tag=HerbologyLesson)

    HarryLocInfo(42)=(MapIdx=3,UnrName="Adv4GreenHouse.unr",X=194,Y=309,Tag=None)
	
	//get the map shape textures -AdamJD
	//
	MapCircleImage=CircleTexture
	
	MapDiamondImage=DiamondTexture
	
	MapDiffindoImage=DiffindoTexture
	
	MapDownArrowImage=DownArrowTexture
	
	MapHarryLocationImage=HarryLocationTexture
	
	MapHexImage=HexTexture
	
	MapLeftArrowImage=LeftArrowTexture
	
	MapRectangleImage=RectangleTexture
	
	MapRictusempraImage=RictusempraTexture
	
	MapRightArrowImage=RightArrowTexture
	
	MapSkurgeImage=SkurgeTexture
	
	MapSquareImage=SquareGreenTexture
	
	MapSpongifyImage=tSpongifyTexture
	
	MapUpArrowImage=UpArrowTexture
	
	//get the map background textures -AdamJD
	//
	Map0BackgroundImage1=Map0Texture1
	
	Map0BackgroundImage2=Map0Texture2
	
	Map0BackgroundImage3=Map0Texture3
	
	Map0BackgroundImage4=Map0Texture4
	
	Map0BackgroundImage5=Map0Texture5
	
	Map0BackgroundImage6=Map0Texture6
	
	Map1BackgroundImage1=Map1Texture1
	
	Map1BackgroundImage2=Map1Texture2
	
	Map1BackgroundImage3=Map1Texture3
	
	Map1BackgroundImage4=Map1Texture4
	
	Map1BackgroundImage5=Map1Texture5
	
	Map1BackgroundImage6=Map1Texture6
	
	Map2BackgroundImage1=Map2Texture1
	
	Map2BackgroundImage2=Map2Texture2
	
	Map2BackgroundImage3=Map2Texture3
	
	Map2BackgroundImage4=Map2Texture4
	
	Map2BackgroundImage5=Map2Texture5
	
	Map2BackgroundImage6=Map2Texture6
	
	Map3BackgroundImage1=Map3Texture1
	
	Map3BackgroundImage2=Map3Texture2
	
	Map3BackgroundImage3=Map3Texture3
	
	Map3BackgroundImage4=Map3Texture4
	
	Map3BackgroundImage5=Map3Texture5
	
	Map3BackgroundImage6=Map3Texture6
}
