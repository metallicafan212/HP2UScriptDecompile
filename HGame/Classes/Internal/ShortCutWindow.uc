//================================================================================
// ShortCutWindow.
//================================================================================

class ShortCutWindow extends UWindowFramedWindow;

function Created()
{
  Super.Created();
}

function BeginPlay()
{
  Super.BeginPlay();
  WindowTitle = "Shortcut Window";
  ClientClass = Class'ShortCutClientWindow';
  ToolTip("short cut tool tip");
  SetAcceptsFocus();
  bTransient = False;
  bUWindowActive = True;
  bLeaveOnscreen = True;
  bAcceptsHotKeys = True;
  bSizable = True;
}

function Activated()
{
  local UWindowWindow Prev;
  local UWindowWindow Child;

  // Child = LastChildWindow;
  // if ( Child != None )
  for(Child = LastChildWindow; Child != None; Child = Prev)
  {
    Prev = Child.PrevSiblingWindow;
    Child.Activated();
    // Child = Prev;
    // goto JL000B;
  }
  bUWindowActive = True;
}

function Close (optional bool bByParent)
{
  Super.Close(bByParent);
  bUWindowActive = False;
}

