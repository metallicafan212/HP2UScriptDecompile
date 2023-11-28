//=============================================================================================
// M212FEBindPage: Creates a binding page based on externally loaded data, and switches modes
// depending on controller, or not the controller binding mode. Linked to FEInputPage closely.
//=============================================================================================
Class M212FEBindPage based on baseFEPage;

//=============================================================================================
// Omega: Main user variables
// The control map file is what defines how this menu will be dynamically constructed during runtime
// The lang file is an equivalent file that is used to create labels for the control map file
// Data on key translation is pulled from FEInputPage
var()	string				ControlMapFile;
var()	string				ControlLangFile;

var()	string				ControlMapFile_Controller;
var()	string				ControlLangFile_Controller;
// Omega: In case I need to change this later
var()	string				Delimiter;

var()	string				M212MenuLocalizationFile;

var		string				NextString;
var()	string				NextStringID;

var		string				PrevString;
var()	string				PrevStringID;

// Omega: Here's where it gets loaded:
var		Array<String>		ControlMap;
var		Array<String>		ControlNames;

var		Array<String>		RealKeyName; 		// So we can more easily map out our key names
var		Array<String>		LocalizedKeyName; 	// User visible name of our keys, loaded from translation files
//=============================================================================================
// What keys are allowed to only be used and managed by controllers
var		Array<int>			ControllerKeys;		
/*
200 "XInput DPad Up"
201 "XInput DPad Down"
202 "XInput DPad Left"
203 "XInput DPad Right"
204 "XInput Start"
205 "XInput Select"
206 "XInput Left Thumb"
207 "XInput Right Thumb"
208 "XInput Left Shoulder"
209 "XInput Right Shoulder"
210 "XInput A"
211 "XInput B"
212 "XInput X"
213 "XInput Y"
214 "Joy15"
215 "Joy16"
224 "XInput Left Stick X"
225 "XInput Left Stick Y"
226 "XInput Left Trigger"
227 "XInput Right Trigger"
232 "XInput Right Stick X"
233 "XInput Right Stick Y"
240 "JoyPovUp"
241 "JoyPovDown"
242 "JoyPovLeft"
243 "JoyPovRight"
*/
var		float				ControllerDeadZone;	// Dead zone for binding an axis, it's pretty high so
												// you're *definitely* sure you were trying to bind it
												// and not something else

//=============================================================================================
// Omega: So we can pull data from parent FEInputPage
var		FEInputPage			FEParent;
var		HPConsole			HPConsole;
var 	baseFEPage 			prevPageSaved;

// Omega: If we're in the controller version of the menu or not
var		bool				bControllerMenu;

// Omega: Page header label
var 	HGameLabelControl 	PageHeaderLabel;
var		string				HeaderText;
var		string				HeaderKeyboardID;
var		string				HeaderControllerID;
var		Vector				vHeaderPos;
var		int					HeaderLabelW;
var		int					HeaderLabelH;

// Omega: Other elements:
var 	HGameButton 		NextPageButton;
var 	HGameButton 		PrevPageButton;
var 	HGameLabelControl 	PreviousPageLabel;
var 	HGameLabelControl 	NextPageLabel;
var		Texture				TextureRightUp;
var		Texture				TextureRightRoll;
var		Texture				TextureLeftUp;
var		Texture				TextureLeftRoll;

var		int					PageButtonW;		// width
var		int					PageButtonH;		// height
var		int					PageLabelW;			// width
var		int					PageLabelH;

var		Vector				vNextPageButton;
var		Vector				vPrevPageButton;

var		Vector				vNextLabelOffset;
var		Vector				vPrevLabelOffset;

var		String				StringTextureRightUp;
var		String				StringTextureRightRoll;
var		String				StringTextureLeftUp;
var		String				StringTextureLeftRoll;

var		Sound				NextPageSound;
var		Sound				PrevPageSound;

// Omega: Very important runtime vars
var 	HGameButton 		SelectedButton;		// Selected button
var		int					iSelectedButton;	// Selected button's index in Element[]
var 	bool 				bPolling;			// Whether or not we're reading inputs for the menu
var 	int 				Selection;			// CachedElement index of our selection
var		int					CurrentPage;		// What page we're on in the menu
var		int					NumPages;			// Our number of pages

var		Array<int>			UpdateElements;		// Idk what's going on with an out array and AddItem, so global scope it is!

// Omega: Maximum elements stacked vertically
var		int					MaxElementsPerColumn;
var		int					MaxElementsPerPage;

// Omega: X axis
var		int					ControlLeftAlignment;
var		int					ControlRightAlignment;

var		int					LabelLeftAlignment;
var		int					LabelRightAlignment;

// Omega: Y Axis
var		int					SpaceFromTop;

// Omega: Button data
var		int					SpaceBetweenElements;

// Omega: Element Vars:
var		int					LabelWidth;
var		int					buttonWidth;
var		int					buttonHeight;
var		int					ControlH;
var		int					textHeight;
// Omega: Dynamically determined. See it when creating controls
var		int					textOffsetY;

// Omega: Our type of element
enum EElementType
{
	ET_None,		// Draw nothing
	ET_Control,		// Draw a label + control (colored label)
	ET_Label		// Draw a label only (white label)
};

//==============================================================================
//						   Bound keys/controller struct/array
//==============================================================================
struct SBoundKey
{
	// Omega: Key number, the command straight from the config, and the figured
	// out commands from the key, and an equivalent array of command categories
	// so we know how to proceed on rebinding. You cannot bind 2 commands of the 
	// same category, same as stock. However, we now have an expressive way of 
	// determining what our category is, using the ControlMaps. See the parsing
	// code for more details there
	var		int				KeyNum;
	var		string			RawCmd;
	var		array<string>	Commands;
	var		array<string>	Categories;
};

// Omega: Our array of keys
var		Array<SBoundKey> 	BoundKey;

//==============================================================================
//					  	  Cached Element/Binding Data
//==============================================================================
// Omega: Holds the data necessary to reconstruct the menu at different points
// so we can more easily set up the MenuElement struct
struct SCachedElement
{
	// Omega: Our element type. Blank will have no visible instances, control will have both 
	//classes active, label will have 
	var		EElementType	ElementType;
	
	// Omega: Category: Only binds from the same category cancel each other out
	var		string			Category;

	// Omega: Label thing
	var 	string 			LabelString;

	// Omega: Control things
	var		string			ControlString;
	// Omega: Actual command associated with our element
	var		string			BindCommand;
	// Omega: Key numbers associated with our element's binding
	var		Array<int>		iBoundKeys;
};

