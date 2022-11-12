//================================================================================
// baseDialog.
//================================================================================

class baseDialog extends Info;

const MAX_LINES=  2100;
var harry PlayerHarry;
var int NumLines;
var string lineIDs[2100];
var Sound lineSounds[2100];
var string lineText[2100];
var string LanguageName;
var globalconfig string LanguageExtension;

event Spawned()
{
  if ( PlayerHarry == None )
  {
// JL001F:
    foreach AllActors(Class'harry',PlayerHarry)
    {
      // goto JL001F;
	  break;
    }
  }
}

function bool FindDialog (string dialogID, out Sound dlgSound, out string DlgText)
{
  local int I;

  DlgText = Localize("all",dialogID,"HPdialog");
  dlgSound = Sound(DynamicLoadObject("AllDialog." $ dialogID,Class'Sound'));
  if ( dlgSound == None )
  {
    DlgText = "*" $ DlgText;
  }
  return True;
}

function string TranslateString (string S)
{
  return S;
}

function float DeliverDialog (string dialogID)
{
  local float duration;
  local Sound dlgSound;
  local string DlgText;

  duration = 3.0;
  return duration;
}

function float DeliverEmote (string dialogID)
{
  local float duration;
  local Sound dlgSound;
  local string DlgText;

  duration = 1.0;
  if ( FindDialog(dialogID,dlgSound,DlgText) )
  {
    if ( dlgSound != None )
    {
      duration = GetSoundDuration(dlgSound);
      duration += 0.5;
      PlayerHarry.PlaySound(dlgSound,SLOT_Interact,3.2,False,20000.0,1.0);
    }
  } else {
    PlayerHarry.ClientMessage("*****DeliverEmote cant find emote:" $ dialogID);
  }
  return duration;
}

defaultproperties
{
    NumLines=1

    lineIDs(0)="TUT1_DUMINTRO_1"

    lineText(0)="Welcome to Hogwarts, the school for Witches and Wizards. I am Albus Dumbledore, your Headmaster."

    LanguageName="base"

}
