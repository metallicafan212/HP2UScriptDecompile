//================================================================================
// ShortCutListBookmarks.
//================================================================================

class ShortCutListBookmarks extends ShortCutList;

var array<name> lableName;
var array<string> lableDesc;

function Created()
{
  Super.Created();
  RowHeight = 12.0;
  bShowHorizSB = True;
  AddColumn(" Index",28.0);
  AddColumn(" Name",64.0);
  AddColumn(" Description",512.0);
  Reset();
}

function Reset()
{
  local navShortcut sc;

  NumRows = 0;
  foreach GetPlayerOwner().AllActors(Class'navShortcut',sc)
  {
    lableName[NumRows] = sc.Name;
    lableDesc[NumRows] = sc.Description;
    NumRows++;
  }
  if ( NumRows == 0 )
  {
    NumRows = 1;
    lableName[0] = '0';
    lableDesc[0] = "Could not find any bookmarks!";
  }
}

function LaunchShortcut (int Row)
{
  local navShortcut sc;
  local int I;

  I = 0;
  foreach GetPlayerOwner().AllActors(Class'navShortcut',sc)
  {
    if ( I == Row )
    {
      harry(GetPlayerOwner()).GotoLocation(sc.Location);
    }
    I++;
  }
}

function PaintColumn (Canvas C, UWindowGridColumn Column, float MouseX, float MouseY)
{
  local int TopMargin;
  local int BottomMargin;
  local int NumRowsVisible;
  local int CurRow;
  local int CurOffset;
  local int LastRow;

  if ( bShowHorizSB )
  {
    BottomMargin = LookAndFeel.Size_ScrollbarWidth; 
  }
  else 
  {
    BottomMargin = 0;
  }
  TopMargin = LookAndFeel.ColumnHeadingHeight;
  NumRowsVisible = (WinHeight - (TopMargin + BottomMargin)) / RowHeight; 
  VertSB.SetRange(0, NumRows, NumRowsVisible);
  CurRow = VertSB.Pos;
  LastRow = CurRow + NumRowsVisible;
  if ( LastRow > NumRows )
  {
    LastRow = NumRows;
  }
  CurOffset = 0;
  C.DrawColor.G = 255;
  // if ( CurRow < LastRow )
  while ( CurRow < LastRow )
  {
    if ( CurRow == SelectedRow )
    {
      C.DrawColor.R = 0;
      C.DrawColor.B = 0;
    } else {
      C.DrawColor.R = 255;
      C.DrawColor.B = 255;
    }
    switch (Column.ColumnNum)
    {
      case 0:
      Column.ClipText(C,2.0,TopMargin + CurOffset,CurRow);
      break;
      case 1:
      Column.ClipText(C,2.0,TopMargin + CurOffset,lableName[CurRow]);
      break;
      case 2:
      Column.ClipText(C,2.0,TopMargin + CurOffset,lableDesc[CurRow]);
      break;
      default:
    }
    CurOffset += RowHeight;
	++CurRow;
    // goto JL00DF;
  }
}

function SortColumn (UWindowGridColumn Column)
{
  HPConsole(Root.Console).Viewport.Actor.ClientMessage("sort column " $ string(Column.ColumnNum));
}