var		Array<SCachedElement>		CachedElement;

//==============================================================================
//						 Menu Element Struct and Array
//==============================================================================

struct 	SMenuElement
{
	// Omega: What index to read our cached element data from
	var		int					Index;

	// Omega: Basic info
	var		int					iColumn;
	var		int					iRow;

	// Omega: Element class instances:
	var 	HGameLabelControl 	Label;
	var 	HPMenuRaisedButton	Control;
};

// Omega: Our array of elements
var 	Array<SMenuElement>		Element;

//==============================================================================
//								End of Data
//==============================================================================

//==============================================================================
//						  User Utility functions:
//==============================================================================

// Omega: Get the bind string for the command we've been given
function String GetBindString(String Command, optional out int Index)
{
	local int i;
	for(i = 0; i < CachedElement.Length; i++)
	{
		if(CachedElement[i].BindCommand ~= Command)
		{
			Index = i;
			return CachedElement[i].ControlString;
		}
	}

	return "";
}

// Omega: More optimized version. If we need it a lot, we want to avoid iterating in the array
// So save the index from GetBindString
function String GetBindStringFromIndex(int Index)
{
	return CachedElement[Index].ControlString;
}

// Omega: Must be in the file or recursively creates menus because of parent...
// Treat like a "beginplay" function for our purposes
function Created()
{
	HPConsole = HPConsole(GetPlayerOwner().Player.Console);
}

// Omega: Create our elements in here
// Omega: Many data references are invalid during created, so we can't use it. FEInputPage will call this for us...
function InitializeBindPage()
{
	// Omega: Set up basic data first
	// Omega: Set up our text offset
	textOffsetY = (buttonHeight - textHeight) / 2;
	LabelWidth = ControlLeftAlignment - LabelLeftAlignment;

	// Omega: Set up the name of the control map language file:
	// Just appends the language extension to the end. Nothing special
	ControlLangFile = ControlLangFile $ "." $ GetLanguage();
	ControlLangFile_Controller = ControlLangFile_Controller $ "." $ GetLanguage();

	// Omega: Create the page header													And center this shit here
	PageHeaderLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',vHeaderPos.X - (Float(HeaderLabelW) * 0.5), vHeaderPos.Y, HeaderLabelW, HeaderLabelH));
	PageHeaderLabel.SetFont(4);
	PageHeaderLabel.TextColor.R 		= 255;
	PageHeaderLabel.TextColor.G 		= 255;
	PageHeaderLabel.TextColor.B 		= 255;
	PageHeaderLabel.Align = TA_Center;
	PageHeaderLabel.bShadowText = True;
	if(bControllerMenu)
	{
		HeaderText = Localize("all", HeaderControllerID, M212MenuLocalizationFile);
	}
	else
	{
		HeaderText = Localize("all", HeaderKeyboardID, M212MenuLocalizationFile);
	}
	PageHeaderLabel.SetText(HeaderText);

	LoadControlMap();

	// And then start parsing the data necessary to load the maps
	ParseControlMap();
	AllocateElements();

	// Omega: Now that the control map has been figured out, figure out our keybinds
	// Key names are resolved during this step as well
	LoadExistingKeys();

	CreateBackPageButton();

	// Omega: Now we need to set up page variables:
	NumPages = (CachedElement.Length - 1) / MaxElementsPerPage;

	SetupAdditonalButtons();
	// Omega: And start us on Page 0
	SetupControlPage(0);

	ResolutionChanged(Root.RealWidth, Root.RealHeight);
	RepositionChildControls();
}

function LoadControlMap()
{
	local int i;
	local String tmpStr;

	// Omega: Translate our key names first
	/*for(I = 0; I < 255; I++)
	{
		tmpStr 					= "0000" $ string(I);
		tmpStr 					= "Localized_kn_" $ Right(tmpStr,4);
		LocalizedKeyName[I] 	= Localize("all",tmpStr,"HPMenu");
	}*/
	// Omega: Far simpler than KW's solution but gonna require people to translate the file here too
	for(i = 0; i < 255; i++)
	{
		tmpStr 					= "Key" $i;
		LocalizedKeyName[i]		= Localize("all", tmpStr, M212MenuLocalizationFile);
	}

	if(!bControllerMenu)
	{
		// Omega: Now import our two arrays
		LoadStringArray(ControlMap, ControlMapFile); 	// Actual inputs
		LoadStringArray(ControlNames, ControlLangFile);	// Translatable labels

		// Omega: If the file didn't exist, we shouldn't have any length
		if(ControlNames.Length == 0)
		{
			Log(Self$ " Failed to load " $ControlLangFile$ " for input translation, reverting to INT");
			LoadStringArray(ControlNames, Default.ControlLangFile $".int");
		}
	}
	else
	{
		LoadStringArray(ControlMap, ControlMapFile_Controller); 	// Actual inputs
		LoadStringArray(ControlNames, ControlLangFile_Controller);	// Translatable labels

		// Omega: If the file didn't exist, we shouldn't have any length
		if(ControlNames.Length == 0)
		{
			Log(Self$ " Failed to load " $ControlLangFile_Controller$ " for input translation, reverting to INT");
			LoadStringArray(ControlNames, Default.ControlLangFile_Controller $".int");
		}
	}
}

function ShowWindow()
{
	Super.ShowWindow();
	// Omega: Also enable our background
	FEBook(ParentWindow).bShowMainBack = false;
	FEBook(ParentWindow).bShowNewBack = true;

	// Omega: Move us back to page 0
	SetupControlPage(0);
}

// Omega: Correct this:
function int GetStatusY()
{
	local float HScale;
	// Omega: Scale the GetStatusY function
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	//return (WinHeight * HScale) - 10;
	return (WinHeight - 10) * HScale;
	//return WinHeight - 26;
}

// Omega: Restore the previous page
// Doesn't work
/*function HideWindow()
{
	Super.HideWindow();
	FEBook(ParentWindow).prevPage = prevPageSaved;
}*/

