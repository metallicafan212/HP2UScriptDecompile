//================================================================================
// ShortCutBrowser.
//================================================================================

class ShortCutBrowser extends UWindowDialogClientWindow;

struct List
{
	var string strName;
	var ShortCutList List;
};

var ScalingComboBox ComboBoxListTypes;
var ScalingComboBox ComboBoxGameStates;
var ShortCutButton buttonLaunch;
var int iNumLists;
var int iCurList;
var List ListArray[8];
const MAX_LISTS= 8;

var int iNumStates;
var int iCurState;
var array<string> StateArray;


function Created ()
{
	local float X;
	local float Width;
	
	// Metallicafan212:	We need to use the width and height to scale the button placement
	X 		= 0.0;
	Width 	= WinWidth * 0.375;
	
	Super.Created();
	bTransient = False;
	
	Log("WinWidth " $ WinWidth $ " WinHeight " $ WinHeight);
  
	ComboBoxListTypes = ScalingComboBox(CreateControl(Class'ScalingComboBox', 0.0, 0.0, Width, 16.0));
	ComboBoxListTypes.SetFont(0);
	ComboBoxListTypes.SetEditable(False);
	ComboBoxListTypes.SetButtons(False);
	ComboBoxListTypes.SetHelpText("ComboBoxListTypes help text");
	
	X += Width;
	
	ComboBoxGameStates = ScalingComboBox(CreateControl(Class'ScalingComboBox', X, 0.0, Width, 16.0));
	ComboBoxGameStates.SetFont(0);
	ComboBoxGameStates.SetEditable(False);
	ComboBoxGameStates.SetButtons(False);
	ComboBoxGameStates.SetHelpText("ComboBoxGameStates help text");
	
	X += Width;
	Width = WinWidth * 0.25;
	
	buttonLaunch = ShortCutButton(CreateControl(Class'ShortCutButton', X, 0.0, Width, 15.0));
	buttonLaunch.ShowWindow();
	buttonLaunch.CancelAcceptsFocus();
	buttonLaunch.ToolTipString = "Launch current shortcut";
	buttonLaunch.SetText("Launch");
	
	iCurList = 0;
}

function Activated ()
{
	UpdateCurrentGameStateSelection();
}

function Resized ()
{
	local float X;
	local float Width;
	
	// Metallicafan212:	We need to use the width and height to scale the button placement
	X 		= 0.0;
	Width 	= WinWidth * 0.375;	
	
	ListArray[iCurList].List.WinWidth 	= WinWidth;
	ListArray[iCurList].List.WinHeight 	= WinHeight - 4;
	ListArray[iCurList].List.Resized();
	
	ComboBoxListTypes.WinLeft = 0;
	ComboBoxListTypes.SetSize(Width, 16.0);
	
	ComboBoxGameStates.WinLeft = Width;
	ComboBoxGameStates.SetSize(Width, 16.0);
	
	ButtonLaunch.WinLeft = Width * 2.0;
	ButtonLaunch.SetSize(WinWidth * 0.25, 16.0);
	
	
	/*
	// Metallicafan212:	Resize the buttons and combos
	ComboBoxListTypes.WinLeft 	= 0.0;
	ComboBoxListTypes.WinWidth 	= Width;
	ComboBoxListTypes.Resized();
	
	X 	+= Width;
	
	ComboBoxGameStates.WinLeft 	= X;
	ComboBoxGameStates.WinWidth = Width;
	ComboBoxGameStates.Resized();
	
	X 	 += Width;
	Width = WinWidth * 0.25;
	
	buttonLaunch.WinLeft 	= X;
	buttonLaunch.WinWidth 	= Width;
	buttonLaunch.Resized();
	*/
	
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

function UpdateCurrentGameStateSelection ()
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
			}
			break;
		case 2:
			switch (C)
			{
				case buttonLaunch:
					ListArray[iCurList].List.OnLaunchButton();
					FocusWindow();
					break;
			}
		break;
	}
}

function GameStateComboBoxChanged ()
{
	harry(GetPlayerOwner()).SetGameState(ComboBoxGameStates.GetValue());
}

function ListTypeComboBoxChanged ()
{
	local string strNewName;
	local int I;
	
	strNewName = ComboBoxListTypes.GetValue();
	
	for(i = 0; i < MAX_LISTS; i++)
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
	}
}

