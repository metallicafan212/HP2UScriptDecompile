//================================================================================
// ShortCutButton.
//================================================================================

class ShortCutButton extends UWindowButton;//HGameButton;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\ButtonUpTexture.PNG	GROUP=Icons	Name=ButtonUpTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\ButtonDownTexture.PNG	GROUP=Icons	Name=ButtonDownTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914

var string strText;

//texture vars -AdamJD
var Texture UpButtonTexture;
var Texture DownButtonTexture;

function Resized()
{
	Super.Resized();
	
	/*
	// Metallicafan212:	Now set everything up
	EditBox.SetSize(WinWidth - 12, WinHeight);
	
	Button.SetSize(WinWidth - 12, 12);
	
	if(LeftButton != None)
		LeftButton.SetSize(WinWidth - 12, 12);
		
	if(RightButton != None)
		RightButton.SetSize(WinWidth - 12, 12);
		
	EditBoxWidth = WinWidth;
	EditAreaDrawX = 0.0;
	EditAreaDrawY = 0.0;
	*/
	
	// Metallicafan212:	Scale the region
	UpRegion.W			= WinWidth;
	UpRegion.H			= WinHeight;
	
	DownRegion.W		= WinWidth;
	DownRegion.H		= WinHeight;
	
	DisabledRegion.W	= WinWidth;
	DisabledRegion.H	= WinHeight;
	
	OverRegion.W		= WinWidth;
	OverRegion.H		= WinHeight;
}

function Created ()
{
	Super.Created();
	//UpTexture = Texture'ButtonUpTexture';
	//DownTexture = Texture'ButtonDownTexture';
	//OverTexture = Texture'ButtonUpTexture';
	UpTexture = UpButtonTexture;
	DownTexture = DownButtonTexture;
	OverTexture = UpButtonTexture;
	strText = "NOSTR";
}

function SetText (string NewText)
{
	strText = NewText;
}

function Paint (Canvas Canvas, float X, float Y)
{
	Super.Paint(Canvas,X,Y);
	Canvas.DrawColor.R = 0;
	Canvas.DrawColor.G = 0;
	Canvas.DrawColor.B = 0;
	ClipText(Canvas,4.0,4.0,strText);
}

//find the textures -AdamJD
defaultproperties
{
	UpButtonTexture=ButtonUpTexture	//Texture'HGame.Icons.ButtonUpTexture'
	
	DownButtonTexture=ButtonDownTexture	//Texture'HGame.Icons.ButtonDownTexture'
}