// Omega: Buttons shamelessly stolen from the Folio page and modified
function SetupAdditonalButtons()
{
	// Omega: Load assets:
	textureRightUp 					= Texture(DynamicLoadObject(StringTextureRightUp,Class'Texture'));
	textureLeftUp					= Texture(DynamicLoadObject(StringTextureLeftUp,Class'Texture'));
	textureRightRoll 				= Texture(DynamicLoadObject(StringTextureRightRoll,Class'Texture'));
	textureLeftRoll					= Texture(DynamicLoadObject(StringTextureLeftRoll,Class'Texture'));

	/*
	vNextPageButton;
	vPrevPageButton;
	vNextLabelOffset;
	vPrevLabelOffset; 
	*/

	NextPageButton = HGameButton(CreateAlignedControl(Class'HGameButton',vNextPageButton.X,vNextPageButton.Y,PageButtonW,PageButtonH,,AT_Right));
	NextPageButton.Register(self);
	NextPageButton.UpTexture 		= textureRightUp;
	NextPageButton.DownTexture 		= textureRightUp;
	NextPageButton.OverTexture 		= textureRightUp;
	NextPageButton.DownSound		= NextPageSound;

	NextPageLabel = 
	HGameLabelControl(CreateAlignedControl(Class'HGameLabelControl',vNextPageButton.X + vNextLabelOffset.X, vNextPageButton.Y + vNextLabelOffset.Y, PageLabelW, PageLabelH,,AT_Right));

	NextPageLabel.SetFont(4);
	NextPageLabel.TextColor.R 		= 255;
	NextPageLabel.TextColor.G 		= 255;
	NextPageLabel.TextColor.B 		= 255;
	NextPageLabel.Align = TA_Right;
	NextPageLabel.bShadowText = True;
  
	PrevPageButton = HGameButton(CreateAlignedControl(Class'HGameButton',vPrevPageButton.X,vPrevPageButton.Y,PageButtonW,PageButtonH,,AT_Left));
	PrevPageButton.Register(self);
	PrevPageButton.UpTexture 			= textureLeftUp;
	PrevPageButton.DownTexture 			= textureLeftUp;
	PrevPageButton.OverTexture 			= textureLeftUp;
	PrevPageButton.DownSound			= PrevPageSound;
	
	PreviousPageLabel = 
	HGameLabelControl(CreateAlignedControl(Class'HGameLabelControl',vPrevPageButton.X + vPrevLabelOffset.X, vPrevPageButton.Y + vPrevLabelOffset.Y, PageLabelW, PageLabelH,,AT_Left));
	PreviousPageLabel.SetFont(4);
	PreviousPageLabel.TextColor.R 	= 255;
	PreviousPageLabel.TextColor.G 	= 255;
	PreviousPageLabel.TextColor.B 	= 255;
	PreviousPageLabel.Align 		= TA_Left;
	PreviousPageLabel.bShadowText 	= True;

	NextString = Localize("all", NextStringID, M212MenuLocalizationFile);
	PrevString = Localize("all", PrevStringID, M212MenuLocalizationFile);
}

// Omega: function to change pages. If you go oob, that's your fault. Handles it gracefully though
function SetupControlPage(int pageNum)
{
	local int i, startIndex;

	// Omega: Make sure this is done first lmfao
	CurrentPage = pageNum;

	// Omega: Set us up to the correct element for our page
	startIndex = pageNum * MaxElementsPerPage;
	for(i = 0; i < MaxElementsPerPage; i++)
	{
		// Omega: handle our control map being oob
		if(startIndex + i >= ControlMap.Length)
		{
			BlankOutElement(i);
		}
		else // We're in the clear, go!
		{
			Element[i].Index = startIndex + i;
			SetupElement(i);
		}
	}

	// Omega: Now assign the key names:
	for(i = 0; i < CachedElement.Length; i++)
	{
		AssignKeyName(i);
	}

	// Omega: Set up buttons for the page number:
	if(CurrentPage == 0)
	{
		PrevPageButton.bDisabled = True;
		PrevPageButton.HideWindow();
		PreviousPageLabel.SetText("");
	}
	else
	{
		PrevPageButton.bDisabled = False;
		PrevPageButton.ShowWindow();
		PreviousPageLabel.SetText(PrevString);
	}

	if(CurrentPage == NumPages)
	{
		NextPageButton.bDisabled = True;
		NextPageButton.HideWindow();
		NextPageLabel.SetText("");
	}
	else
	{
		NextPageButton.bDisabled = False;
		NextPageButton.ShowWindow();
		NextPageLabel.SetText(NextString);
	}

	// Omega: Hack to fix the elements breaking on page change
	ResolutionChanged(Root.RealWidth, Root.RealHeight);
	//Resized();
}

function Notify (UWindowDialogControl C, byte E)
{
	local int I;

	Super.Notify(C,E);

	switch (E)
	{
		case DE_Click:
			// Omega: Check the click against our logic
			CheckClick(C);

			// Omega: Validate the button and do our action based on it
			Switch(C)
			{
				case(BackPageButton):
					FEBook(book).DoEscapeFromPage();
					// Omega: Restore the previous page
					FEBook(ParentWindow).prevPage = prevPageSaved;
					return;

				case(NextPageButton):
					// Omega: Quick data modification, as a treat, so we can play the click sound but not possibly have side effects
					SelectedButton = NextPageButton;
					PlayClick();
					SelectedButton = None;
					SetupControlPage(CurrentPage + 1);
					return;

				case(PrevPageButton):
					SelectedButton = PrevPageButton;
					PlayClick();
					SelectedButton = None;
					SetupControlPage(CurrentPage - 1);
					return;
			}
			break;
	
		case DE_RClick:
			if ( bPolling )
			{
				bPolling = False;
				HPConsole.bLockMenus = False;
				SelectedButton.bDisabled = False;
				if ( C == SelectedButton )
				{
					ProcessKey(2);
					//ProcessKey(IK_RightMouse);
					return;
				}
			}
			break;
			
		case DE_MClick:
			if ( bPolling )
			{
				bPolling = False;
				HPConsole.bLockMenus = False;
				SelectedButton.bDisabled = False;
				if ( C == SelectedButton )
				{
					ProcessKey(4);
					//ProcessKey(IK_MiddleMouse);
					return;
				}
			}
			break;

		case DE_MouseEnter:
			Switch(C)
			{
				Case NextPageButton:
					SetRollover(NextPageButton,TextureRightRoll,None,False);
					break;
				Case PrevPageButton:
					SetRollover(PrevPageButton,TextureLeftRoll,None,False);
					break;
			}
			break;
		case DE_MouseLeave:
			Switch(C)
			{
				Case NextPageButton:
				Case PrevPageButton:
					ClearRollover();
					break;
			}
			break;

		default:
			return;
	}
}

