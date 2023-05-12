//=============================================================================
// WindowConsole - console replacer to implement UWindow UI System
//=============================================================================
class WindowConsole extends Console;

var UWindowRootWindow	Root;
var() config string		RootWindow;

var float				OldClipX;
var float				OldClipY;
var bool				bCreatedRoot;
var float				MouseX;
var float				MouseY;

// Metallicafan212:	Last mouse pos
var float				LastMouseX;
var float				LoastMouseY;

var class<UWindowConsoleWindow> ConsoleClass;
var config float		MouseScale;
var config bool			ShowDesktop;
var config bool			bShowConsole;
var bool				bBlackout;
var bool				bUWindowType;

var bool				bUWindowActive;
var bool				bQuickKeyEnable;
var bool				bLocked;
var bool				bLevelChange;

// Metallicafan212:	Allow the menu to run exec functions
var bool				bEnableExec;

var string				OldLevel;
var globalconfig byte	ConsoleKey;

var config EInputKey	UWindowKey;

var UWindowConsoleWindow ConsoleWindow;

// Metallicafan212: Save the last deltatime
var float				LastDeltaT;

// Metallicafan212:	Controller menu scale
var globalconfig float	ControllerMouseScale;

// Metallicafan212:	So we can call the KW bullshit from UWindow
exec function TogglePauseMenu() {}

exec function ToggleMapMenu() {}

function ResetUWindow()
{
	if(Root != None)
		Root.Close();
	Root = None;
	bCreatedRoot = False;
	ConsoleWindow = None;
	bShowConsole = False;
	CloseUWindow();
}

event bool KeyEvent( EInputKey Key, EInputAction Action, FLOAT Delta )
{
	local byte k;
	k = Key;
	switch(Action)
	{
	case IST_Press:
		switch(k)
		{
		case EInputKey.IK_Escape:
			log("Fucking UWindow: " $ bLocked);
			if (bLocked)
				return true;
				
			
			
			bQuickKeyEnable = False;
			LaunchUWindow();
			return true;
		case ConsoleKey:
			if (bLocked)
				return true;

			bQuickKeyEnable = True;
			LaunchUWindow();
			if(!bShowConsole)
				ShowConsole();
			return true;
		}
		break;
	}

	return False; 
	//!! because of ConsoleKey
	//!! return Super.KeyEvent(Key, Action, Delta);
}

function ShowConsole()
{
	return;	//overridden in HPConsole.

	if(!Root.bAllowConsole)
		return;
		
	bShowConsole = true;
	if(bCreatedRoot)
		ConsoleWindow.ShowWindow();
}

function HideConsole()
{
	ConsoleLines = 0;
	bShowConsole = false;
	if (ConsoleWindow != None)
		ConsoleWindow.HideWindow();
}

event Tick( float Delta )
{
	Super.Tick(Delta);

	if(bLevelChange && Root != None && string(Viewport.Actor.Level) != OldLevel)
	{
		OldLevel = string(Viewport.Actor.Level);
		// if this is Entry, we could be falling through to another level...
		if(Viewport.Actor.Level != Viewport.Actor.GetEntryLevel())
			bLevelChange = False;
		Root.NotifyAfterLevelChange();
	}
	
	LastDeltaT = Delta;
}

