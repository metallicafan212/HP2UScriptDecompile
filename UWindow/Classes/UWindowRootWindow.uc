//=============================================================================
// UWindowRootWindow - the root window.
//=============================================================================
class UWindowRootWindow extends UWindowWindow;

#exec TEXTURE IMPORT NAME=MouseCursor FILE=Textures\MouseCursor.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseMove FILE=Textures\MouseMove.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseDiag1 FILE=Textures\MouseDiag1.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseDiag2 FILE=Textures\MouseDiag2.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseNS FILE=Textures\MouseNS.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseWE FILE=Textures\MouseWE.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseHand FILE=Textures\MouseHand.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseHSplit FILE=Textures\MouseHSplit.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseVSplit FILE=Textures\MouseVSplit.bmp GROUP="Icons" FLAGS=2 MIPS=OFF
#exec TEXTURE IMPORT NAME=MouseWait FILE=Textures\MouseWait.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

	//New font for HP menus.
//#exec new TrueTypeFontFactory Name=FontHPMenuLarge FontName="Copperplate Gothic Bold" Height=18 AntiAlias=0 CharactersPerPage=32 
#exec new TrueTypeFontFactory Name=FontHPMenuLarge FontName="Times New Roman" Height=18 AntiAlias=0 CharactersPerPage=32 
#exec new TrueTypeFontFactory Name=FontHPMenuMedium FontName="Times New Roman" Height=14 AntiAlias=0 CharactersPerPage=32 
//#exec new TrueTypeFontFactory Name=FontHPMenuLarge FontName="TiepoloSCITCTT" Height=18 AntiAlias=0 CharactersPerPage=32 


//!! Japanese text (experimental).
//#exec OBJ LOAD FILE=..\Textures\Japanese.utx

var UWindowWindow		MouseWindow;		// The window the mouse is over
var bool				bMouseCapture;
var float				MouseX, MouseY;
var float				OldMouseX, OldMouseY;
var WindowConsole		Console;
var UWindowWindow		FocusedWindow;
var UWindowWindow		KeyFocusWindow;		// window with keyboard focus
var MouseCursor			NormalCursor, MoveCursor, DiagCursor1, HandCursor, HSplitCursor, VSplitCursor, DiagCursor2, NSCursor, WECursor, WaitCursor;
var bool				bQuickKeyEnable;
var UWindowHotkeyWindowList	HotkeyWindows;
// Metallicafan212:	Use a vertical GUI scale
var config float		GUIScale, HGUIScale;
var float				RealWidth, RealHeight;
var Font				Fonts[10];
var UWindowLookAndFeel	LooksAndFeels[20];
var config string		LookAndFeelClass;
var bool				bRequestQuit;
var float				QuitTime;
var bool				bAllowConsole;

var bool				bHideMouse;

// Metallicafan212:	If to force the fake mouse cursor (controller moved!)
var bool				bForceFakeMouse;

//texture import vars -AdamJD
var Texture				MouseCursorTexture;
var Texture				MouseMoveTexture;
var Texture				MouseDiag1Texture;
var Texture				MouseHandTexture;
var Texture				MouseHSplitTexture;
var Texture				MouseVSplitTexture;
var Texture				MouseDiag2Texture;
var Texture				MouseNSTexture;
var Texture				MouseWETexture;
var Texture				MouseWaitTexture;

//font import vars -AdamJD
var Font				HPMenuMediumFont;
var Font				HPMenuLargeFont;


function BeginPlay() 
{
	Root 			= Self;
	MouseWindow 	= Self;
	KeyFocusWindow 	= Self;
}

function UWindowLookAndFeel GetLookAndFeel(String LFClassName)
{
	local int i;
	local class<UWindowLookAndFeel> LFClass;

	LFClass = class<UWindowLookAndFeel>(DynamicLoadObject(LFClassName, class'Class'));

	for(i=0;i<20;i++)
	{
		if(LooksAndFeels[i] == None)
		{
			LooksAndFeels[i] = new LFClass;
			LooksAndFeels[i].Setup();
			return LooksAndFeels[i];
		}

		if(LooksAndFeels[i].Class == LFClass)
			return LooksAndFeels[i];
	}
	Log("Out of LookAndFeel array space!!");
	return None;
}


