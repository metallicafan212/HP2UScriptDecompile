class UWindowComboControl extends UWindowDialogControl;

var	float				EditBoxWidth;
var float				EditAreaDrawX, EditAreaDrawY;

var UWindowEditBox			EditBox;
var UWindowComboButton		Button;
var UWindowComboLeftButton 	LeftButton;
var UWindowComboRightButton RightButton;

var class<UWindowComboList>	ListClass;
var UWindowComboList	List;

var bool				bListVisible;
var bool				bCanEdit;
var bool				bButtons;

/*
// Metallicafan212:	Fix the resize issue
function ResolutionChanged(float W, float H)
{
	Super.ResolutionChanged(W, H);
	
	WinLeft 			= 0;
	
	EditBox.WinLeft		= 0;
	EditBox.WinWidth 	= WinWidth - 12;
	EditBox.WinHeight	= WinHeight;
	EditBox.Resized();
	
	Button.WinLeft		= 0;
	Button.WinWidth 	= WinWidth - 12;
	Button.Resized();
	
	if(LeftButton != none)
	{
		LeftButton.WinLeft		= 0;
		LeftButton.WinWidth 	= WinWidth - 12;
		LeftButton.Resized();
	}
	
	if(RightButton != none)
	{
		RightButton.WinLeft		= 0;
		RightButton.WinWidth 	= WinWidth - 12;
		RightButton.Resized();
	}
}
*/

function CreateEditBox ()
{
	EditBox = UWindowEditBox(CreateWindow(class'UWindowEditBox', 0, 0, WinWidth-12, WinHeight)); 
}

function CreateComboButton ()
{
	Button = UWindowComboButton(CreateWindow(class'UWindowComboButton', WinWidth-12, 0, 12, 10)); 
}

function CreateComboList ()
{
	List = UWindowComboList(Root.CreateWindow(ListClass, 0, 0, 100, 100)); 
}

function Created()
{
	Super.Created();

	CreateEditBox ();	
	EditBox.NotifyOwner = Self;
	EditBoxWidth = WinWidth;// / 2;
	EditBox.bTransient = True;

	CreateComboButton ();
	Button.Owner = Self;

	CreateComboList ();	
	List.LookAndFeel = LookAndFeel;
	List.Owner = Self;
	List.Setup();
	
	List.HideWindow();
	bListVisible = False;

	SetEditTextColor(LookAndFeel.EditBoxTextColor);
}

function SetButtons(bool bInButtons)
{
	bButtons = bInButtons;
	if(bInButtons)
	{
		LeftButton = UWindowComboLeftButton(CreateWindow(class'UWindowComboLeftButton', WinWidth-12, 0, 12, 10));
		RightButton = UWindowComboRightButton(CreateWindow(class'UWindowComboRightButton', WinWidth-12, 0, 12, 10));
	}
	else
	{
		LeftButton = None;
		RightButton = None;
	}
}

function Notify(byte E)
{
	Super.Notify(E);

	if(E == DE_LMouseDown)
	{
		if(!bListVisible)
		{
			if(!bCanEdit)
			{
				DropDown();
				Root.CaptureMouse(List);
			}
		}
		else
			CloseUp();
	}
}

function int FindItemIndex(string V, optional bool bIgnoreCase)
{
	return List.FindItemIndex(V, bIgnoreCase);
}

function RemoveItem(int Index)
{
	List.RemoveItem(Index);
}

function int FindItemIndex2(string V2, optional bool bIgnoreCase)
{
	return List.FindItemIndex2(V2, bIgnoreCase);
}

function Close(optional bool bByParent)
{
	if(bByParent && bListVisible)
		CloseUp();

	Super.Close(bByParent);
}

function SetNumericOnly(bool bNumericOnly)
{
	EditBox.bNumericOnly = bNumericOnly;
}

function SetNumericFloat(bool bNumericFloat)
{
	EditBox.bNumericFloat = bNumericFloat;
}

function SetFont(int NewFont)
{
	Super.SetFont(NewFont);
	EditBox.SetFont(NewFont);
	List.SetFont(NewFont);
}

function SetEditTextColor(Color NewColor)
{
	EditBox.SetTextColor(NewColor);
}

function SetEditable(bool bNewCanEdit)
{
	bCanEdit = bNewCanEdit;
	EditBox.SetEditable(bCanEdit);
}

function int GetSelectedIndex()
{
	return List.FindItemIndex(GetValue());
}

function SetSelectedIndex(int Index)
{
	SetValue(List.GetItemValue(Index), List.GetItemValue2(Index));
}

function string GetValue()
{
	return EditBox.GetValue();
}

function string GetValue2()
{
	return EditBox.GetValue2();
}

function SetValue(string NewValue, optional string NewValue2)
{
	EditBox.SetValue(NewValue, NewValue2);
}

function SetMaxLength(int MaxLength)
{
	EditBox.MaxLength = MaxLength;
}

function Paint(Canvas C, float X, float Y)
{
	LookAndFeel.Combo_Draw(Self, C);
	Super.Paint(C, X, Y);
}

function AddItem(string S, optional string S2, optional int SortWeight)
{
	List.AddItem(S, S2, SortWeight);
}

function InsertItem(string S, optional string S2, optional int SortWeight)
{
	List.InsertItem(S, S2, SortWeight);
}

function BeforePaint(Canvas C, float X, float Y)
{
	Super.BeforePaint(C, X, Y);
	LookAndFeel.Combo_SetupSizes(Self, C);
	List.bLeaveOnscreen = bListVisible && bLeaveOnscreen;
}

function CloseUp()
{
	bListVisible = False;
	EditBox.SetEditable(bCanEdit);
	EditBox.SelectAll();
	List.HideWindow();

	// Use the sound associated with the combobutton
	if( Button.DownSound != None )
	{
		GetPlayerOwner().PlaySound(Button.DownSound, SLOT_Interact);
	}
}

function DropDown()
{
	bListVisible = True;
	EditBox.SetEditable(False);
	List.ShowWindow();

	// Use the sound associated with the combobutton
	if( Button.DownSound != None )
	{
		GetPlayerOwner().PlaySound(Button.DownSound, SLOT_Interact);
	}
}

function Sort()
{
	List.Sort();
}

function ClearValue()
{
	EditBox.Clear();
}

function Clear()
{
	List.Clear();
	EditBox.Clear();
}

function FocusOtherWindow(UWindowWindow W)
{
	Super.FocusOtherWindow(W);

	if(bListVisible && W.ParentWindow != Self && W != List && W.ParentWindow != List)
		CloseUp();
}

defaultproperties
{
	ListClass=class'UWindowComboList'
	bNoKeyboard=True
}