state UWindow
{
	event Tick( float Delta )
	{
		Global.Tick(Delta);
		if(Root != None)
			Root.DoTick(Delta);
	}

	event PostRender( canvas Canvas )
	{
		if( bTimeDemo )
		{	
			TimeDemoCalc();
			TimeDemoRender( Canvas );
		}

		if(Root != None)
			Root.bUWindowActive = True;
		RenderUWindow( Canvas );
	}

	event bool KeyType( EInputKey Key )
	{
		if (Root != None)
			Root.WindowEvent(WM_KeyType, None, MouseX, MouseY, Key);
		return True;
	}

	event bool KeyEvent( EInputKey Key, EInputAction Action, FLOAT Delta )
	{
		local byte k;
		k = Key;

		switch (Action)
		{
		case IST_Release:
			switch (k)
			{
			case EInputKey.IK_LeftMouse:
				if(Root != None) 
					Root.WindowEvent(WM_LMouseUp, None, MouseX, MouseY, k);
				break;
			case EInputKey.IK_RightMouse:
				if(Root != None)
					Root.WindowEvent(WM_RMouseUp, None, MouseX, MouseY, k);
				break;
			case EInputKey.IK_MiddleMouse:
				if(Root != None)
					Root.WindowEvent(WM_MMouseUp, None, MouseX, MouseY, k);
				break;
			case EInputKey.IK_XBB:
				TogglePauseMenu();
				break;
			default:
				if(Root != None)
					Root.WindowEvent(WM_KeyUp, None, MouseX, MouseY, k);
				break;
			}
			break;

		case IST_Press:
			switch (k)
			{
			case EInputKey.IK_F9:	// Screenshot
				return Global.KeyEvent(Key, Action, Delta);
				break;
			case ConsoleKey:
				if (bShowConsole)
				{
					HideConsole();
					if(bQuickKeyEnable)
						CloseUWindow();
				}
				else
				{
					if(Root.bAllowConsole)
						ShowConsole();
					else
						Root.WindowEvent(WM_KeyDown, None, MouseX, MouseY, k);
				}
				break;
			case EInputKey.IK_Escape:
				log("Escape");
				if (bShowConsole)
				{
					HideConsole();
					if(bQuickKeyEnable)
						CloseUWindow();
				}				
				//else if(Root != None)
				//	Root.CloseActiveWindow();
				break;
				
			case EInputKey.IK_LeftMouse:
				if(Root != None)
				{
					Root.WindowEvent(WM_LMouseDown, None, MouseX, MouseY, k);
					return true;
				}
				break;
			case EInputKey.IK_RightMouse:
				if(Root != None)
				{
					Root.WindowEvent(WM_RMouseDown, None, MouseX, MouseY, k);
					return true;
				}
				break;
			// Metallicafan212:	A to go forwards, B to right mouse?
			case EInputKey.IK_XBA:
				if(Root != None)
				{
					Root.WindowEvent(WM_LMouseDown, None, MouseX, MouseY, EInputKey.IK_LeftMouse);
					return true;
				}
				break;
			case EInputKey.IK_XBB:
				//if(Root != None)
				//{
				//	Root.WindowEvent(WM_KeyDown, None, MouseX, MouseY, EInputKey.IK_Escape);
				//	return true;
				//}
				//KeyEvent(IK_Escape, IST_Press, 
				/*
				if(Root != None)
				{
					Root.WindowEvent(WM_RMouseDown, None, MouseX, MouseY, EInputKey.IK_RightMouse);
					return true;
				}
				*/
				//TogglePauseMenu();
				break;
				
			case EInputKey.IK_MiddleMouse:
				if(Root != None)
					Root.WindowEvent(WM_MMouseDown, None, MouseX, MouseY, k);
				break;
			default:
				if(Root != None)
					Root.WindowEvent(WM_KeyDown, None, MouseX, MouseY, k);
				break;
			}
			break;
		case IST_Axis:
			switch (Key)
			{
				case IK_MouseX:
					MouseX = MouseX + (MouseScale * Delta);
					Root.bForceFakeMouse = false;
					break;
				case IK_MouseY:
					MouseY = MouseY - (MouseScale * Delta);
					Root.bForceFakeMouse = false;
					break;			
				
				// Metallicafan212:	Controller support
				//					Allow both sticks to do this
				case IK_XBRightStickX:
				case IK_XBLeftStickX:
					if(Delta != 0.0)
					{
						MouseX = MouseX + (Delta * LastDeltaT * ControllerMouseScale);
						Root.bForceFakeMouse = true;
						
						return true;
					}
					break;
				
				case IK_XBRightStickY:
				case IK_XBLeftStickY:
					if(Delta != 0.0)
					{
						MouseY = MouseY - (Delta * LastDeltaT * ControllerMouseScale);
						Root.bForceFakeMouse = true;
						
						return true;
					}
					break;	
			
			}
		default:
			break;
		}

		//return true;
		// Metallicafan212:	Default to false so that we can run exec functions in menu
		if(bShowConsole)
			return true;
		else if(bEnableExec)
			return false;
		else
			return true;
	}
}