// Omega: Check our click in here to see if it matches any control element
function CheckClick(UWindowDialogControl C)
{
	local int i;

	// Omega: Exit or process our left click
	if(bPolling)
	{
		bPolling = False;
		HPConsole.bLockMenus = False;
		SelectedButton.bDisabled = False;

		if(C == SelectedButton && !bControllerMenu)
		{
			ProcessKey(1); // Left Mouse
		}

		return;
	}

	// Omega: Early return for bad clicks
	if(C == None)
	{
		return;
	}

	//PlayClick();

	// Omega: Default to -1, so we know if it's been missed or not
	iSelectedButton = -1;

	for(i = 0; i < Element.Length; i++)
	{
		if(C == Element[i].Control)
		{
			Log("Found selected control: Element[" $i$"]: " $Element[i].Control$ " CachedElement's index: " $Element[i].Index);
			// Omega: Update our selection vars
			iSelectedButton = i;
			SelectedButton = Element[i].Control;
			Selection = Element[i].Index;

			// Omega: Now we're able to poll for inputs:
			SelectedButton.bDisabled = True;
			bPolling = True;
			HPConsole.bLockMenus = True;
		}
	}

	// Omega: Exit out if we can't do it
	if(iSelectedButton == -1 || SelectedButton == None)
	{
		SelectedButton.bDisabled = False;
		bPolling = False;
		HPConsole.bLockMenus = False;
		return;
	}
}

// Omega: Nitty gritty implementation
function bool KeyEvent (byte KeyNo, byte Action, float Delta)
{
	local int iAction;
	iAction = Action;

	// Omega: Let the controller scroll through the pages on left and right shoulder
	// Action == IST_Press
	if(!bPolling && iAction == 1)
	{
		// Xinput left shoulder
		if(KeyNo == 208 && !PrevPageButton.bDisabled)
		{
			Notify(PrevPageButton, DE_Click);
		}
		// XInput right shoulder
		if(KeyNo == 209 && !NextPageButton.bDisabled)
		{
			Notify(NextPageButton, DE_Click);
		}
	}

	// Omega: Check axis
	// Action == IST_Axis
	if(iAction == 4 && bPolling && ControllerKeys.Contains(KeyNo) && bControllerMenu)
	{
		// Omega: Check an axis if it's pressed very hard
		if(bControllerMenu && KeyNo < RealKeyName.Length && ABS(Delta) > ControllerDeadZone)
		{
			//Log("Controller Axis " $RealKeyName[KeyNo]$ " Delta is: " $Delta);
			ProcessKey(KeyNo);
			bPolling = False;
			HPConsole.bLockMenus = False;
			SelectedButton.bDisabled = False;
			return True;
		}
	}

	//Log("KeyEvent called! KeyNo = '" $ string(KeyNo) $ "' Action = " $ string(Action));
	// Omega: Check keyboard or button key
	if ( Action == 1 && bPolling && KeyNo >= 5 )
	{
		/*if(bControllerMenu && KeyNo < RealKeyName.Length)
		{
			Log("Controller Menu: KeyEvent: " $RealKeyName[KeyNo]);
		}*/
		//Log("ProcessKey called! KeyNo = '" $ string(KeyNo) $ "Action = " $ string(Action));
		//ProcessKey(EInputKey(KeyNo));
		ProcessKey(KeyNo);
		bPolling = False;
		HPConsole.bLockMenus = False;
		SelectedButton.bDisabled = False;
		return True;
	}
	
	return Super.KeyEvent(KeyNo,Action,Delta);
}

function ProcessKey(int KeyNo)
{
	local string KeyName;

	// Omega: Look up the key name from the parent
	KeyName = RealKeyName[KeyNo];
	//Log("InputPage selection:" $ string(Selection) $ " has AliasNames1:'" $ AliasNames1[Selection] $ "' attempt to set as " $ string(KeyNo) $ ":" $ KeyName);
	//PlayClick();
	
	/*if ( (KeyName == "") || (KeyName == "Escape") 
	// Metallicafan212:	F1-F9
	|| (KeyNo >= 112) && (KeyNo <= 121) 
	// Metallicafan212:	0-9
	|| (KeyNo >= 48) && (KeyNo <= 57) 
	// Metallicafan212: Fucking unknown????
	|| (KeyNo == 91) || (KeyNo == 92) || (KeyNo == 93) 
	// Metallicafan212: Mouse wheel
	|| (KeyNo == 236) || (KeyNo == 237) )
	{
		return;
	}*/
	// Omega: We're not limiting our keybinds hard at all. Escape is the only reservation
	if(!bControllerMenu && ((KeyName == "") || KeyName == "Escape" || ControllerKeys.Contains(KeyNo)))
	{
		Log("Keyboard doesn't have bind, or reserved for utility:");
		return;
	}
	else
	//204 "XInput Start", 224 "XInput Left Stick X", 225 "XInput Left Stick Y", 232 "XInput Right Stick X", 233 "XInput Right Stick Y"
	if(bControllerMenu && ((KeyName == "") || !ControllerKeys.Contains(KeyNo) || KeyNo == 204 || KeyNo == 224 || KeyNo == 225
	|| KeyNo == 232 || KeyNo == 233))
	{
		log("Controller doesn't have bind, or reserved for utility: " $KeyNo$ " Key name: " $KeyName);
		return;
	}
	
	Log("BindPage KeyNo = " $ string(KeyNo) $ " keyName = " $ KeyName $ ", got through filters!");

	// Omega: Actually bind the key here, then save the config:
	BindKey(KeyNo, KeyName);
	GetPlayerOwner().SaveConfig();
}

// Omega: Yeah, we're faking the button sound. Deal with it
function PlayClick()
{
	if(SelectedButton.DownSound != None)
	{
		GetPlayerOwner().PlaySound(SelectedButton.DownSound, SLOT_None, , , 100000, , true);
	}
}

//==============================================================================
//						Parsing Control Map and Language
//==============================================================================

function ParseControlMap()
{
	local int i;
	local PlayerPawn PP;	// God, why the fuck is ParseDelimitedString in Actor lmfao
	PP = GetPlayerOwner();
	for(i = 0; i < ControlMap.Length; i++)
	{
		// Omega: We need to add to the array, it doesn't auto-add to struct arrays like other elements
		CachedElement.Add();

		// Omega: If we don't have a valid command here, we treat as a bind: "category:bind" format
		if(!ParseControlCommand(i))
		{
			CachedElement[i].ElementType 	= ET_Control;
			CachedElement[i].Category 		= PP.ParseDelimitedString(ControlMap[i], Delimiter, 1, false);
			CachedElement[i].BindCommand 	= PP.ParseDelimitedString(ControlMap[i], Delimiter, 2, false);
		}
		ParseControlNames(i);
	}
}
// Omega: Handles checking for control commands and sets our elements up correctly
// Label will read the language file for a label, blank will be a blank element slot
// Otherwise, we're a command, and we need to be treated as a command.
// Commands obviously also read from the language file to determine their label name
function bool ParseControlCommand(int i)
{
	switch(ControlMap[i])
	{
		Case("label"):
			CachedElement[i].ElementType = ET_Label;
			return true;
			
		Case(""):
		Case("blank"):
			CachedElement[i].ElementType = ET_None;
			return true;

		// Omega: We don't have a valid command here
		Default:
			return false;
	}
}