function Created() 
{
	LookAndFeel = GetLookAndFeel(LookAndFeelClass);
	SetupFonts();

	//NormalCursor.tex = Texture'MouseCursor';
	NormalCursor.tex = MouseCursorTexture;
	NormalCursor.HotX = 0;
	NormalCursor.HotY = 0;
	NormalCursor.WindowsCursor = Console.Viewport.IDC_ARROW;

	//MoveCursor.tex = Texture'MouseMove';
	MoveCursor.tex = MouseMoveTexture;
	MoveCursor.HotX = 8;
	MoveCursor.HotY = 8;
	MoveCursor.WindowsCursor = Console.Viewport.IDC_SIZEALL;
	
	//DiagCursor1.tex = Texture'MouseDiag1';
	DiagCursor1.tex = MouseDiag1Texture;
	DiagCursor1.HotX = 8;
	DiagCursor1.HotY = 8;
	DiagCursor1.WindowsCursor = Console.Viewport.IDC_SIZENWSE;
	
	//HandCursor.tex = Texture'MouseHand';
	HandCursor.tex = MouseHandTexture;
	HandCursor.HotX = 11;
	HandCursor.HotY = 1;
	HandCursor.WindowsCursor = Console.Viewport.IDC_ARROW;

	//HSplitCursor.tex = Texture'MouseHSplit';
	HSplitCursor.tex = MouseHSplitTexture;
	HSplitCursor.HotX = 9;
	HSplitCursor.HotY = 9;
	HSplitCursor.WindowsCursor = Console.Viewport.IDC_SIZEWE;

	//VSplitCursor.tex = Texture'MouseVSplit';
	VSplitCursor.tex = MouseVSplitTexture;
	VSplitCursor.HotX = 9;
	VSplitCursor.HotY = 9;
	VSplitCursor.WindowsCursor = Console.Viewport.IDC_SIZENS;

	//DiagCursor2.tex = Texture'MouseDiag2';
	DiagCursor2.tex = MouseDiag2Texture;
	DiagCursor2.HotX = 7;
	DiagCursor2.HotY = 7;
	DiagCursor2.WindowsCursor = Console.Viewport.IDC_SIZENESW;

	//NSCursor.tex = Texture'MouseNS';
	NSCursor.tex = MouseNSTexture;
	NSCursor.HotX = 3;
	NSCursor.HotY = 7;
	NSCursor.WindowsCursor = Console.Viewport.IDC_SIZENS;

	//WECursor.tex = Texture'MouseWE';
	WECursor.tex = MouseWETexture;
	WECursor.HotX = 7;
	WECursor.HotY = 3;
	WECursor.WindowsCursor = Console.Viewport.IDC_SIZEWE;

	//WaitCursor.tex = Texture'MouseWait';
	WaitCursor.tex = MouseWaitTexture;
	WECursor.HotX = 6;
	WECursor.HotY = 9;
	WECursor.WindowsCursor = Console.Viewport.IDC_WAIT;


	HotkeyWindows = New class'UWindowHotkeyWindowList';
	HotkeyWindows.Last = HotkeyWindows;
	HotkeyWindows.Next = None;
	HotkeyWindows.Sentinel = HotkeyWindows;

	Cursor = NormalCursor;
}

function MoveMouse(float X, float Y)
{
	local UWindowWindow NewMouseWindow;
	local float tx, ty;

	MouseX = X;
	MouseY = Y;

	if(!bMouseCapture)
		NewMouseWindow = FindWindowUnder(X, Y);
	else
		NewMouseWindow = MouseWindow;

	if(NewMouseWindow != MouseWindow)
	{
		MouseWindow.MouseLeave();
		NewMouseWindow.MouseEnter();
		MouseWindow = NewMouseWindow;
	}

	if(MouseX != OldMouseX || MouseY != OldMouseY)
	{
		OldMouseX = MouseX;
		OldMouseY = MouseY;

		MouseWindow.GetMouseXY(tx, ty);
		MouseWindow.MouseMove(tx, ty);
	}
}
function DisableMouse()
{
	bHideMouse=true;
}
function EnableMouse()
{
	bHideMouse=false;
}

