//================================================================================
// ShortCutClientWindow.
//================================================================================

class ShortCutClientWindow extends UWindowDialogClientWindow;

var ShortCutBrowser browser;

function Created()
{
  local string curToken;
  local int I;

  Super.Created();
  browser = ShortCutBrowser(CreateWindow(Class'ShortCutBrowser',0.0,0.0,WinWidth,WinHeight));
  browser.AddList("Levels",ShortCutListLevels(CreateWindow(Class'ShortCutListLevels',0.0,16.0,WinWidth,WinHeight - 12)));
  browser.AddList("Bookmarks",ShortCutListBookmarks(CreateWindow(Class'ShortCutListBookmarks',0.0,16.0,WinWidth,WinHeight - 12)));
  browser.AddList("Sounds",ShortCutListSounds(CreateWindow(Class'ShortCutListSounds',0.0,16.0,WinWidth,WinHeight - 12)));
  I = 0;
  curToken = GetPlayerOwner().GetGameStateMasterListToken(0);
  // if ( curToken != "" )
  while ( curToken != "" )
  {
    browser.AddGameState(curToken);
    curToken = GetPlayerOwner().GetGameStateMasterListToken( ++I );
    // goto JL0111;
  }
  browser.UpdateCurrentGameStateSelection();
}

function Activated()
{
  if ( browser != None )
  {
    browser.Activated();
  }
}

function Resized()
{
  Super.Resized();
  browser.WinWidth = WinWidth;
  browser.WinHeight = WinHeight;
  browser.Resized();
}

function Paint (Canvas Canvas, float X, float Y)
{
  Super.Paint(Canvas,X,Y);
  browser.Paint(Canvas,X,Y);
}