function ParseControlNames(int i)
{
	// Omega: Bail if we're gonna go oob
	if(i >= ControlNames.Length)
	{
		Log(Self$ " Element " $i$ " in ControlNames was none when it apparently shouldn't be!! Check your " $ControlLangFile$ " file!!!!");
		CachedElement[i].LabelString = "";
		return;
	}
	// And grab it, or blank it if we don't need it
	if(CachedElement[i].ElementType != ET_None)
	{
		CachedElement[i].LabelString = ControlNames[i];
		// Omega: Check if our localization contains a command
		ParseLocalizationCommand(CachedElement[i].LabelString);
	}
	else
	{
		CachedElement[i].LabelString = "";
	}
}

// Omega: Come up with syntax later to be able to reference a localization file external to this
// This will let us easily set up a Stock game compatible page
function ParseLocalizationCommand(out String CheckName)
{
	local String Command, Bak;
	local PlayerPawn PP;

	Bak = CheckName;

	PP = GetPlayerOwner();

	Command = PP.ParseDelimitedString(CheckName, ".", 1, False);

	// Omega: Localize our control map name:
	// Formatted like: "Localization.HPMenu.Options_0038"
	// Would produce In Wizard Duelling, but localized with our current language
	if(Command ~= "Localization")
	{
		CheckName = Localize("all", PP.ParseDelimitedString(CheckName, ".", 3, False), PP.ParseDelimitedString(CheckName, ".", 2, False));
		Log(Self$ " Localized " $Bak$ " Into " $CheckName);
	}
}

// Omega: Allocate our elements
function AllocateElements()
{
	local int i, labelX, ctlx, ctlY;

	for(i = 0; i < MaxElementsPerPage; i++)
	{
		// Add the elements, then write to it
		Element.Add();
		// First chunk it up, then use modulo to figure out what column it's in, 1 or 2
		Element[i].iColumn 	= (i / MaxElementsPerColumn) % 2;
		// Easy enough
		Element[i].iRow		= (i % MaxElementsPerColumn);

		// Omega: Set up our X coords
		if(Element[i].iColumn == 0)
		{
			labelX 	= LabelLeftAlignment;
			ctlX 	= ControlLeftAlignment;
		}
		else
		{
			labelX 	= LabelRightAlignment;
			ctlX	= ControlRightAlignment;
		}

		// Now the Y
		ctlY = SpaceFromTop + (SpaceBetweenElements * Element[i].iRow);

		//CreateControl(class<UWindowDialogControl> ControlClass, float X, float Y, float W, float H, optional UWindowWindow OwnerWindow)

		// Label Setup
		//CreateAlignedControl(Class'HGameButton', 30.0, 16.0, 64.0, 64.0,,AT_Left)
		Element[i].Label	= HGameLabelControl(CreateAlignedControl(class'HGameLabelControl', labelX, ctlY + textOffsetY, LabelWidth, 1.0,,AT_Center));

		Element[i].Label.SetText("");
		Element[i].Label.SetFont(1);
		Element[i].Label.TextColor 				= FEParent.LabelTextColor;

		// Control Setup
		Element[i].Control 	= HPMenuRaisedButton(CreateAlignedControl(class'HPMenuRaisedButton', ctlX, ctlY, buttonWidth, ControlH,,AT_Center));

		Element[i].Control.UpTexture 			= FEParent.HoverImage5;
		Element[i].Control.DownTexture 			= FEParent.HoverImage;
		Element[i].Control.DisabledTexture 		= FEParent.HoverImage;
		Element[i].Control.OverTexture 			= FEParent.HoverImage3;
		Element[i].Control.SetFont(0);
		Element[i].Control.bAcceptsFocus 		= false;
		Element[i].Control.bIgnoreLDoubleClick 	= true;
		Element[i].Control.bIgnoreMDoubleClick 	= true;
		Element[i].Control.bIgnoreRDoubleClick 	= true;
		Element[i].Control.TextColor 			= FEParent.ButtonTextColor;

		HideChildWindow(Element[i].Label);
		HideChildWindow(Element[i].Control);
	}
}

// Omega: Set up a specific element
function SetupElement(int i)
{
	local int MapIndex;

	MapIndex = Element[i].Index;

	if(CachedElement[MapIndex].ElementType == ET_None)
	{
		BlankOutElement(i);
	}
	else
	if(CachedElement[MapIndex].ElementType == ET_Label)
	{
		ShowChildWindow(Element[i].Label);
		HideChildWindow(Element[i].Control);

		// Setup Label params
		Element[i].Label.SetText(CachedElement[MapIndex].LabelString);
		Element[i].Label.TextColor = FEParent.GoupLabelTextColor;
	}
	else
	if(CachedElement[MapIndex].ElementType == ET_Control)
	{
		ShowChildWindow(Element[i].Label);
		ShowChildWindow(Element[i].Control);

		// Setup Label params
		Element[i].Label.SetText(CachedElement[MapIndex].LabelString);
		Element[i].Label.TextColor = FEParent.LabelTextColor;

		// Omega: We actually can't update key names in here, since the data necessary is loaded later
		// TODO: Update with the keys we need placed in here!!!
		//Element[i].Control.SetText(CachedElement[MapIndex].LabelString);
	}
}

// Omega: Blank out a specific element
function BlankOutElement(int i)
{
	// Omega: Might be ill advised...
	Element[i].Index = -1;
	HideChildWindow(Element[i].Label);
	HideChildWindow(Element[i].Control);
}

