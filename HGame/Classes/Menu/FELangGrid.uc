//================================================================================
// FELangGrid.
//================================================================================

class FELangGrid extends UWindowGrid;

var UWindowGridColumn ngSecretColumn;
var FESoundBrowser browser;
var int SelectedRow;

function Created ()
{
  Super.Created();
  RowHeight = 12.0;
  AddColumn("Status",50.0);
  AddColumn("Name",200.0);
  AddColumn("Text",380.0);
}

function PaintColumn (Canvas C, UWindowGridColumn Column, float MouseX, float MouseY)
{
  local int Visible;
  local int Count;
  local int Skipped;
  local int Y;
  local int TopMargin;
  local int BottomMargin;
  local int Index;
  local Color colorCutTextBlue;

/*
  if ( bShowHorizSB )
  {
    BottomMargin = LookAndFeel.Size_ScrollbarWidth = } else {;
    BottomMargin = 0;
  }
 */
 
  if ( bShowHorizSB )
  {
    BottomMargin = LookAndFeel.Size_ScrollbarWidth; 
  }
  else 
  {
     BottomMargin = 0;
  }
 
  TopMargin = LookAndFeel.ColumnHeadingHeight;
  Count = browser.MasterCount;
  C.Font = Root.Fonts[0];
  Visible = (WinHeight - TopMargin + BottomMargin) / RowHeight;
  VertSB.SetRange(0.0,Count + 1,Visible);
  TopRow = VertSB.Pos;
  Skipped = 0;
  Y = 1;
  Index = 0;
  // if ( (Y < RowHeight + WinHeight - RowHeight - TopMargin + BottomMargin) && (Index < browser.MasterCount) )
  while((Y < RowHeight + WinHeight - RowHeight - (TopMargin + BottomMargin)) && (Index < browser.MasterCount))
  {
    if ( Skipped >= VertSB.Pos )
    {
      if ( Index == SelectedRow )
      {
        C.DrawColor.R = 255;
        C.DrawColor.G = 5;
        C.DrawColor.B = 5;
      } else {
        C.DrawColor.R = 255;
        C.DrawColor.G = 255;
        C.DrawColor.B = 255;
      }
      switch (Column.ColumnNum)
      {
        case 0:
        Column.ClipText(C,2.0,Y + TopMargin,browser.status[Index]);
        break;
        case 1:
        Column.ClipText(C,2.0,Y + TopMargin,browser.MasterList[Index]);
        break;
        case 2:
        Column.ClipText(C,2.0,Y + TopMargin,browser.MasterText[Index]);
        break;
        default:
      }
      Y = Y + RowHeight;
      // There are 1 jump destination(s) inside the last statement!
    }
	
	Skipped++;
    Index++;
    // goto JL00DE;
  }
}

function RightClickRow (int Row, float X, float Y)
{
}

function SortColumn (UWindowGridColumn Column)
{
}

function SelectRow (int Row)
{
  local Sound snd;

  if ( Row != SelectedRow )
  {
    SelectedRow = Row;
    HPHud(harry(Root.Console.Viewport.Actor).myHUD).SetSubtitleText(browser.MasterText[Row],360.0);
    snd = Sound(DynamicLoadObject("AllDialog." $ browser.MasterList[Row],Class'Sound'));
    harry(Root.Console.Viewport.Actor).PlaySound(snd);
  }
}

