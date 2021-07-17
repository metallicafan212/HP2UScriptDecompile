//================================================================================
// ShortCutClientWindow.
//================================================================================

class ShortCutClientWindow extends UWindowDialogClientWindow;

var ShortCutBrowser browser;

var float OldParentWidth, OldParentHeight;

// Metallicafan212:	Quick math function
function float GetHeightScale()
{
	return Class'M212HScale'.Static.UWindowGetHeightScale(Root);//return (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);
}

function Created()
{
	local string curToken;
	local int I;

	Super.Created();

	OldParentWidth = ParentWindow.WinWidth;
	OldParentHeight = ParentWindow.WinHeight;

	SetDimensions();

	SetAcceptsFocus();
	
	browser = ShortCutBrowser(CreateWindow(Class'ShortCutBrowser', 0.0, 0.0, WinWidth, WinHeight));
	browser.AddList("Levels", 		ShortCutListLevels(		CreateWindow(Class'ShortCutListLevels', 	0.0, 16.0, WinWidth, WinHeight - 12)));
	browser.AddList("Bookmarks", 	ShortCutListBookmarks(	CreateWindow(Class'ShortCutListBookmarks',	0.0, 16.0, WinWidth, WinHeight - 12)));
	browser.AddList("Sounds",		ShortCutListSounds(		CreateWindow(Class'ShortCutListSounds',		0.0, 16.0, WinWidth, WinHeight - 12)));
	
	I = 0;
	curToken = GetPlayerOwner().GetGameStateMasterListToken(0);
	while ( curToken != "" )
	{
		browser.AddGameState(curToken);
		curToken = GetPlayerOwner().GetGameStateMasterListToken( ++I );
	}
	browser.UpdateCurrentGameStateSelection();
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

function Activated()
{
	if ( browser != None )
	{
		browser.Activated();
	}
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

function Resized()
{
	Super.Resized();
	browser.WinWidth 	= WinWidth;
	browser.WinHeight 	= WinHeight;
	browser.Resized();
}

function Paint (Canvas Canvas, float X, float Y)
{
	Super.Paint(Canvas,X,Y);
	browser.Paint(Canvas,X,Y);
}