// Omega: Assigning a key name to a control button. EG: Forward could have its control say "W or E"
function AssignKeyName(int index)
{
	local int i, cachedIndex;
	//local String LogMe;

	// Omega: Clear and early return if we're not a control
	if(CachedElement[index].ElementType != ET_Control)
	{
		CachedElement[index].ControlString = "";
		return;
	}

	// Omega: First update the cached element
	for(i = 0; i < CachedElement[index].iBoundKeys.Length; i++)
	{
		if(i == 0)
		{
			// Omega: First one does not recieve an "or"
			CachedElement[index].ControlString = LocalizedKeyName[CachedElement[index].iBoundKeys[i]];
		}
		else
		{
			// "Or" goes here c:
			CachedElement[index].ControlString = CachedElement[index].ControlString $ FEParent.OrString $ LocalizedKeyName[CachedElement[index].iBoundKeys[i]];
		}
		//Log("CachedElement[" $index$ "].ControlString = " $CachedElement[index].ControlString);
	}

	// Omega: Catch if we have no length
	if(CachedElement[index].iBoundKeys.Length == 0)
	{
		CachedElement[index].ControlString = "";
	}

	/*LogMe = CachedElement[index].LabelString$ ": Keys:";
	for(i = 0; i < CachedElement[Index].iBoundKeys.Length; i++)
	{
		LogMe = LogMe$ " " $CachedElement[Index].iBoundKeys[i];
	}
	Log(LogMe);*/

	// Omega: Update all element keys
	for(i = 0; i < Element.Length; i++)
	{
		cachedIndex = Element[i].Index;
		Element[i].Control.SetText(CachedElement[cachedIndex].ControlString);
		//Log("Element[" $i$"] Control: " $Element[i].Control$ " Text: " $Element[i].Control.Text$ " Should be: " $CachedElement[cachedIndex].ControlString);
		//Log("Element[" $i$ "].Index is : " $Element[i].Index);
	}
}

//==============================================================================
//							Keybinding Utilities
//==============================================================================
function LoadExistingKeys()
{
	local int i, j, k, KeyNumber;
	local string Alias, KeyName, UnknownCommand;
	local PlayerPawn PP;
	local bool bBind;

	// Omega: We'll being doing this a lot, keep the reference around
	PP = GetPlayerOwner();
	// 255 keys to check
	for(i = 0; i < 255; i++)
	{
		// Omega: Reset this every go
		bBind = True;
		// Omega: Validate for controller
		if(!bControllerMenu && ControllerKeys.Contains(i))
		{
			//Log(Self $" Not a controller menu and the key number contains a controller key: " $i);
			bBind = False;
		}
		else
		if(bControllerMenu && !ControllerKeys.Contains(i))
		{
			//Log(Self $" Is a controller menu and the key number doesn't contain a controller key: " $i);
			bBind = False;
		}

		KeyName = PP.ConsoleCommand("KEYNAME " $I);
		RealKeyName[i] = KeyName;
		
		// Check for real keyname so we don't cause any issues
		if(KeyName != "" && bBind)
		{
			Alias = PP.ConsoleCommand("KEYBINDING " $KeyName);
			// We need a valid command on the key
			if(Alias != "")
			{
				Alias = Caps(Alias);

				// Omega: Set up the bound key list here as well:
				BoundKey.Add();
				BoundKey[BoundKey.Length - 1].KeyNum = i;
				BoundKey[BoundKey.Length - 1].RawCMD = Alias;

				// Omega: Check our cached element list for the bind now
				for(j = 0; j < CachedElement.Length; j++)
				{	
					// Omega: check if the bind command is not blank, and check if it's in our string
					if(CachedElement[j].BindCommand != "" && InStr(Alias, Caps(CachedElement[j].BindCommand)) != -1)
					{
						CachedElement[j].iBoundKeys.AddItem(i);
						// Set up bound key list here too
						BoundKey[BoundKey.Length - 1].Commands.AddItem(Caps(CachedElement[j].BindCommand));	// Command
						BoundKey[BoundKey.Length - 1].Categories.AddItem(CachedElement[j].Category);		// Category
						//Log(Self$ " Found keybind for " $CachedElement[j].LabelString$ " On Key: " $KeyName);
					}
				}
			}
		}
	}
	// Clear j for our use in a while loop
	j = 0;
	// Omega: Now that we've figured out the keybinds that exist in the keys inside of menus, we need to figure out ones
	// That are bound without any associated menu action
	//Log("Reached unknown command checking");
	for(i = 0; i < BoundKey.Length; i++)
	{
		// Omega: Iterate the string until we reach an unknown element, or nothing at all
		//while(InStr(UnknownCommand, CachedElement[j].BindCommand) != -1)
		while(true)
		{
			UnknownCommand = PP.ParseDelimitedString(BoundKey[i].RawCMD, "|", j + 1, false);
			// Omega: Clean this string up now
			UnknownCommand = StripSpaces(UnknownCommand);

			if(Len(UnknownCommand) == 0)
			{
				//Log(Self$ " Out of, or no unknown commands found for key # " $BoundKey[i].KeyNum);
				break;
			}

			if(ValidateUnknownCommand(i, UnknownCommand))
			{
				//Log(Self$ " Unknown command " $UnknownCommand$ " found for key # " $BoundKey[i].KeyNum);
				BoundKey[i].Commands.AddItem(UnknownCommand);
				BoundKey[i].Categories.AddItem("__UNK__");
			}

			j++;
		}
		
		// Omega: Reset for the loop
		j = 0;
	}
}

// Omega: More complex logic for determining if a command is unknown or known
function bool ValidateUnknownCommand(int Index, string Command)
{
	local int i;
	local bool bReturn;

	// Omega: Directly check if the command exists or not
	if(!BoundKey[Index].Commands.Contains(Command))
	{
		bReturn = True;
	}

	// Omega: And now see if it exists in any strings for split commands
	for(i = 0; i < BoundKey[Index].Commands.Length; i++)
	{
		// Omega: if we return an amount other than -1, we have it in a string here
		//Log("Check if " $Command$ " Is inside of " $BoundKey[Index].Commands[i]);
		if(InStr(BoundKey[Index].Commands[i], Command) != -1)
		{
			bReturn = False;
			break;
		}
	}

	return bReturn;
}