function DrawMouse(Canvas C) 
{
	local float X, Y;
	local int nSaveStyle; //got added after the proto -AdamJD

	if(!bForceFakeMouse && bHideMouse)
		return;

	if(!bForceFakeMouse && Console.Viewport.bWindowsMouseAvailable)
	{
		// Set the windows cursor...
		Console.Viewport.SelectedCursor = MouseWindow.Cursor.WindowsCursor;
	}
	else
	{
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;
		C.bNoSmooth = True;

		C.SetPos(MouseX * GUIScale - MouseWindow.Cursor.HotX, MouseY * HGUIScale - MouseWindow.Cursor.HotY);
		C.DrawIcon(MouseWindow.Cursor.tex, 1.0);
		
		//got added after the proto -AdamJD
		if ( MouseWindow.Cursor.tex2 != None )
		{
			nSaveStyle = C.Style;
			C.Style = 3;
			C.SetPos(MouseX * GUIScale + MouseWindow.Cursor.Tex2XOffset, MouseY * HGUIScale + MouseWindow.Cursor.Tex2XOffset);
			C.DrawIcon(MouseWindow.Cursor.tex2,1.0);
			C.Style = nSaveStyle;
		}
	}



	/* DEBUG - show which window mouse is over

	MouseWindow.GetMouseXY(X, Y);
	C.Font = Fonts[F_Normal];

	C.DrawColor.R = 0;
	C.DrawColor.G = 0;
	C.DrawColor.B = 0;
	C.SetPos(MouseX * GUIScale - MouseWindow.Cursor.HotX, MouseY * GUIScale - MouseWindow.Cursor.HotY);
	C.DrawText( GetPlayerOwner().GetItemName(string(MouseWindow))$" "$int(MouseX * GUIScale)$", "$int(MouseY * GUIScale)$" ("$int(X)$", "$int(Y)$")");

	C.DrawColor.R = 255;
	C.DrawColor.G = 255;
	C.DrawColor.B = 0;
	C.SetPos(-1 + MouseX * GUIScale - MouseWindow.Cursor.HotX, -1 + MouseY * GUIScale - MouseWindow.Cursor.HotY);
	C.DrawText( GetPlayerOwner().GetItemName(string(MouseWindow))$" "$int(MouseX * GUIScale)$", "$int(MouseY * GUIScale)$" ("$int(X)$", "$int(Y)$")");

	*/
}

function bool CheckCaptureMouseUp()
{
	local float X, Y;

	if(bMouseCapture) 
	{
		MouseWindow.GetMouseXY(X, Y);
		MouseWindow.LMouseUp(X, Y);
		bMouseCapture = False;
		return True;
	}
	return False;
}

function bool CheckCaptureMouseDown()
{
	local float X, Y;

	if(bMouseCapture) 
	{
		MouseWindow.GetMouseXY(X, Y);
		MouseWindow.LMouseDown(X, Y);
		bMouseCapture = False;
		return True;
	}
	return False;
}


function CancelCapture()
{
	bMouseCapture = False;
}


function CaptureMouse(optional UWindowWindow W)
{
	bMouseCapture = True;
	if(W != None)
		MouseWindow = W;
	//Log(MouseWindow.Class$": Captured Mouse");
}

function Texture GetLookAndFeelTexture()
{
	Return LookAndFeel.Active;
}

function bool IsActive()
{
	Return True;
}

function AddHotkeyWindow(UWindowWindow W)
{
//	Log("Adding hotkeys for "$W);
	UWindowHotkeyWindowList(HotkeyWindows.Insert(class'UWindowHotkeyWindowList')).Window = W;
}

function RemoveHotkeyWindow(UWindowWindow W)
{
	local UWindowHotkeyWindowList L;

//	Log("Removing hotkeys for "$W);

	L = HotkeyWindows.FindWindow(W);
	if(L != None)
		L.Remove();
}


