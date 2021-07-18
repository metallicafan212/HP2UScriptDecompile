//================================================================================
// ShortCutWindow.
//================================================================================

class ShortCutWindow extends UWindowFramedWindow;

var float OldParentWidth, OldParentHeight;

// Metallicafan212:	Quick math function
function float GetHeightScale()
{
	return Class'M212HScale'.Static.UWindowGetHeightScale(Root);//return (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);
}

function Created ()
{
	Super.Created();
	
	// Metallicafan212:	Make it act like the console
	bSizable = True;
	bStatusBar = True;
	bLeaveOnScreen = True;

	OldParentWidth = ParentWindow.WinWidth;
	OldParentHeight = ParentWindow.WinHeight;

	SetDimensions();

	SetAcceptsFocus();
}

function BeginPlay ()
{
	Super.BeginPlay();
	WindowTitle = "Map selector";//"Shortcut Window";
	ClientClass = Class'ShortCutClientWindow';
	//ToolTip("Select a map/bookmark");//("short cut tool tip");
	SetAcceptsFocus();
	bTransient = False;
	bUWindowActive = True;
	bLeaveOnscreen = True;
	bAcceptsHotKeys = True;
	bSizable = True;
}

function ShowWindow()
{
	Super.ShowWindow();

	if(ParentWindow.WinWidth != OldParentWidth || ParentWindow.WinHeight != OldParentHeight)
	{
		SetDimensions();
		OldParentWidth = ParentWindow.WinWidth;
		OldParentHeight = ParentWindow.WinHeight;
	}
}

function Activated ()
{
	local UWindowWindow Prev;
	local UWindowWindow Child;

	for(Child = LastChildWindow; Child != None; Child = Prev)
	{
		Prev = Child.PrevSiblingWindow;
		Child.Activated();
	}
	bUWindowActive = True;
}

function Close (optional bool bByParent)
{
	Super.Close(bByParent);
	bUWindowActive = False;
}

function SetDimensions()
{
	if (ParentWindow.WinWidth < 500)
	{
		SetSize(200, 150);
	} 
	else 
	{
		SetSize(410 * GetHeightScale(), 310 * GetHeightScale());
	}
	WinLeft = ParentWindow.WinWidth/2 - WinWidth/2;
	WinTop 	= ParentWindow.WinHeight/2 - WinHeight/2;
}