function ToggleUWindow()
{
}

function LaunchUWindow(optional bool bPause)
{
	local int i;

	Viewport.bSuspendPrecaching = True;
	bUWindowActive = !bQuickKeyEnable;
	Viewport.bShowWindowsMouse = True;
//	bNoDrawWorld = True;

	if(!bQuickKeyEnable && bPause)
	{
		if(Viewport.Actor.Level.NetMode == NM_Standalone)
			Viewport.Actor.SetPause( True );
	}
	if(Root != None)
		Root.bWindowVisible = True;

	GotoState('UWindow');
}

function CloseUWindow()
{
	if(!bQuickKeyEnable)
		Viewport.Actor.SetPause( False );

	bNoDrawWorld = False;
	bQuickKeyEnable = False;
	bUWindowActive = False;
	Viewport.bShowWindowsMouse = False;

	if(Root != None)
		Root.bWindowVisible = False;
	GotoState('');
	Viewport.bSuspendPrecaching = False;
}

function CreateRootWindow(Canvas Canvas)
{
	local int i;

	if(Canvas != None)
	{
		OldClipX = Canvas.ClipX;
		OldClipY = Canvas.ClipY;
	}
	else
	{
		OldClipX = 0;
		OldClipY = 0;
	}
	
	Log("Creating root window: "$RootWindow);
	
	Root = New(None) class<UWindowRootWindow>(DynamicLoadObject(RootWindow, class'Class'));

	Root.BeginPlay();
	Root.WinTop = 0;
	Root.WinLeft = 0;

	if(Canvas != None)
	{
		Root.WinWidth = Canvas.ClipX / Root.GUIScale;
		Root.WinHeight = Canvas.ClipY / Root.HGUIScale;//Root.GUIScale;
		Root.RealWidth = Canvas.ClipX;
		Root.RealHeight = Canvas.ClipY;
	}
	else
	{
		Root.WinWidth = 0;
		Root.WinHeight = 0;
		Root.RealWidth = 0;
		Root.RealHeight = 0;
	}

	Root.ClippingRegion.X = 0;
	Root.ClippingRegion.Y = 0;
	Root.ClippingRegion.W = Root.WinWidth;
	Root.ClippingRegion.H = Root.WinHeight;

	Root.Console = Self;

	Root.bUWindowActive = bUWindowActive;

	Root.Created();
	bCreatedRoot = True;

	// Create the console window.
	ConsoleWindow = UWindowConsoleWindow(Root.CreateWindow(ConsoleClass, 100, 100, 200, 200));
	if(!bShowConsole)
		HideConsole();

	UWindowConsoleClientWindow(ConsoleWindow.ClientArea).TextArea.AddText(" ");
	for (I=0; I<4; I++)
		UWindowConsoleClientWindow(ConsoleWindow.ClientArea).TextArea.AddText(MsgText[I]);
}