function WindowEvent(WinMessage Msg, Canvas C, float X, float Y, int Key) 
{
	// Metallicafan212:	Userp the xinput keys
	switch(Key)
	{
		// Metallicafan212:	A to go forwards, B to right mouse?
		//					TODO! Don't hardcode these, fucker!
		//					Move the EInputKey def into Object?
		//case IK_XBA:
		case 0xD2:
			//Key = 1;
			//log("XB A");
			if(Msg == WM_KeyUp)
			{
				Msg = WM_LMouseUp;
			}
			Super.WindowEvent(Msg, C, X, Y, 1);
			break;
		//case IK_XBB:
		case 0xD3:
			//Key = 2;
			//log("XB B");
			if(Msg == WM_KeyUp)
			{
				Msg = WM_RMouseUp;
			}
			Super.WindowEvent(Msg, C, X, Y, 2);
			break;
	}

	switch(Msg) 
	{
		case WM_KeyDown:
			if(HotKeyDown(Key, X, Y))
				return;
			break;
		case WM_KeyUp:
			if(HotKeyUp(Key, X, Y))
				return;
			break;
	}

	Super.WindowEvent(Msg, C, X, Y, Key);
}


function bool HotKeyDown(int Key, float X, float Y)
{
	local UWindowHotkeyWindowList l;

	l = UWindowHotkeyWindowList(HotkeyWindows.Next);
	while(l != None) 
	{
		if(l.Window != Self && l.Window.HotKeyDown(Key, X, Y)) return True;
		l = UWindowHotkeyWindowList(l.Next);
	}

	return False;
}

function bool HotKeyUp(int Key, float X, float Y)
{
	local UWindowHotkeyWindowList l;

	l = UWindowHotkeyWindowList(HotkeyWindows.Next);
	while(l != None) 
	{
		if(l.Window != Self && l.Window.HotKeyUp(Key, X, Y)) return True;
		l = UWindowHotkeyWindowList(l.Next);
	}

	return False;
}

function CloseActiveWindow()
{
	if(ActiveWindow != None)
		ActiveWindow.EscClose();
	else
		Console.CloseUWindow();
}

function Resized()
{
	ResolutionChanged(WinWidth, WinHeight);
}

function SetScale(float NewScale)
{
	local string langCode;

	WinWidth = RealWidth / NewScale;
	WinHeight = RealHeight / NewScale;

	GUIScale = NewScale;
	
	// Metallicafan212:	Because this is automatic...
	//HGUIScale = RealHeight / 480.0;
	HGUIScale = GUIScale;

	ClippingRegion.X = 0;
	ClippingRegion.Y = 0;
	ClippingRegion.W = WinWidth;
	ClippingRegion.H = WinHeight;

	langCode=GetLanguage();

	switch(caps(langCode))
	{
		/*
		case "SIM":
		case "CHI":
		case "TRA":
		case "KOR":
		case "THA":
		case "JAP":
		case "POL":		//
			break;
		case "ENG":		//
		case "INT":		//
		case "GER":
		*/
	
		//got updated between proto and retail -AdamJD
		case "SIM":
		case "CHI":
		case "TRA":
		case "KOR":
		case "THA":
		case "JAP":
		case "POL":
		case "GRE":
		case "RUS":
		case "CHE":
		case "CZE":
		break;
		case "ENG":
		case "INT":
		case "GER":
		
		default:	
			SetupFonts();
			break;
	}

	Resized();
}
	//same as Canvas.SetPos but accounts for GUIScale
final function SetPosScaled(Canvas c, float X, float Y )
{
	c.SetPos(X * Root.GUIScale, Y * Root.HGUIScale);//Y*Root.GUIScale);
}

final function DrawTileScaled(Canvas c, texture Tex, float XL, float YL, float U, float V, float UL, float VL )
{
	c.DrawTile(Tex,
		//XL,YL,
		XL*Root.GUIScale, YL * Root.HGUIScale,//Root.GUIScale,

		U,V,
		//U*Root.GUIScale,V*Root.GUIScale,

		UL,VL
		//UL*Root.GUIScale,VL*Root.GUIScale
		);
}

