// Metallicafan212:	Scalable Combo list
class HGameComboList based on UWindowComboList;

var float WX, WY, WW, WH;
var float WVBorder;

//var Region		WUpRegion,  WDownRegion,  WDisabledRegion,  WOverRegion;


function float GetWidthScale()
{
	return (3.0 / 4.0) / (Root.RealHeight / Root.RealWidth);
}

function BeforePaint(Canvas C, float X, float Y)
{
	local float W, H, MaxWidth;
	local int Count;
	local UWindowComboListItem I;
	local float ListX, ListY;
	local float ExtraWidth;
	local float HScale;
	
	HScale = class'M212HScale'.Static.UWindowGetHeightScale(Root);
		
	C.Font = Root.Fonts[F_Normal];
	C.SetPos(0, 0);

	MaxWidth = Owner.EditBoxWidth;
	ExtraWidth = ((HBorder + TextBorder) * 2);

	Count = Items.Count();
	if(Count > MaxVisible)
	{
		ExtraWidth += LookAndFeel.Size_ScrollbarWidth;
		
		// Metallicafan212:	Fix too many showing up
		WinHeight = ((ItemHeight * MaxVisible) + (VBorder * 2)) * HScale;
	}
	else
	{
		//log("Count is " $ ", which is less than the maxvisible of " $ MaxVisible);
		VertSB.Pos = 0;
		WinHeight = (ItemHeight * Count) + (VBorder * 2);
	}

	for( I = UWindowComboListItem(Items.Next);I != None; I = UWindowComboListItem(I.Next) )
	{
		TextSize(C, RemoveAmpersand(I.Value), W, H);
		if(W + ExtraWidth > MaxWidth)
			MaxWidth = W + ExtraWidth;
	}

	WinWidth = MaxWidth;

	ListX = Owner.EditAreaDrawX + Owner.EditBoxWidth - WinWidth;
	ListY = Owner.Button.WinTop + Owner.Button.WinHeight;

	if(Count > MaxVisible)
	{
		//log("Showing scrollbar!");
		
		VertSB.ShowWindow();
		VertSB.SetRange(0, Count, MaxVisible);
		VertSB.WinLeft 		= WinWidth - LookAndFeel.Size_ScrollbarWidth - HBorder;
		VertSB.WinTop 		= HBorder;
		VertSB.WinWidth 	= LookAndFeel.Size_ScrollbarWidth;
		VertSB.WinHeight 	= WinHeight - 2*VBorder;
	}
	else
	{
		//log("Hiding scrollbar!");
		VertSB.HideWindow();
	}

	Owner.WindowToGlobal(ListX, ListY, WinLeft, WinTop);
}

function SetSelected(float X, float Y)
{
	local UWindowComboListItem NewSelected, Item;
	local int i, Count;
	
	// Metallicafan212:	Height scaling
	local float HScale, LocalPos;
	
	HScale = class'M212HScale'.Static.UWindowGetHeightScale(Root);

	/*
	Count = 0;
	for( Item = UWindowComboListItem(Items.Next);Item != None; Item = UWindowComboListItem(Item.Next) )
		Count++;

	i = (Y - (VBorder * HScale)) / ((ItemHeight * HScale) + (VertSB.Pos * HScale));

	if(i < 0)
		i = 0;

	if(i >= VertSB.Pos + Min(Count, MaxVisible))
		i = VertSB.Pos + Min(Count, MaxVisible) - 1;

	NewSelected = UWindowComboListItem(Items.FindEntry(i));

	if(NewSelected != Selected)
	{
		if(NewSelected == None) 
			Selected = None;
		else
			Selected = NewSelected;
	}	
	*/
	
	// Metallicafan212:	Use the scroll bar to determine the selected index
	//					More stable
	//i = Round((Y / ItemHeight) );/// HScale);
	
	//LocalPos -= VertSB.Pos * ItemHeight;
	
	i = (Y - (VBorder * HScale)) / ((ItemHeight * HScale)); //+ (VertSB.Pos * HScale));
	
	Count = -VertSB.Pos;
	for( Item = UWindowComboListItem(Items.Next);Item != None; Item = UWindowComboListItem(Item.Next) )
	{		
		if(Count == i)
			break;
		
		Count++;
	}
	
	// Metallicafan212:	This should work better, hopefully...
	if(Count > i)
		Selected = None;
	else
		Selected = Item;
	
	//log("i wanted is " $ i);
	
	//i += VertSB.Pos;
	
	/*
	NewSelected = UWindowComboListItem(Items.FindEntry(i));

	if(NewSelected != Selected)
	{
		if(NewSelected == None) 
			Selected = None;
		else
			Selected = NewSelected;
	}	
	*/
}

