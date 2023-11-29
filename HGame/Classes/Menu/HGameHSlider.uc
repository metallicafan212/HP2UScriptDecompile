// Metallicafan212:	Scalable H Slider
class HGameHSlider based on UWindowHSliderControl;

var float WX, WY, WW, WH;

function float GetWidthScale()
{
	return (3.0 / 4.0) / (Root.RealHeight / Root.RealWidth);
}

function LMouseDown(float X, float Y)
{
	local float HScale;
	
	Super.LMouseDown(X, Y);
	
	// Metallicafan212:	Scale
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	X /= HScale;
	
	
	if((X >= TrackStart) && (X <= TrackStart + TrackWidth)) 
	{
		bSliding = True;
		Root.CaptureMouse();
	}

	if(X < TrackStart && X > SliderDrawX)
	{
		if(Step != 0)
			SetValue(Value - Step);
		else
			SetValue(Value - 1);
	}
	
	if(X > TrackStart + TrackWidth && X < SliderDrawX + SliderWidth)
	{
		if(Step != 0)
			SetValue(Value + Step);
		else
			SetValue(Value + 1);
	}
	
}

function MouseMove(float X, float Y)
{
	local float HScale;
	
	Super.MouseMove(X, Y);
	
	// Metallicafan212:	Scale
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	X /= HScale;
	
	if(bSliding && bMouseDown)
	{
		SetValue((((X - SliderDrawX) / (SliderWidth - TrackWidth)) * (MaxValue - MinValue)) + MinValue, bNoSlidingNotify);
	}
	else
		bSliding = False;
}

function ResolutionChanged(float W, float H)
{
	Super.ResolutionChanged(W, H);
	
	// Metallicafan212:	Say we were resized
	Resized();
}

function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY;
	local float HScale;
	local bool bOldNoSmooth;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Disable no smooth
	bOldNoSmooth 	= C.bNoSmooth;
	C.bNoSmooth 	= false;

	OrgX 			= C.OrgX;
	OrgY 			= C.OrgY;
	ClipX 			= C.ClipX;
	ClipY 			= C.ClipY;

	C.SetOrigin(OrgX + ClippingRegion.X * Root.GUIScale, OrgY + ClippingRegion.Y * Root.GUIScale);
	C.SetClip(ClippingRegion.W * Root.GUIScale, ClippingRegion.H * Root.GUIScale);

	C.SetPos((X - ClippingRegion.X) * Root.GUIScale, (Y - ClippingRegion.Y) * Root.GUIScale);
	C.DrawTileClipped( Tex, W * Root.GUIScale * HScale, H * Root.GUIScale * HScale, tX, tY, tW, tH);
	
	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
	
	C.bNoSmooth 	= bOldNoSmooth;
}

function BeforePaint(Canvas C, float X, float Y)
{
	local float W, H;
	local float HScale;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Skip
	Super(UWindowDialogControl).BeforePaint(C, X, Y);
	
	TextSize(C, Text, W, H);
	WinHeight = H+1;
	
	switch(Align)
	{
		case TA_Left:
			SliderDrawX = (WinWidth - SliderWidth) * HScale;
			TextX = 0;
			break;
		case TA_Right:
			SliderDrawX = 0;	
			TextX 		= (WinWidth - W) * HScale;
			break;
		case TA_Center:
			SliderDrawX = ((WinWidth - SliderWidth) / 2) * HScale;
			TextX 		= ((WinWidth - W) / 2) * HScale;
			break;
	}

	SliderDrawY = ((WinHeight - 2) * HScale) / 2;
	TextY 		= ((WinHeight - H) * HScale) / 2;

	TrackStart = SliderDrawX + (SliderWidth - TrackWidth) * ((Value - MinValue) / (MaxValue - MinValue));
}

function Resized()
{
	local float HScale;
	
	Super.Resized();
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Scale our wanted values
	WinTop		= WY * HScale;
	WinWidth	= WW * HScale;
	WinHeight	= WH * HScale;

	// Omega: Align our button based on its alignment type
	WinLeft		= AlignButton(WX);
	
	//RegionScale = GetHeightScale();

	/*
	// Metallicafan212:	Scale the region
	UpRegion.W			= WUpRegion.W * HScale;
	UpRegion.H			= WUpRegion.H * HScale;
	UpRegion.Y 			= WUpRegion.Y * HScale;
	
	DownRegion.W		= WDownRegion.W * HScale;
	DownRegion.H		= WDownRegion.H * HScale;
	DownRegion.Y 		= WDownRegion.Y * HScale;
	
	DisabledRegion.W	= WDisabledRegion.W * HScale;
	DisabledRegion.H	= WDisabledRegion.H * HScale;
	DisabledRegion.Y 	= WDisabledRegion.Y * HScale;
	
	OverRegion.W		= WOverRegion.W * HScale;
	OverRegion.H		= WOverRegion.H * HScale;
	OverRegion.Y 		= WOverRegion.Y * HScale;
	*/
}

function Created()
{
	Super.Created();
	
	// Metallicafan212:	Save the real X and Y
	WX = WinLeft;
	WY = WinTop;
	WW = WinWidth;
	WH = WinHeight;
	
	/*
	WUpRegion 			= UpRegion;
	WDownRegion			= DownRegion;
	WDisabledRegion		= DisabledRegion;
	WOverRegion			= OverRegion;
	*/
	
	// Metallicafan212:	Now scale them
	Resized();
}