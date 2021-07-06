class UWindowConsoleWindow extends UWindowFramedWindow;

var float OldParentWidth, OldParentHeight;

// Metallicafan212:	Quick math function
function float GetHeightScale()
{
	return (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);
}

function Created() 
{
	Super.Created();
	bSizable = True;
	bStatusBar = True;
	bLeaveOnScreen = True;

	OldParentWidth = ParentWindow.WinWidth;
	OldParentHeight = ParentWindow.WinHeight;

	SetDimensions();

	SetAcceptsFocus();
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

function ResolutionChanged(float W, float H)
{
	SetDimensions();
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

function Close(optional bool bByParent)
{
	ClientArea.Close(True);
	Root.Console.HideConsole();
}

defaultproperties
{
	WindowTitle="System Console";
	ClientClass=class'UWindowConsoleClientWindow'
}