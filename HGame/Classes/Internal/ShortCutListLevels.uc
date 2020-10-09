//================================================================================
// ShortCutListLevels.
//================================================================================

class ShortCutListLevels extends ShortCutList;

var array<int> lableNumbers;
var array<string> lableMapNames;

function Reset ()
{
  local string FirstMap;
  local string NextMap;
  local string TestMap;
  local int I;

  FirstMap = GetPlayerOwner().GetMapName("","",0);
// JL002A:
  NextMap = FirstMap;
  I = 0;
  // if (  !FirstMap ~= TestMap )
  while ( !(FirstMap ~= TestMap) )
  {
    lableNumbers[I] = I;
    lableMapNames[I] = NextMap;
    NextMap = GetPlayerOwner().GetMapName("",NextMap,1);
    TestMap = NextMap;
    ++I;
    // goto JL002A;
  }
  NumRows = I;
}

function LaunchShortcut (int Row)
{
  baseConsole(Root.Console).ChangeLevel(lableMapNames[Row],True);
}

function Created ()
{
  Super.Created();
  AddColumn(" Level",28.0);
  AddColumn(" MapName",512.0);
  NumRows = 0;
  Reset();
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
  CurOffset = 0;
  if ( LastRow > NumRows )
  {
    LastRow = NumRows;
  }
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
      Column.ClipText(C,2.0,TopMargin + CurOffset,lableNumbers[CurRow]);
      break;
      case 1:
      Column.ClipText(C,2.0,TopMargin + CurOffset,lableMapNames[CurRow]);
      break;
      default:
    }
    CurOffset += RowHeight;
	++CurRow;
    // goto JL00DF;
  }
}