// Omega: Actually bind the key and handle collisions
function BindKey(int iKey, string KeyName)
{
	local int i, j, PreserveKey;
	local Array<int> CurrentKeys, RemoveKeys;
	// Omega: Make the fun noise since left click also causes this
	// Interestingly enough is an inconsistency in stock... wonder if anyone will notice this change here to mine
	// Yeah it's a bit hacky. live with it
	if(iKey != 1)
	{
		PlayClick();
	}

	// Omega: Easy backup of keys
	CurrentKeys = CachedElement[Selection].iBoundKeys;

	//Log("Currently bound keys: " $CurrentKeys[0]$ ", " $CurrentKeys[1]);

	// Key contained in element with an additional bind
	if(CurrentKeys.Contains(iKey) && CurrentKeys.Length > 1)
	{
		Log("We contain the key, so we need to remove our other element!");
		// Omega: Populate our list of keys that need removal
		for(i = 0; i < CurrentKeys.Length; i++)
		{
			if(CurrentKeys[i] != iKey)
			{
				Log("Adding key: " $CurrentKeys[i]$ " To list of keys to remove!");
				RemoveKeys.AddItem(CurrentKeys[i]);
				// Omega: Also remove the bound key from our cached element's list of them
				CachedElement[Selection].iBoundKeys.RemoveItem(CurrentKeys[i]);
			}
		}

		// Omega: Double loop through each key to see what we need to remove, and remove it
		for(i = 0; i < BoundKey.Length; i++)
		{
			for(j = 0; j < RemoveKeys.Length; j++)
			{
				// Omega: If we're in here, remove the command
				if(BoundKey[i].KeyNum == RemoveKeys[j])
				{
					RemoveBoundCommand(i, CachedElement[Selection].BindCommand);
				}
			}
		}

		// Omega: And add us to the list of binds to update visually
		UpdateElements.AddItem(Selection);
	}
	else
	// Omega: If we try the same key again, just don't
	if(CurrentKeys.Contains(iKey) && CurrentKeys.Length == 1)
	{
		Log("We've just tried to bind the same thing again, cancel out");
		return;
	}
	else
	if(!CurrentKeys.Contains(iKey))
	{
		Log("We don't contain the key we're trying to bind, so bind it anew!");
		// Omega: UpdateElements is put into an out variable
		BindNewKey(iKey);
	}

	Log("Assigned key " $iKey$ ": " $KeyName$ " for command: " $CachedElement[Selection].BindCommand);

	// Omega: Assign the key names of everything we just touched, or possibly tickled
	// Hopefully the check for no length fixed this:
	for(i = 0; i < UpdateElements.Length; i++)
	{
		Log("Assigning key name for : " $CachedElement[UpdateElements[i]].LabelString$ " i = " $i);
		AssignKeyName(UpdateElements[i]);
	}
}

// Omega: Seperate this out so BindKey is more high-level, and this is the nitty gritty, hitting the griddy
function BindNewKey(int iKey)
{
	local int i, j, PreserveKey, ElementCollision;
	local Array<int> CurrentKeys, RemoveKeys, NewKeys;
	local bool bCollidedElement;

	// Omega: Easy backup of keys
	CurrentKeys = CachedElement[Selection].iBoundKeys;

	// Omega: Check new bind collisions and deal with it
	for(i = 0; i < CachedElement.Length; i++)
	{
		// Omega: Check other elements for the key, and if that element matches our category it's considered a collison
		if(CachedElement[i].iBoundKeys.Contains(iKey) && i != Selection && CachedElement[i].Category == CachedElement[Selection].Category)
		{
			Log("Found collision between: " $CachedElement[Selection].LabelString$ " and " $CachedElement[i].LabelString$ "! Second one loses, lmoa");
			bCollidedElement = True;
			ElementCollision = i;
			break;
		}
	}
	// Omega: Deal with the collision
	if(bCollidedElement)
	{
		// Omega: Remove the key, and add it to the list that needs to be unbound from the collided's command
		CachedElement[ElementCollision].iBoundKeys.RemoveItem(iKey);
		RemoveKeys.AddItem(iKey);

		// Omega: Double loop through each key to see what we need to remove, and remove it
		for(i = 0; i < BoundKey.Length; i++)
		{
			for(j = 0; j < RemoveKeys.Length; j++)
			{
				// Omega: If we're in here, remove the command
				if(BoundKey[i].KeyNum == RemoveKeys[j])
				{
					// Omega: The command from the ElementCollision here
					RemoveBoundCommand(i, CachedElement[ElementCollision].BindCommand);
				}
			}
		}

		// Omega: Empty once we're done
		RemoveKeys.Empty();

		UpdateElements.AddItem(ElementCollision);
		UpdateElements.Additem(Selection);
	}

	// Omega: If we're already above 1 key on the element, clear out the others and keep only the first
	// It will be reassigned to the second slot in the element
	if(CurrentKeys.Length > 1)
	{
		PreserveKey = CurrentKeys[0];
		// Omega: Now put the rest into RemoveKeys, and remove from our Element. We start at 1 because we don't want index 0 taken from us
		for(i = 1; i < CurrentKeys.Length; i++)
		{
			Log("Adding key: " $CurrentKeys[i]$ " To list of keys to remove!");
			RemoveKeys.AddItem(CurrentKeys[i]);
			//CachedElement[Selection].iBoundKeys.RemoveItem(CurrentKeys[i]);
		}
		// Omega: Add our new keys to the array
		NewKeys[0] = iKey;
		NewKeys[1] = PreserveKey;

		CachedElement[Selection].iBoundKeys = NewKeys;
		UpdateElements.AddItem(Selection);

		// Omega: Double loop through each key to see what we need to remove, and remove it
		for(i = 0; i < BoundKey.Length; i++)
		{
			for(j = 0; j < RemoveKeys.Length; j++)
			{
				// Omega: If we're in here, remove the command
				if(BoundKey[i].KeyNum == RemoveKeys[j])
				{
					RemoveBoundCommand(i, CachedElement[Selection].BindCommand);
				}
			}
		}
	}
	// Omega: If we have either 0 or 1 bound keys, we go here
	else
	{
		// Omega: Check for already bound. We'll be inserting before it later
		if(CurrentKeys.Length > 0)
		{
			NewKeys.InsertItem(0, CurrentKeys[0]);
		}
		// Omega: Put our new key in
		NewKeys.InsertItem(0, iKey);
		// And assign it
		CachedElement[Selection].iBoundKeys = NewKeys;

		UpdateElements.AddItem(Selection);
	}

	// Omega: Finally, add the command
	AddBoundCommand(iKey, CachedElement[Selection].BindCommand, CachedElement[Selection].Category);
}

// Omega: Add a command, with its category
function AddBoundCommand(int iKey, string Command, string Category)
{
	local int i, KeyIndex;

	KeyIndex = -1;

	// Omega: Check if we can find it
	for(i = 0; i < BoundKey.Length; i++)
	{
		if(BoundKey[i].KeyNum == iKey)
		{
			KeyIndex = i;
			break;
		}
	}
	// Omega: Check if we didn't find one, and allocate a brand new BoundKey entry
	if(KeyIndex == -1)
	{
		// Omega: Hey look, a fun trick to not have to do -1!
		KeyIndex = BoundKey.Length;
		BoundKey.Add();
		BoundKey[KeyIndex].KeyNum = iKey;
	}

	// Omega: Now update the list with these at the front
	BoundKey[KeyIndex].Commands.InsertItem(0, Command);
	BoundKey[KeyIndex].Categories.InsertItem(0, Category);

	// Omega: And then bind it
	UpdateBindCommand(KeyIndex);
}

