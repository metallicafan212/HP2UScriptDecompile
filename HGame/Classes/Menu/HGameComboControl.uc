// Metallicafan212:	Scalable combo control
class HGameComboControl based on UWindowComboControl;

var float WX, WY, WW, WH, WEditBoxWidth;

//var Region		WUpRegion,  WDownRegion,  WDisabledRegion,  WOverRegion;


function float GetWidthScale()
{
	return (3.0 / 4.0) / (Root.RealHeight / Root.RealWidth);
}

function ResolutionChanged(float W, float H)
{	
	Super.ResolutionChanged(W, H);
	
	// Metallicafan212:	Say we were resized
	Resized();
	
	ClippingRegion.X = 0;
	ClippingRegion.Y = 0;
	ClippingRegion.W = WinWidth;
	ClippingRegion.H = WinHeight;
	
	EditBox.WinLeft		= 0;
	EditBox.WinWidth 	= WinWidth - 12;
	EditBox.WinHeight	= WinHeight;
	EditBox.Resized();
	
	Button.WinLeft		= 0;
	Button.WinWidth 	= WinWidth - 12;
	Button.Resized();
	
	if(LeftButton != none)
	{
		LeftButton.WinLeft		= 0;
		LeftButton.WinWidth 	= WinWidth - 12;
		LeftButton.Resized();
	}
	
	if(RightButton != none)
	{
		RightButton.WinLeft		= 0;
		RightButton.WinWidth 	= WinWidth - 12;
		RightButton.Resized();
	}
		
}

/*
function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY, HScale;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	OrgX = C.OrgX;
	OrgY = C.OrgY;
	ClipX = C.ClipX;
	ClipY = C.ClipY;

	C.SetOrigin(OrgX + ClippingRegion.X * Root.GUIScale, OrgY + ClippingRegion.Y * Root.GUIScale);
	C.SetClip(Root.RealWidth, Root.RealHeight);//ClippingRegion.W * Root.GUIScale, ClippingRegion.H * Root.GUIScale);

	C.SetPos((X - ClippingRegion.X) * Root.GUIScale, (Y - ClippingRegion.Y) * Root.GUIScale);
	C.DrawTileClipped( Tex, W * Root.GUIScale * HScale, H * Root.GUIScale * HScale, tX, tY, tW, tH);
	
	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
}
*/

function Resized()
{
	local float HScale;
	
	Super.Resized();
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Scale our wanted values
	WinTop		= WY * HScale;
	WinWidth	= WW * HScale;
	WinHeight	= WH * HScale;
	WinLeft		= WX;
	
	EditBoxWidth	= WEditBoxWidth * HScale;
	
	//RegionScale = GetHeightScale();
}

function Created()
{
	Super.Created();
	
	// Metallicafan212:	Save the real X and Y
	WX = WinLeft;
	WY = WinTop;
	WW = WinWidth;
	WH = WinHeight;
	
	WEditBoxWidth = EditBoxWidth;
	
	// Metallicafan212:	Now scale them
	Resized();
}