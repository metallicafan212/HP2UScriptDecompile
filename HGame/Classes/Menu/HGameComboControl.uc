// Metallicafan212:	Scalable combo control
class HGameComboControl based on UWindowComboControl;

var float WX, WY, WW, WH, WEditBoxWidth;

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

function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY;

	OrgX = C.OrgX;
	OrgY = C.OrgY;
	ClipX = C.ClipX;
	ClipY = C.ClipY;

	C.SetOrigin(OrgX + ClippingRegion.X * Root.GUIScale, OrgY + ClippingRegion.Y * Root.GUIScale);
	C.SetClip(Root.RealWidth, Root.RealHeight);//ClippingRegion.W * Root.GUIScale, ClippingRegion.H * Root.GUIScale);

	C.SetPos((X - ClippingRegion.X) * Root.GUIScale, (Y - ClippingRegion.Y) * Root.GUIScale);
	C.DrawTileClipped( Tex, W * Root.GUIScale * GetHeightScale(), H * Root.GUIScale * GetHeightScale(), tX, tY, tW, tH);
	
	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
}

function Resized()
{
	local float HScale;
	
	Super.Resized();
	
	HScale = GetHeightScale();
	
	// Metallicafan212:	Scale our wanted values
	WinTop		= WY * HScale;
	WinWidth	= WW * HScale;
	WinHeight	= WH * HScale;
	
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
	
	/*
	WUpRegion 			= UpRegion;
	WDownRegion			= DownRegion;
	WDisabledRegion		= DisabledRegion;
	WOverRegion			= OverRegion;
	*/
	
	// Metallicafan212:	Now scale them
	Resized();
}