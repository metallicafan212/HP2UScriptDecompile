//================================================================================
// HPMenuOptionComboList.
//================================================================================

class HPMenuOptionComboList extends UWindowComboList;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\FEComboListBox.PNG	GROUP=Icons	Name=FEComboListBox COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEComboListLarge.PNG	GROUP=Icons	Name=FEComboListLarge COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEComboListSmall.PNG	GROUP=Icons	Name=FEComboListSmall COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2

var Texture bgImage;

//texture vars for importing -AdamJD
var Texture CListBox;
var Texture CListLarge;
var Texture CListSmall;


function Created()
{
  Super.Created();
}

function BeforePaint (Canvas C, float X, float Y)
{
  local float W;
  local float H;
  local float MaxWidth;
  local int Count;
  local UWindowComboListItem I;
  local float ListX;
  local float ListY;
  local float ExtraWidth;

  C.Font = Root.Fonts[0];
  C.SetPos(0.0,0.0);
  MaxWidth = 187.0;
  ExtraWidth = (HBorder + TextBorder) * 2;
  Count = Items.Count();
  if ( Count > 3 )
  {
    WinHeight = 89.0;
    bgImage = CListLarge;		//Texture'FEComboListLarge';
  } else {
    WinHeight = 61.0;
    bgImage = CListSmall; 		//Texture'FEComboListSmall';
  }
  ItemHeight = (WinHeight - 7) / Count;
  I = UWindowComboListItem(Items.Next);
  // if ( I != None )
  while (I != None)
  {
    TextSize(C,RemoveAmpersand(I.Value),W,H);
    if ( W + ExtraWidth > MaxWidth )
    {
      MaxWidth = W + ExtraWidth;
    }
    I = UWindowComboListItem(I.Next);
    // goto JL00F0;
  }
  WinWidth = MaxWidth;
  ListX = Owner.EditAreaDrawX;
  ListY = Owner.Button.WinTop + Owner.Button.WinHeight;
  VertSB.HideWindow();
  Owner.WindowToGlobal(ListX,ListY,WinLeft,WinTop);
}

function DrawMenuBackground (Canvas C)
{
  DrawClippedTexture(C,0.0,0.0,bgImage);
}

function ComboList_DrawItem (UWindowComboList Combo, Canvas C, float X, float Y, float W, float H, string Text, bool bSelected)
{
  C.DrawColor.R = 255;
  C.DrawColor.G = 255;
  C.DrawColor.B = 255;
  if ( bSelected )
  {
    Combo.DrawStretchedTexture(C,X + 2,Y,W - 11,H,CListBox);	//Texture'FEComboListBox');
    C.DrawColor.R = 0;
    C.DrawColor.G = 0;
    C.DrawColor.B = 0;
  } else {
    C.DrawColor.R = 255;
    C.DrawColor.G = 255;
    C.DrawColor.B = 255;
  }
  Combo.ClipText(C,X + Combo.TextBorder + 2,Y + 5,Text);
}

function DrawItem (Canvas C, UWindowList Item, float X, float Y, float W, float H)
{
  ComboList_DrawItem(self,C,X,Y,W,H,UWindowComboListItem(Item).Value,Selected == Item);
}

//get the imported textures -AdamJD
defaultproperties
{
	CListBox=FEComboListBox
	
	CListLarge=FEComboListLarge
	
	CListSmall=FEComboListSmall
}
