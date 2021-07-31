//================================================================================
// ShortCutButton.
//================================================================================

class ShortCutButton extends UWindowButton;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\ButtonUpTexture.PNG	GROUP=Icons	Name=ButtonUpTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\ButtonDownTexture.PNG	GROUP=Icons	Name=ButtonDownTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2

var string strText;

//texture vars -AdamJD
var Texture UpButtonTexture;
var Texture DownButtonTexture;


function Created()
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