function SetupFonts()
{
	//!! Japanese text (experimental).

	/*if( true )
	{
		Fonts[F_Normal]    = Font(DynamicLoadObject("Japanese.Japanese", class'Font'));
		Fonts[F_Bold]      = Font(DynamicLoadObject("Japanese.Japanese", class'Font'));
		Fonts[F_Large]     = Font(DynamicLoadObject("Japanese.Japanese", class'Font'));
		Fonts[F_LargeBold] = Font(DynamicLoadObject("Japanese.Japanese", class'Font'));
		return;
	}*/
	if(GUIScale == 2)
	{
		Fonts[F_Normal] = Font(DynamicLoadObject("UWindowFonts.Tahoma20", class'Font'));
		Fonts[F_Bold] = Font(DynamicLoadObject("UWindowFonts.TahomaB20", class'Font'));
		Fonts[F_Large] = Font(DynamicLoadObject("UWindowFonts.Tahoma30", class'Font'));
		Fonts[F_LargeBold] = Font(DynamicLoadObject("UWindowFonts.TahomaB30", class'Font'));

		//Fonts[F_HPMenuMedium] = Font'FontHPMenuMedium';
		//Fonts[F_HPMenuLarge] = Font'FontHPMenuLarge';
		
		Fonts[F_HPMenuMedium] = HPMenuMediumFont;
		Fonts[F_HPMenuLarge] = HPMenuLargeFont;
	}
	else
	{
		Fonts[F_Normal] = Font(DynamicLoadObject("UWindowFonts.Tahoma10", class'Font'));
		Fonts[F_Bold] = Font(DynamicLoadObject("UWindowFonts.TahomaB10", class'Font'));
		Fonts[F_Large] = Font(DynamicLoadObject("UWindowFonts.Tahoma20", class'Font'));
		Fonts[F_LargeBold] = Font(DynamicLoadObject("UWindowFonts.TahomaB20", class'Font'));

		//Fonts[F_HPMenuMedium] = Font'FontHPMenuMedium';
		//Fonts[F_HPMenuLarge] = Font'FontHPMenuLarge';
		
		Fonts[F_HPMenuMedium] = HPMenuMediumFont;
		Fonts[F_HPMenuLarge] = HPMenuLargeFont;
	}	
}

function ChangeLookAndFeel(string NewLookAndFeel)
{
	LookAndFeelClass = NewLookAndFeel;
	SaveConfig();

	// Completely restart UWindow system on the next paint
	Console.ResetUWindow();
}

function HideWindow()
{
}

function SetMousePos(float X, float Y)
{
	Console.MouseX = X;
	Console.MouseY = Y;
}

function QuitGame()
{
	bRequestQuit = True;
	QuitTime = 0;
	NotifyQuitUnreal();
}

function DoQuitGame()
{
	SaveConfig();
	Console.SaveConfig();
	Console.ViewPort.Actor.SaveConfig();
	Close();
	Console.Viewport.Actor.ConsoleCommand("exit");
}

function Tick(float Delta)
{
	if(bRequestQuit)
	{
		// Give everything time to close itself down (ie sockets).
		if(QuitTime > 0.25)
			DoQuitGame();
		QuitTime += Delta;
	}

	Super.Tick(Delta);
}

defaultproperties
{
	GUIScale=1
	LookAndFeelClass="UWindow.UWindowWin95LookAndFeel"
	bAllowConsole=True
	
	//find the textures -AdamJD
	MouseCursorTexture=MouseCursor
	MouseMoveTexture=MouseMove
	MouseDiag1Texture=MouseDiag1
	MouseDiag2Texture=MouseDiag2
	MouseNSTexture=MouseNS
	MouseWETexture=MouseWE
	MouseHandTexture=MouseHand
	MouseHSplitTexture=MouseHSplit
	MouseVSplitTexture=MouseVSplit
	MouseWaitTexture=MouseWait
	
	//find the fonts -AdamJD
	HPMenuLargeFont=FontHPMenuLarge
	HPMenuMediumFont=FontHPMenuMedium
} 