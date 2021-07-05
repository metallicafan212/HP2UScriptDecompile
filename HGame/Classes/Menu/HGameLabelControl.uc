// Metallicafan212:	Scaled label
class HGameLabelControl based on UWindowLabelControl;

var float WX, WY, WW, WH;

//var Region		WUpRegion,  WDownRegion,  WDisabledRegion,  WOverRegion;

// Metallicafan212:	Get the H Scale
function float GetHeightScale()
{
	return (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);
}

function float GetWidthScale()
{
	return (3.0 / 4.0) / (Root.RealHeight / Root.RealWidth);
}

function ResolutionChanged(float W, float H)
{
	Super.ResolutionChanged(W, H);
	
	// Metallicafan212:	Say we were resized
	Resized();
}

function Resized()
{
	local float HScale;
	
	Super.Resized();
	
	HScale = GetHeightScale();
	
	// Metallicafan212:	Scale our wanted values
	//WinLeft		= WX * (HScale * 2);
	WinTop		= WY * HScale;
	
	//if(Align != TA_Center)
	//	WinWidth	= WW * HScale;
	
	WinHeight	= WH * HScale;
}

function Created()
{
	Super.Created();
	
	// Metallicafan212:	Save the real X and Y
	WX = WinLeft;
	WY = WinTop;
	WW = WinWidth;
	WH = WinHeight;
	
	// Metallicafan212:	Now scale them
	Resized();
}

function BeforePaint(Canvas C, float X, float Y)
{
	local float W, H;
	
	// Implemented in a child class

	Super(UWindowDialogControl).BeforePaint(C, X, Y);
	
	TextSize(C, Text, W, H);
	
	WinHeight 	= H+1;
	//WinWidth 	= W+1;
	
	//W *= GetHeightScale();
	
	TextY = ((WinHeight - H) * GetHeightScale()) / 2;
	
	switch (Align)
	{
		case TA_Left:
			break;
		case TA_Center:
			TextX = (WinWidth - W) / 2;
			break;
		case TA_Right:
			TextX = (WinWidth - W);
			break;
	}	
}

function Paint(Canvas C, float X, float Y)
{
	if(Text != "")
	{
		C.Font = Root.Fonts[Font];

		if(bShadowText)
		{
			C.DrawColor.R = 0;
			C.DrawColor.G = 0;
			C.DrawColor.B = 0;
			ClipText(C, TextX+1, TextY+1, Text);
		}

		C.DrawColor = TextColor;
		ClipText(C, TextX, TextY, Text);
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;
	}
}