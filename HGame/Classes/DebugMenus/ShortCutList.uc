//================================================================================
// ShortCutList.
//================================================================================

class ShortCutList extends UWindowGrid;

var int SelectedRow;
var int NumRows;

function Reset ()
{
}

function LaunchShortcut (int Row)
{
}

function OnLaunchButton ()
{
	LaunchShortcut(SelectedRow);
}

function Created ()
{
	Super.Created();
	
	RowHeight = 12.0;
	bShowHorizSB = True;
	bAlwaysOnTop = True;
}

function Paint (Canvas Canvas, float X, float Y)
{
}

function PaintColumn (Canvas C, UWindowGridColumn Column, float MouseX, float MouseY)
{
}

function DoubleClickRow (int Row)
{
  LaunchShortcut(SelectedRow);
}

function SelectRow (int Row)
{
	local int CurRow;

	CurRow = VertSB.Pos + Row;
	if ( Row != SelectedRow && CurRow < NumRows )
	{
		SelectedRow = CurRow;
	}
}

function RightClickRow (int Row, float X, float Y)
{
}

function SortColumn (UWindowGridColumn Column)
{
}

