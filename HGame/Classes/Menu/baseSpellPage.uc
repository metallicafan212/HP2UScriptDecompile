//================================================================================
// baseSpellPage.
//================================================================================

class baseSpellPage extends basePopup; 

var Texture pagePieces[4];
var int yOffset;

function Draw (Canvas Canvas)
{
  local int Width;

  Width = pagePieces[0].USize + pagePieces[1].USize;
  Canvas.SetPos(Canvas.SizeX / 2 - (Width / 2),Canvas.SizeY - yOffset);
  Canvas.DrawIcon(pagePieces[0],1.0);
  Canvas.SetPos(Canvas.SizeX / 2 - (Width / 2) + 256,Canvas.SizeY - yOffset);
  Canvas.DrawIcon(pagePieces[1],1.0);
  if ( pagePieces[2] != None )
  {
    Canvas.SetPos(Canvas.SizeX / 2 - (Width / 2),Canvas.SizeY - (yOffset + 256));
    Canvas.DrawIcon(pagePieces[2],1.0);
  }
  if ( pagePieces[3] != None )
  {
    Canvas.SetPos(Canvas.SizeX / 2 - (Width / 2) + 256,Canvas.SizeY - (yOffset + 256));
    Canvas.DrawIcon(pagePieces[3],1.0);
  }
}

defaultproperties
{
    yOffset=440

}
