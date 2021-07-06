//================================================================================
// ShortCutBrowser.
//================================================================================

class ShortCutBrowser extends UWindowDialogClientWindow;

struct List
{
  var string strName;
  var ShortCutList List;
};

var UWindowComboControl ComboBoxListTypes;
var UWindowComboControl ComboBoxGameStates;
var ShortCutButton buttonLaunch;
var int iNumLists;
var int iCurList;
var List ListArray[8];
const MAX_LISTS= 8;

var int iNumStates;
var int iCurState;
var array<string> StateArray;


function Created()
{
  Super.Created();
  bTransient = False;
  ComboBoxListTypes = UWindowComboControl(CreateControl(Class'UWindowComboControl',0.0,0.0,128.0,16.0));
  ComboBoxListTypes.SetFont(0);
  ComboBoxListTypes.SetEditable(False);
  ComboBoxListTypes.SetButtons(False);
  ComboBoxListTypes.SetHelpText("ComboBoxListTypes help text");
  ComboBoxGameStates = UWindowComboControl(CreateControl(Class'UWindowComboControl',128.0,0.0,94.0,16.0));
  ComboBoxGameStates.SetFont(0);
  ComboBoxGameStates.SetEditable(False);
  ComboBoxGameStates.SetButtons(False);
  ComboBoxGameStates.SetHelpText("ComboBoxGameStates help text");
  buttonLaunch = ShortCutButton(CreateControl(Class'ShortCutButton',222.0,0.0,64.0,15.0));
  buttonLaunch.ShowWindow();
  buttonLaunch.CancelAcceptsFocus();
  buttonLaunch.ToolTipString = "Launch current shortcut";
  buttonLaunch.SetText("Launch");
  iCurList = 0;
}

function Activated()
{
  UpdateCurrentGameStateSelection();
}

function Resized()
{
  ListArray[iCurList].List.WinWidth = WinWidth;
  ListArray[iCurList].List.WinHeight = WinHeight - 4;
  ListArray[iCurList].List.Resized();
  Super.Resized();
}

function AddList (string strName, ShortCutList newList)
{
  if ( newList == None || iNumLists + 1 >= MAX_LISTS )
  {
    return;
  }
  ComboBoxListTypes.AddItem(strName);
  ListArray[iNumLists].List = newList;
  ListArray[iNumLists].List.HideWindow();
  ListArray[iNumLists].strName = strName;
  if ( iNumLists == 0 )
  {
    ComboBoxListTypes.SetSelectedIndex(0);
    ListTypeComboBoxChanged();
  }
  iNumLists++;
}

function UpdateCurrentGameStateSelection()
{
  ComboBoxGameStates.SetSelectedIndex(ComboBoxGameStates.List.FindItemIndex(GetPlayerOwner().CurrentGameState,True));
}

function AddGameState (string strState)
{
  if ( Len(strState) == 0 )
  {
    return;
  }
  ComboBoxGameStates.AddItem(strState);
  iNumStates++;
}

function Notify (UWindowDialogControl C, byte E)
{
  Super.Notify(C,E);
  switch (E)
  {
    case 1:
    switch (C)
    {
      case ComboBoxListTypes:
      ListTypeComboBoxChanged();
      break;
      case ComboBoxGameStates:
      GameStateComboBoxChanged();
      break;
      default:
    }
    break;
    case 2:
    switch (C)
    {
      case buttonLaunch:
      ListArray[iCurList].List.OnLaunchButton();
      FocusWindow();
      break;
      default:
    }
    break;
    default:
  }
}

function GameStateComboBoxChanged()
{
  harry(GetPlayerOwner()).SetGameState(ComboBoxGameStates.GetValue());
}

function ListTypeComboBoxChanged()
{
  local string strNewName;
  local int I;

  I = 0;
  strNewName = ComboBoxListTypes.GetValue();
  // if ( I < 8 )
  while(I < MAX_LISTS)
  {
    if ( strNewName == ListArray[I].strName )
    {
      ListArray[iCurList].List.HideWindow();
      ListArray[iCurList].List.CancelAcceptsFocus();
      iCurList = I;
      ListArray[I].List.ShowWindow();
      ListArray[I].List.SetAcceptsFocus();
      ListArray[I].List.Reset();
      Resized();
      return;
    }
    ++I;
    // goto JL001C;
  }
}