// Omega: Remove a command that's bound to a key
function RemoveBoundCommand(int Index, string Command)
{
	local Array<String> NewCommands, NewCategories;
	local int i, ComIndex;
	/*BoundKey[Index].Commands;
	BoundKey[Index].Categories; */
	ComIndex = -1;
	// Omega: Find our index and save it
	for(i = 0; i < BoundKey[Index].Commands.Length; i++)
	{
		if(BoundKey[Index].Commands[i] ~= Command)
		{
			Log("Found index to remove in bind!");
			ComIndex = i;
			break;
		}
	}

	// Omega: Bail if we didn't find it. Shouldn't be able to run once the menu is complete
	if(ComIndex == -1)
	{
		return;
	}

	// Omega: Construct an array sans the removed command
	for(i = 0; i < BoundKey[Index].Commands.Length; i++)
	{
		if(i != ComIndex)
		{
			NewCommands.AddItem(BoundKey[Index].Commands[i]);
			NewCategories.AddItem(BoundKey[Index].Categories[i]);
		}
	}

	BoundKey[Index].Commands = NewCommands;
	BoundKey[Index].Categories = NewCategories;
	// Omega: Now update the bind command
	UpdateBindCommand(Index);
}

// Omega: Update the command for the key and bind it. If the commands are the same as before, it will remain that way
function UpdateBindCommand(int Index)
{
	local int i, BindingKey;
	local string NewBindCommand;

	// Omega: Grab the key number
	BindingKey = BoundKey[Index].KeyNum;

	for(i = 0; i < BoundKey[Index].Commands.Length; i++)
	{
		if(i == 0)
		{
			NewBindCommand = BoundKey[Index].Commands[i];
		}
		else
		{
			NewBindCommand = NewBindCommand$ " | " $BoundKey[Index].Commands[i];
		}
	}
	BoundKey[Index].RawCMD = NewBindCommand;

	// Omega: Now bind it
	GetPlayerOwner().ConsoleCommand("Set Input " $RealKeyName[BindingKey] @ NewBindCommand);
}

// Omega: Strip spaces from the start and end of a string
function string StripSpaces(string Input)
{
	local string S, Out, Front, End;
	local int i;
	S = Input;

	Front = CharAt(Input, 0);
	End = CharAt(Input, Len(Input) - 1);

	//Log(S$ ": Front of : " $Front$ ". Back of: " $End$ ".");

	if(Front ~= " ")
	{
		S = Right(S, Len(S) - 1);
	}

	if(End ~= " ")
	{
		S = Left(S, Len(S) - 1);
	}

	Out = S;
	
	//Log(Self$ " Stripped spaces from: " $S);

	return Out;
}

defaultproperties
{
	// Dead zone for controller binding. High, so you're absolutely sure this is the axis you wanted
	ControllerDeadZone=0.65

	// Our control map and language map filenames
	ControlMapFile="M212ControlMap.gin" // Stands for "Great Input Napping", or otherwise what this class was driving me to drink while writing it
	// Omega: This gets your language appended to it, or falls back to int
	ControlLangFile="M212ControlMap_Lang"
	// Omega: Controller specific map
	ControlMapFile_Controller="M212ControlMap_Controller.gin" 
	ControlLangFile_Controller="M212ControlMap_Controller_Lang"

	Delimiter=":"

	HeaderKeyboardID="M212KeyboardMenu"
	HeaderControllerID="M212ControllerMenu"

	vHeaderPos=(X=320,Y=20,Z=0)
	HeaderLabelW=200
	HeaderLabelH=28

	StringTextureRightUp="HP2_Menu.Hud.HP2FolioRightOver"
	StringTextureLeftUp="HP2_Menu.Hud.HP2FolioLeftOver"

	StringTextureRightRoll="HP2_Menu.Hud.HP2FolioRightOver"
	StringTextureLeftRoll="HP2_Menu.Hud.HP2FolioLeftOver"

	M212MenuLocalizationFile="M212Menu"
	NextStringID="M212MenuNextPage"
	PrevStringID="M212MenuPrevPage"

	NextPageSound=Sound's_menu_click'
	PrevPageSound=Sound's_menu_click'

	// X Axis
	ControlLeftAlignment=130
	ControlRightAlignment=430

	LabelLeftAlignment=15
	LabelRightAlignment=330

	// Y Axis
	SpaceFromTop=40
	SpaceBetweenElements=32

	// Omega: maximum of 24 elements, 2 columns, labels included in count as an element
	MaxElementsPerColumn=12
	MaxElementsPerPage=24

	// Omega: Element vars
	buttonWidth=180
	buttonHeight=24
	textHeight=10
	ControlH=17

	// Omega: Next/Prev button vars
	vNextPageButton=(X=534.0,Y=422.0,Z=0)
	vPrevPageButton=(X=5.0,Y=422.0,Z=0)

	PageButtonW=32
	PageButtonH=32

	vNextLabelOffset=(X=-105.0,Y=5.0,Z=0)
	vPrevLabelOffset=(X=37,Y=5.0,Z=0)

	PageLabelW=100
	PageLabelH=28
	
	// copied from the folio book
	//vNextPageButton=(X=605.0,Y=316.0,Z=0)
	//vPrevPageButton=(X=5.0,Y=316.0,Z=0)

	//vNextLabelOffset=(X=-105.0,Y=5.0,Z=0)
	//vPrevLabelOffset=(X=37,Y=5.0,Z=0)


	// Omega: XInput variables: See variable definition to match this list with the actual inputs
	ControllerKeys(0)=200
	ControllerKeys(1)=201
	ControllerKeys(2)=202
	ControllerKeys(3)=203
	ControllerKeys(4)=204
	ControllerKeys(5)=205
	ControllerKeys(6)=206
	ControllerKeys(7)=207
	ControllerKeys(8)=208
	ControllerKeys(9)=209
	ControllerKeys(10)=210
	ControllerKeys(11)=211
	ControllerKeys(12)=212
	ControllerKeys(13)=213
	ControllerKeys(14)=214
	ControllerKeys(15)=215
	ControllerKeys(16)=224
	ControllerKeys(17)=225
	ControllerKeys(18)=226
	ControllerKeys(19)=227
	ControllerKeys(20)=232
	ControllerKeys(21)=233
	ControllerKeys(22)=240
	ControllerKeys(23)=241
	ControllerKeys(24)=243
}