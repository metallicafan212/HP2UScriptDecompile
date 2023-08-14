//================================================================================
// CutScriptDisk.
//================================================================================

// Omega: Simple edits to support dynamic arrays

class CutScriptDisk extends CutScript;

//var string lineArray[4096];
var array<String> lineArray;
var int curScriptLine;

function bool GetNextLine (out string Line)
{
	local int xx;

	Line = lineArray[curScriptLine];
	curScriptLine++;
	if ( Line == "" )
	{
		return False;
	}
	return True;
}

function load (string threadName, string FileName)
{
	local int I;
	local string Line;

	/*for(I = 0; I < 9999; I++)
	//for(I = 0; I < lineArray.Length; I++)
	{
		Line = Localize(threadName,"line_"$I,FileName);
		if ( Line == "" || InStr(Line,"<?") > -1 )
		{
			break;
		}
		
		lineArray[I] = Line;
	}*/
	I = 0;
	while(True)
	{
		Line = Localize(threadName,"line_"$I,FileName);
		if ( Line == "" || InStr(Line,"<?") > -1 )
		{
			break;
		}

		lineArray[I] = Line;
		I++;
	}
}
