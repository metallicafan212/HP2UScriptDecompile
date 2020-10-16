//================================================================================
// CutScriptDisk.
//================================================================================

class CutScriptDisk extends CutScript;

var string lineArray[4096];
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

  // I = 0;
  // if ( I < 9999 )
  for(I = 0; I < 9999; I++)
  {
    Line = Localize(threadName,"line_"$I,FileName);
    if ( Line == "" || InStr(Line,"<?") > -1 )
    {
      // goto JL007C;
	  break;
    }
    lineArray[I] = Line;
    // I++;
    // goto JL0007;
  }
}

