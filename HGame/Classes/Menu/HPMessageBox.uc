//================================================================================
// HPMessageBox.
//================================================================================

class HPMessageBox extends UWindowDialogClientWindow;

// Metallicafan212:	Needed to scale
var float WX, WY, WW, WH;

var string Result;
var HGameButton button1;
var HGameButton button2;
var UWindowWrappedTextArea Message;
var bool bClosing;
var bool bClosedFromTick;
var int FrameCount;
var float TimeOutTime;
var float TimeOut;
var Texture FEMessageBoxBg;
var Texture FENormalButtonTexture;
var Texture FEROButtonTexture;

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
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Scale our wanted values
	WinTop		= WY * HScale;
	WinWidth	= WW * HScale;
	WinHeight	= WH * HScale;
	
	button1.WY 			= 78.0 * HScale;
	button2.WY 			= 78.0 * HScale;
	button2.WinLeft 	= 138.0 * HScale;
	
	button1.Resized();
	button2.Resized();
	
	Message.WinTop		= 27 * HScale;
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

function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY;
	
	local bool bOldNoSmooth;
	
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
	
	C.DrawTileClipped( Tex, W * Root.GUIScale * Class'M212HScale'.Static.UWindowGetHeightScale(Root), H * Root.GUIScale * Class'M212HScale'.Static.UWindowGetHeightScale(Root), tX, tY, tW, tH);
	
	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
	
	C.bNoSmooth = bOldNoSmooth;
}

function Setup (string set_message, string set_button1, optional string set_button2, optional float setTimeOut)
{
	Message = UWindowWrappedTextArea(CreateControl(Class'UWindowWrappedTextArea',26.0,27.0,220.0 - 26,75.0 - 27));
	Message.Clear();
	Message.TextColor.R = 215;
	Message.TextColor.G = 0;
	Message.TextColor.B = 215;
	Message.Align = TA_Center;
	Message.AddText(set_message);
	TimeOut = setTimeOut;
	TimeOutTime = 0.0;
	FrameCount = 0;
	FEMessageBoxBg = Texture(DynamicLoadObject("HP2_Menu.icon.Hp2ConfirmLoad",Class'Texture'));
	FENormalButtonTexture = Texture(DynamicLoadObject("HP2_Menu.icon.Hp2ConfirmYes",Class'Texture'));
	FEROButtonTexture = Texture(DynamicLoadObject("HP2_Menu.icon.Hp2ConfirmYes_Highlight",Class'Texture'));
	if ( set_button2 != "" )
	{
		button1 = HGameButton(CreateControl(Class'HGameButton',18.0,78.0,92.0,25.0));
		button1.UpTexture = FENormalButtonTexture;
		button1.DownTexture = FEROButtonTexture;
		button1.OverTexture = FEROButtonTexture;
		button1.SetText(set_button1);
		button1.bShadowText = True;
		button1.TextColor.R = 255;
		button1.TextColor.G = 255;
		button1.TextColor.B = 255;
		button1.Align = TA_Center;
	}
  
	button2 = HGameButton(CreateControl(Class'HGameButton',138.0,78.0,92.0,25.0));
	button2.UpTexture = FENormalButtonTexture;
	button2.DownTexture = FEROButtonTexture;
	button2.OverTexture = FEROButtonTexture;
	
	if ( set_button2 != "" )
	{
		button2.SetText(set_button2);
	} 
	else 
	{
		button2.SetText(set_button1);
	}
  
	button2.bShadowText = True;
	button2.TextColor.R = 255;
	button2.TextColor.G = 255;
	button2.TextColor.B = 255;
	button2.Align = TA_Center;
	Log("HPMessageBox Setup message=" $ Message.Text $ ", timeOut=" $ string(TimeOut));
	
	Resized();
}

function ScaleAndDraw (Canvas Canvas, float X, float Y, Texture Tex)
{
	local float FX;
	local float fy;

	//FX = Canvas.SizeX / 640.0;
	//fy = Canvas.SizeY / 480.0;
	FX = 1.0;//(4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);//1.0;
	fy = Class'M212HScale'.Static.UWindowGetHeightScale(Root);//1.0;
	DrawStretchedTexture(Canvas,X * FX, Y * FY, Tex.USize * FX, Tex.VSize * fy, Tex);
}

function Paint (Canvas Canvas, float X, float Y)
{
	ScaleAndDraw(Canvas,0.0, 0.0, FEMessageBoxBg);
}

function AfterPaint (Canvas C, float X, float Y)
{
	Super.AfterPaint(C,X,Y);
	if ( TimeOut != 0 )
	{
		FrameCount++;
		if ( FrameCount >= 5 )
		{
			TimeOutTime = GetEntryLevel().TimeSeconds + TimeOut;
			TimeOut = 0.0;
		}
	}
	if ( (TimeOutTime != 0) && (GetEntryLevel().TimeSeconds > TimeOutTime) )
	{
		TimeOutTime = 0.0;
		bClosedFromTick = True;
		Close();
	}
}

function Notify (UWindowDialogControl C, byte E)
{
	local int I;

	Super.Notify(C,E);
  
	if ( C == None )
	{
		return;
	}
  
	switch (E)
	{
		case DE_Click:
			switch (C)
			{
				case button1:
				case button2:
					Result = C.Text;
					Log("HPMessageBox button clicked" @ Result);
					Close();
					break;
			}
	}
	Super.Notify(C,E);
}

function Close (optional bool bByParent)
{
	if (  !bClosing )
	{
		Log("HPMessageBox Close" @ Message.Text $ ", Result=" @ Result);
		bClosing = True;
		Super.Close(bByParent);
		OwnerWindow.WindowDone(self);
	}
}