function ResolutionChanged(float W, float H)
{
	Super.ResolutionChanged(W, H);
	
	// Metallicafan212:	Say we were resized
	Resized();
}

function AddItem(string Value, optional string Value2, optional int SortWeight)
{
	local UWindowComboListItem I;
	
	I = UWindowComboListItem(Items.Append(class'UWindowComboListItem'));
	I.Value = Value;
	I.Value2 = Value2;
	I.SortWeight = SortWeight;
	
	//log("Values are " $ Value $ " " $ Value2);
}

function MouseMove(float X, float Y)
{
	local float HScale;
	
	Super.MouseMove(X, Y);
	
	// Metallicafan212:	Scale
	//HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	//Y *= HScale;
	
	if(Y > WinHeight) VertSB.Scroll(1);
	if(Y < 0) VertSB.Scroll(-1);

	SetSelected(X, Y);

	FocusWindow();
}

function Paint(Canvas C, float X, float Y)
{
	local int Count;
	local UWindowComboListItem I;
	local float HScale;
	
	local float HeightLeft;
	
	// Metallicafan212:	Keep track of the height left
	HeightLeft = WinHeight;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	DrawMenuBackground(C);
	
	Count = 0;

	for( I = UWindowComboListItem(Items.Next);I != None; I = UWindowComboListItem(I.Next) )
	{
		if(VertSB.bWindowVisible)
		{			
			if(Count >= VertSB.Pos)
			{
				DrawItem(C, I, HBorder * HScale, (VBorder + (ItemHeight * (Count - VertSB.Pos))) * HScale, WinWidth - (2 * HBorder) - VertSB.WinWidth, ItemHeight);
				
				// Metallicafan212:	Break when there's not any height left
				HeightLeft -= ItemHeight;
			
				if(HeightLeft <= 0)
					break;
			}
		}
		else
			DrawItem(C, I, HBorder * HScale, (VBorder + (ItemHeight * Count)) * HScale, WinWidth - (2 * HBorder), ItemHeight);
		Count++;
	}
}

function ClipText(Canvas C, float X, float Y, coerce string S, optional bool bCheckHotkey)
{
	local float OrgX, OrgY, ClipX, ClipY;

	OrgX = C.OrgX;
	OrgY = C.OrgY;
	ClipX = C.ClipX;
	ClipY = C.ClipY;

	C.SetOrigin(OrgX + ClippingRegion.X*Root.GUIScale, OrgY + ClippingRegion.Y * Root.HGUIScale);//Root.GUIScale);
	
	// Metallicafan212:	I don't want to bother...
	C.SetClip(Root.RealWidth, Root.RealHeight);//ClippingRegion.W*Root.GUIScale, ClippingRegion.H * Root.HGUIScale);//Root.GUIScale);

	C.SetPos((X - ClippingRegion.X) * Root.GUIScale, (Y - ClippingRegion.Y) * Root.HGUIScale);//Root.GUIScale);
	C.DrawTextClipped(S, bCheckHotKey);

	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
}

function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY;
	
	local bool bOldNoSmooth;
	local float HScale;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Disable no smooth
	bOldNoSmooth = C.bNoSmooth;
	C.bNoSmooth = false;

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
	
	C.bNoSmooth = bOldNoSmooth;
}

function Resized()
{
	local float HScale;
	
	Super.Resized();
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Scale our wanted values
	WinTop				= WY * HScale;
	WinWidth			= WW * HScale;
	WinHeight			= WH * HScale;

	// Omega: Align our button based on its alignment type
	WinLeft		= AlignButton(WX);
	
	VertSB.WinHeight 	= WinHeight - 2 * VBorder;
	
	//VBorder		= WVBorder * HScale;
}

function Created()
{
	Super.Created();
	
	// Metallicafan212:	Save the real X and Y
	WX = WinLeft;
	WY = WinTop;
	WW = WinWidth;
	WH = WinHeight;
	
	//WVBorder = VBorder;
	
	// Metallicafan212:	Now scale them
	Resized();
	
	VertSB.ShowWindow();
}

DefaultProperties
{
	MaxVisible=4
}