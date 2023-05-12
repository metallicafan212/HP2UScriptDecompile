class UWindowWrappedTextArea extends UWindowTextAreaControl;

var bool bLog;

var int  NumLinesInLastDraw;
var int  DontDrawIfMoreLines; //If this is non zero, it first checks to see if there are more than this many lines of text,
                              // if there are, it doesn't draw.  Sets this to zero afterwards.

//*************************************************************************************
function Paint( Canvas C, float X, float Y )
{
	local int i, j, Line;
	local int TempHead, TempTail;
	local float XL, YL;

	C.Font = Root.Fonts[Font];
	C.DrawColor = TextColor;

	TextSize(C, "TEST", XL, YL);
	VisibleRows = WinHeight / YL;

	if (bScrollable)
	{
		VertSB.SetRange(0, Lines, VisibleRows);
	}

	TempHead = Head;
	TempTail = Tail;
	Line = TempHead;
	TextArea[Line] = Prompt;
	if (bScrollable)
	{
		if (VertSB.MaxPos - VertSB.Pos > 0)
		{
			Line -= VertSB.MaxPos - VertSB.Pos;
			TempTail -= VertSB.MaxPos - VertSB.Pos;
		}
	}

	//If DontDrawIfMoreLines is non zero, then see if we'll be drawing too much text.  If so, just return.
	if( DontDrawIfMoreLines > 0 )
	{
		i = DontDrawIfMoreLines;
		DontDrawIfMoreLines = 0;

		NumLinesInLastDraw = WrapClipText(C, 2, 0, TextArea[Line-1], [bNoDraw]true);
		
		if( NumLinesInLastDraw > i )
			return;
	}

	for (i=0; i<VisibleRows; i+=j)
	{
		NumLinesInLastDraw = WrapClipText(C, 2, YL*i/*(VisibleRows-i-1) ft why?*/, TextArea[Line-1]);

		if( bLog )
			Log( "*********NumLines:" $ j );
			
		//ft this'll need work...  I've basically wrecked this class as far us multiple lines is concerned.  If anyone else needs this to support
		// more than one line in TextArea[], have me make a new class derived from this one.
		Line--;
		if (TempTail == Line)
			break;
		if (Line < 0)
			Line = BufSize-1;
	}
}

//*************************************************************************************
//function Paint( Canvas C, float X, float Y )


defaultproperties
{
	TextColor=(R=255,G=255,B=255)
}
