//================================================================================
// ShortCutButton.
//================================================================================

class ShortCutButton extends UWindowButton;

var string strText;

function Created ()
{
  Super.Created();
  UpTexture = Texture'ButtonUpTexture';
  DownTexture = Texture'ButtonDownTexture';
  OverTexture = Texture'ButtonUpTexture';
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

