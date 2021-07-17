//================================================================================
// HPMenuRaisedButton.
//================================================================================

class HPMenuRaisedButton extends HGameButton;

var int textOffsetX;

function Created ()
{
	Super.Created();
}

function BeforePaint (Canvas C, float X, float Y)
{
	local float W;
	local float H;

	WinWidth = 180.0;
	WinHeight = 24.0;
	TextSize(C,Text,W,H);
	
	// Metallicafan212:	Scale it
	TextY = ((WinHeight - H) * Class'M212HScale'.Static.UWindowGetHeightScale(Root)) / 2;
	switch (Align)
	{
		// case 0:
		case TextAlign.TA_Left:
			TextX = textOffsetX;
			break;
		
		// case 1:
		case TextAlign.TA_Right:
			TextX = WinWidth - W - textOffsetX;
			break;
    
		// case 2:
		case TextAlign.TA_Center:
			TextX = (WinWidth - W) / 2;
			break;
		default:
	}
}

function Paint (Canvas C, float X, float Y)
{
	Super.Paint(C,X,Y);
}

defaultproperties
{
    textOffsetX=11

}