function RenderUWindow( canvas Canvas )
{
	local UWindowWindow NewFocusWindow;

	Canvas.bNoSmooth = True;
	Canvas.Z = 1;
	Canvas.Style = 1;
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;
	
	// Metallicafan212:	Force the fake mouse cursor to work
	if(Root != None && !Root.bForceFakeMouse && Viewport.bWindowsMouseAvailable)
	{
		MouseX = Viewport.WindowsMouseX / Root.GUIScale;
		MouseY = Viewport.WindowsMouseY / Root.HGUIScale;//Root.GUIScale;
	}
	// Metallicafan212:	Track the windows mouse and hide this mouse cursor if we move it
	else if(Root != None && Root.bForceFakeMouse && Viewport.bWindowsMouseAvailable)
	{
		if(Viewport.WindowsMouseX  != LastMouseX || Viewport.WindowsMouseY != LoastMouseY)
		{
			MouseX = Viewport.WindowsMouseX / Root.GUIScale;
			MouseY = Viewport.WindowsMouseY / Root.HGUIScale;//Root.GUIScale;
			Root.bForceFakeMouse = false;
		}
		
		LastMouseX 	= Viewport.WindowsMouseX;
		LoastMouseY = Viewport.WindowsMouseY;
	}

	if(!bCreatedRoot) 
		CreateRootWindow(Canvas);

	Root.bWindowVisible = True;
	Root.bUWindowActive = bUWindowActive;
	Root.bQuickKeyEnable = bQuickKeyEnable;

	if(Canvas.ClipX != OldClipX || Canvas.ClipY != OldClipY)
	{
		OldClipX = Canvas.ClipX;
		OldClipY = Canvas.ClipY;
		
		Root.WinTop = 0;
		Root.WinLeft = 0;
		Root.WinWidth = Canvas.ClipX / Root.GUIScale;
		Root.WinHeight = Canvas.ClipY / Root.HGUIScale;//Root.GUIScale;

		Root.RealWidth = Canvas.ClipX;
		Root.RealHeight = Canvas.ClipY;

		Root.ClippingRegion.X = 0;
		Root.ClippingRegion.Y = 0;
		Root.ClippingRegion.W = Canvas.ClipX;//Root.WinWidth;
		Root.ClippingRegion.H = Canvas.ClipY;//Root.WinHeight;

		Root.Resized();
	}

	if(MouseX > Root.WinWidth) MouseX = Root.WinWidth;
	if(MouseY > Root.WinHeight) MouseY = Root.WinHeight;
	if(MouseX < 0) MouseX = 0;
	if(MouseY < 0) MouseY = 0;


	// Check for keyboard focus
	NewFocusWindow = Root.CheckKeyFocusWindow();

	if(NewFocusWindow != Root.KeyFocusWindow)
	{
		Root.KeyFocusWindow.KeyFocusExit();		
		Root.KeyFocusWindow = NewFocusWindow;
		Root.KeyFocusWindow.KeyFocusEnter();
	}


	Root.MoveMouse(MouseX, MouseY);
	Root.WindowEvent(WM_Paint, Canvas, MouseX, MouseY, 0);
	if(bUWindowActive || bQuickKeyEnable) 
		Root.DrawMouse(Canvas);
}

event Message( PlayerReplicationInfo PRI, coerce string Msg, name N )
{
	local string OutText;

	Super.Message( PRI, Msg, N );

	if ( Viewport.Actor == None )
		return;

	if( Msg!="" )
	{
		if (( MsgType[TopLine] == 'Say' ) || ( MsgType[TopLine] == 'TeamSay' ))
			OutText = MsgPlayer[TopLine].PlayerName$": "$MsgText[TopLine];
		else
			OutText = MsgText[TopLine];
		if (ConsoleWindow != None)
			UWindowConsoleClientWindow(ConsoleWindow.ClientArea).TextArea.AddText(OutText);
	}
}

event AddString( coerce string Msg )
{
	Super.AddString( Msg );

	if( Msg!="" )
	{
		if (ConsoleWindow != None)
			UWindowConsoleClientWindow(ConsoleWindow.ClientArea).TextArea.AddText(Msg);
	}
}

function UpdateHistory()
{
	// Update history buffer.
	History[HistoryCur++ % MaxHistory] = TypedStr;
	if( HistoryCur > HistoryBot )
		HistoryBot++;
	if( HistoryCur - HistoryTop >= MaxHistory )
		HistoryTop = HistoryCur - MaxHistory + 1;
}

function HistoryUp()
{
	if( HistoryCur > HistoryTop )
	{
		History[HistoryCur % MaxHistory] = TypedStr;
		TypedStr = History[--HistoryCur % MaxHistory];
	}
}

function HistoryDown()
{
	History[HistoryCur % MaxHistory] = TypedStr;
	if( HistoryCur < HistoryBot )
		TypedStr = History[++HistoryCur % MaxHistory];
	else
		TypedStr="";
}

function NotifyLevelChange()
{
	Super.NotifyLevelChange();
	bLevelChange = True;
	if(Root != None)
		Root.NotifyBeforeLevelChange();
}

defaultproperties
{
	MouseScale=0.6
	ControllerMouseScale=300.0
	RootWindow="UWindow.UWindowRootWindow"
	UWindowKey=IK_Esc
	ConsoleKey=192
	ConsoleClass=class'UWindowConsoleWindow'
	bShowConsole=False
	bLevelChange=False
	bEnableExec=true
}
