// Metallicafan212:	Scaled label
class HGameLabelControl based on UWindowLabelControl;

var float WX, WY, WW, WH;

//var Region		WUpRegion,  WDownRegion,  WDisabledRegion,  WOverRegion;

var bool bEnableWidthResize;

var float ResizeRemoval;

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
	local bool bSavedResize;
	
	Super.Resized();
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Scale our wanted values
	//if (bEnableWidthResize)
	//	WinLeft = WX - ((WX * HScale) / 8.0);

	bSavedResize = bEnableWidthResize;
	// Omega: Scale first, then if we need to override it, do that:

	// Omega: Hack for Aligned icons:
	if(AlignmentType != AT_None)
	{
		bEnableWidthResize = False;
	}

	if(Align == TA_Left)
	{
		WinLeft		= AlignButton(WX);
	}
	else if(Align == TA_Center)
	{
		WinLeft		= AlignButton(WX + (WW * 0.5)) - (WW * 0.5);
	}
	else if(Align == TA_Right)
	{
		WinLeft		= AlignButton(WX + (WW)) - (WW);
	}
	
	
	if(bEnableWidthResize)
	{
		WinLeft	= WinLeft + ResizeRemoval - (ResizeRemoval / (HScale * HScale));
	}
	/*if(bEnableWidthResize)
	{
		WinLeft = WX + ResizeRemoval;
		
		WinLeft = WinLeft - (ResizeRemoval / (HScale * HScale));
	}*/
	
	WinTop		= WY * HScale;
	
	//if(Align != TA_Center)
	//	WinWidth	= WW * HScale;
	
	WinHeight	= WH * HScale;

	bEnableWidthResize = bSavedResize;
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
	
	TextY = ((WinHeight - H) * Class'M212HScale'.Static.UWindowGetHeightScale(Root)) / 2;
	
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