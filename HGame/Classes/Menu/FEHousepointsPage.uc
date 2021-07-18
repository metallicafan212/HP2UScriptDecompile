//================================================================================
// FEHousepointsPage.
//================================================================================

class FEHousepointsPage extends baseFEPage;

var HGameButton GryffButton;
var HGameButton HuffButton;
var HGameButton RaveButton;
var HGameButton SlythButton;

function Created ()
{
	CreateBackPageButton();
	
	CreateTitleButton(GetLocalFEString("Report_Card_0004"));
	GryffButton = HGameButton(CreateControl(Class'HGameButton',152.0,110.0,70.0,98.0));
	GryffButton.ToolTipString = GetLocalFEString("InGameMenu_0009");
	GryffButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2GriffindorCrest",Class'Texture'));
	GryffButton.OverTexture = GryffButton.UpTexture;
	GryffButton.DownTexture = GryffButton.OverTexture;
	GryffButton.DownSound = None;
  
	HuffButton = HGameButton(CreateControl(Class'HGameButton',152.0,252.0,70.0,98.0));
	HuffButton.ToolTipString = GetLocalFEString("InGameMenu_0010");
	HuffButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2HufflepuffCrest",Class'Texture'));
	HuffButton.OverTexture = HuffButton.UpTexture;
	HuffButton.DownTexture = HuffButton.OverTexture;
	HuffButton.DownSound = None;
  
	RaveButton = HGameButton(CreateControl(Class'HGameButton',428.0,110.0,70.0,98.0));
	RaveButton.ToolTipString = GetLocalFEString("InGameMenu_0011");
	RaveButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2RavenclawCrest",Class'Texture'));
	RaveButton.OverTexture = RaveButton.UpTexture;
	RaveButton.DownTexture = RaveButton.OverTexture;
	RaveButton.DownSound = None;
  
	SlythButton = HGameButton(CreateControl(Class'HGameButton',428.0,252.0,70.0,98.0));
	SlythButton.ToolTipString = GetLocalFEString("InGameMenu_0012");
	SlythButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2SlytherinCrest",Class'Texture'));
	SlythButton.OverTexture = SlythButton.UpTexture;
	SlythButton.DownTexture = SlythButton.OverTexture;
	SlythButton.DownSound = None;
	
	Super.Created();
}

function Notify (UWindowDialogControl C, byte E)
{
	local int I;

	if ( E == 2 )
	{
		if ( C == BackPageButton )
		{
			FEBook(book).DoEscapeFromPage();
		}
	}
	
	Super.Notify(C,E);
}

function AfterPaint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;

	fScaleFactor = Canvas.SizeX / WinWidth;
	PaintCountText(Canvas,fScaleFactor);
	Super.AfterPaint(Canvas,X,Y);
}

function PaintCountText (Canvas Canvas, float fScaleFactor)
{
	local StatusManager managerStatus;
	local StatusGroup sg;
	local StatusItem si;
	
	// Metallicafan212:	Height scaling
	local float HScale;
	
	HScale = Class'M212HScale'.Static.CanvasGetHeightScale(Canvas);

	managerStatus = harry(Root.Console.Viewport.Actor).managerStatus;
	sg = managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
  
	si = sg.GetStatusItem(Class'StatusItemGryffindorPts');
	si.DrawCount(Canvas, GryffButton.WinLeft * fScaleFactor, GryffButton.WinTop * fScaleFactor, fScaleFactor * HScale);
  
	si = sg.GetStatusItem(Class'StatusItemHufflePuffPts');
	si.DrawCount(Canvas, HuffButton.WinLeft * fScaleFactor, HuffButton.WinTop * fScaleFactor, fScaleFactor * HScale);
  
	si = sg.GetStatusItem(Class'StatusItemRavenclawPts');
	si.DrawCount(Canvas, RaveButton.WinLeft * fScaleFactor, RaveButton.WinTop * fScaleFactor, fScaleFactor * HScale);
  
	si = sg.GetStatusItem(Class'StatusItemSlytherinPts');
	si.DrawCount(Canvas, SlythButton.WinLeft * fScaleFactor, SlythButton.WinTop * fScaleFactor, fScaleFactor * HScale);
}

