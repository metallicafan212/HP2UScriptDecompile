//================================================================================
// FEInputPage.
//================================================================================

class FEInputPage extends baseFEPage;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\FEOverOption5Texture.PNG	GROUP=Icons	Name=FEOverOption5Texture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEOverOptionTexture.PNG	GROUP=Icons	Name=FEOverOptionTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEOverOption3Texture.PNG	GROUP=Icons	Name=FEOverOption3Texture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2

const InWizardDuel_LastBoundKeyIndex= 13;
const InWizardDuel_FirstBoundKeyIndex= 12;
const InQuidditch_LastBoundKeyIndex= 12;
const InQuidditch_FirstBoundKeyIndex= 11;
const InGame_LastBoundKeyIndex= 11;
const InGame_FirstBoundKeyIndex= 0;

enum EKeyType 
{
	KT_Game,
	KT_Quidditch,
	KT_WizardDuel
};

var bool bInitialized;
var string OldSettings;
var HGameButton OptionsLabel;
var localized string optionsText;
var HGameLabelControl InGame_Label;
var localized string InGame_Text;
var HGameLabelControl MiscLabel;
var localized string MiscText;
var HGameLabelControl InQuidditch_Label;
var localized string InQuidditch_Text;
var HGameLabelControl InWizardDuel_Label;
var localized string InWizardDuel_Text;
var HGameCheckbox AutoCenterCamCheck;
var localized string AutoCenterCamText;
var HGameCheckbox AutoDrinkPotionCheck;
var localized string AutoDrinkPotionText;
var HGameCheckbox MoveWhileCastingCheck;
var localized string MoveWhileCastingText;
var HGameHSlider SensitivitySlider;
var HGameCheckbox MouseInvertCheck;
var localized string MouseInvertText;
var HGameLabelControl MouseSensitivityLabel;
var localized string MouseSensitivityText;
var HGameLabelControl MouseHiLabel;
var HGameLabelControl MouseLoLabel;
var localized string MouseHiText;
var localized string MouseLoText;
var UWindowEditControl SensitivityEdit;
var localized string SensitivityText;
var HGameCheckbox MouseSmoothCheck;
var localized string MouseSmoothText;
var HPMessageBox ConfirmSettings;
var localized string ConfirmSettingsTitle;
var localized string ConfirmSettingsText;
var localized string ConfirmSettingsCancelTitle;
var localized string ConfirmSettingsCancelText;
var HGameLabelControl KeyboardLabel;
var localized string KeyboardText;
var string RealKeyName[255];
var localized string LocalizedKeyName[255];
var localized string OrString;
var HGameButton SelectedButton;
var bool bPolling;
var int Selection;
var string AliasNames1[14];
var string AliasNames2[14];
var string AliasNames3[14];
var int BoundKey1[13];
var int BoundKey2[14];
var int RemoveExistingBoundKeyMinIndex;
var int RemoveExistingBoundKeyMaxIndex;
var EKeyType SetKeyType;
var localized string InGame_LabelList[11];
var HGameLabelControl InGame_KeyNames[11];
var HPMenuRaisedButton InGame_KeyButtons[11];
var int InGame_VertSpacing[11];
var localized string InQuidditch_LabelList[2];
var HGameLabelControl InQuidditch_KeyNames[2];
var HPMenuRaisedButton InQuidditch_KeyButtons[2];
var int InQuidditch_VertSpacing[2];
var localized string InWizardDuel_LabelList[2];
var HGameLabelControl InWizardDuel_KeyNames[2];
var HPMenuRaisedButton InWizardDuel_KeyButtons[2];
var int InWizardDuel_VertSpacing[2];
var HGameCheckbox AutoJumpCheck;
var localized string AutoJumpText;
var HGameCheckbox InvertBroomCheck;
var localized string InvertBroomText;
var HGameLabelControl DifficultyLabel;
var HPMenuOptionCombo DifficultyCombo;
var localized string DifficultyText;
var localized string DifficultyLevel[3];
var Color LabelTextColor;
var Color GoupLabelTextColor;
var Color ButtonTextColor;
var Sound buttonClickSound;

//texture vars for importing -AdamJD
var Texture HoverImage5;
var Texture HoverImage;
var Texture HoverImage3;


function LocalizeStrings()
{
  local int I;
  local string tmpStr;

  InGame_Text = GetLocalFEString("Options_0036");
  MouseSensitivityText = GetLocalFEString("Options_0013");
  MouseHiText = GetLocalFEString("Options_0002");
  MouseLoText = GetLocalFEString("Options_0005");
  InGame_LabelList[0] = GetLocalFEString("Options_0032");
  InGame_LabelList[1] = GetLocalFEString("Options_0008");
  InGame_LabelList[2] = GetLocalFEString("Options_0031");
  InGame_LabelList[3] = GetLocalFEString("Options_0030");
  InGame_LabelList[4] = GetLocalFEString("Options_0029");
  InGame_LabelList[5] = GetLocalFEString("Options_0017");
  InGame_LabelList[6] = GetLocalFEString("InGameMenu_0033");
  InGame_LabelList[7] = GetLocalFEString("Flying_0004");
  InGame_LabelList[8] = GetLocalFEString("Flying_0005");
  InGame_LabelList[9] = GetLocalFEString("Report_Card_0009");
  InGame_LabelList[10] = GetLocalFEString("SkipCS_0002");
  InQuidditch_LabelList[0] = GetLocalFEString("Quidditch_0052");
  InWizardDuel_LabelList[0] = GetLocalFEString("Options_0039");
  KeyboardText = GetLocalFEString("Options_0018");
  InvertBroomText = GetLocalFEString("Flying_0003");
  optionsText = GetLocalFEString("Options_0040");

  for(I = 0; I < 255; I++)
  {
    tmpStr = "0000" $ string(I);
    tmpStr = "Localized_kn_" $ Right(tmpStr,4);
    LocalizedKeyName[I] = Localize("all",tmpStr,"HPMenu");
  }
  MouseSmoothText = "Mouse Smoothing";
  MiscText = GetLocalFEString("Options_0042");
  InGame_Text = GetLocalFEString("Options_0036");
  InQuidditch_Text = GetLocalFEString("Options_0037");
  InWizardDuel_Text = GetLocalFEString("Options_0038");
  OrString = " " $ GetLocalFEString("Options_0045") $ " ";
  AutoJumpText = GetLocalFEString("Options_0046");
  MouseInvertText = GetLocalFEString("Options_0035");
  MoveWhileCastingText = GetLocalFEString("Options_0043");
  AutoCenterCamText = GetLocalFEString("InGameMenu_0032");
  AutoDrinkPotionText = GetLocalFEString("InGameMenu_0034");
  ConfirmSettingsTitle = GetLocalFEString("Options_0047");
  ConfirmSettingsText = GetLocalFEString("Options_0048");
  ConfirmSettingsCancelTitle = GetLocalFEString("Options_0049");
  ConfirmSettingsCancelText = GetLocalFEString("Options_0050");
  DifficultyText = GetLocalFEString("Options_0052");
  DifficultyLevel[0] = GetLocalFEString("Options_0053");
  DifficultyLevel[1] = GetLocalFEString("Options_0054");
  DifficultyLevel[2] = GetLocalFEString("Options_0055");
}

function Created()
{
	local int ctlX;
	local int ctlY;
	local int ctlW;
	local int ctlH;
	local int labelWidth;
	local int labelX;
	local int offsetX;
	local int offsetY;
	local int I;
	local int MusicVolume;
	local int SoundVolume;
	local string sens;
	local int SliderWidth;
	local int buttonWidth;
	local int buttonHeight;
	local int textHeight;
	local int textOffsetY;

	LocalizeStrings();
	LoadExistingKeys();
	offsetX = 0;
	offsetY = 0;
	ctlX = 130 - offsetX;
	labelX = ctlX - 115;
	ctlY = 50 - offsetY;
	ctlH = 17;
	ctlW = 184;
	labelWidth = ctlX - labelX;
	SliderWidth = 133;
	buttonWidth = 180;
	buttonHeight = 24;
	textHeight = 10;
	textOffsetY = (buttonHeight - textHeight) / 2;
	MiscLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',labelX,ctlY,ctlW,1.0));
	MiscLabel.SetText(MiscText);
	MiscLabel.SetFont(1);
	MiscLabel.TextColor = GoupLabelTextColor;
	ctlY += 25;
	I = 0;
	MouseSensitivityLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',labelX,ctlY + textOffsetY,ctlW,1.0));
	MouseSensitivityLabel.SetText(MouseSensitivityText);
	MouseSensitivityLabel.SetFont(1);
	MouseSensitivityLabel.TextColor = LabelTextColor;
	SensitivitySlider = HPMenuOptionHSlider(CreateControl(Class'HPMenuOptionHSlider',ctlX,ctlY,SliderWidth,1.0));
	SensitivitySlider.bNoSlidingNotify = True;
	SensitivitySlider.SetRange(0.20, 10.0, 0.20);
	SensitivitySlider.SliderWidth = SliderWidth;
	ctlY += 28;
  
	//UTPT didn't decompile this(added from UEExplorer) -AdamJD
	MouseHiLabel = HGameLabelControl(CreateControl(class'HGameLabelControl', (ctlX + SliderWidth) - 21, ctlY, ctlW, 1.0));
	MouseHiLabel.SetText(MouseHiText);
	MouseHiLabel.SetFont(0);
	MouseHiLabel.TextColor = ButtonTextColor;
	
	// Metallicafan212:	So we know we need to move 21 to the left from the actual pos
	MouseHiLabel.ResizeRemoval = 21;
	
	MouseLoLabel = HGameLabelControl(CreateControl(class'HGameLabelControl', ctlX, ctlY, ctlW, 1.0));
	MouseLoLabel.SetText(MouseLoText);
	MouseLoLabel.SetFont(0);
	MouseLoLabel.TextColor = ButtonTextColor;
  
	// Metallicafan212:	Scale the label
	MouseHiLabel.bEnableWidthResize = true;
  
	ctlY += 24;
	MouseInvertCheck = HPMenuOptionCheckBox(CreateControl(class'HPMenuOptionCheckBox', ctlX, ctlY, 160.0, 1.0));
	MouseInvertCheck.bChecked = harry(GetPlayerOwner()).bInvertMouse;
	MouseInvertCheck.SetText(MouseInvertText);
	MouseInvertCheck.SetFont(0);
	MouseInvertCheck.TextColor = LabelTextColor;
	ctlY += 24;
	
	Log("ini:Engine.PlayerPawn bInvertMouse -> " $ string(MouseInvertCheck.bChecked));
	AutoCenterCamCheck = HPMenuOptionCheckBox(CreateControl(class'HPMenuOptionCheckBox', ctlX, ctlY, 160.0, 1.0));
	AutoCenterCamCheck.bChecked = harry(GetPlayerOwner()).bAutoCenterCamera;
	AutoCenterCamCheck.SetText(AutoCenterCamText);
	AutoCenterCamCheck.SetFont(0);
	AutoCenterCamCheck.TextColor = LabelTextColor;
	ctlY += 24;
	
	Log("get ini:HGame.Harry bAutoCenterCamera -> " $ string(AutoCenterCamCheck.bChecked));
	AutoJumpCheck = HPMenuOptionCheckBox(CreateControl(class'HPMenuOptionCheckBox', ctlX, ctlY, 160.0, 1.0));
	AutoJumpCheck.bChecked = harry(GetPlayerOwner()).bAutoJump;
	AutoJumpCheck.SetText(AutoJumpText);
	AutoJumpCheck.SetFont(0);
	AutoJumpCheck.TextColor = LabelTextColor;
	ctlY += 24;
  
	Log("AutoJumpCheck -> " $ string(AutoJumpCheck.bChecked));
	AutoDrinkPotionCheck = HPMenuOptionCheckBox(CreateControl(class'HPMenuOptionCheckBox', ctlX, ctlY, 160.0, 1.0));
	AutoDrinkPotionCheck.bChecked = harry(GetPlayerOwner()).bAutoQuaff;
	AutoDrinkPotionCheck.SetText(AutoDrinkPotionText);
	AutoDrinkPotionCheck.SetFont(0);
	AutoDrinkPotionCheck.TextColor = LabelTextColor;
	ctlY += 25;
  
	Log("get ini:HGame.Harry bAutoQuaff -> " $ string(AutoDrinkPotionCheck.bChecked));
	DifficultyLabel = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY + textOffsetY, ctlW, 1.0));
	DifficultyLabel.SetText(DifficultyText);
	DifficultyLabel.SetFont(1);
	DifficultyLabel.TextColor = LabelTextColor;
	DifficultyCombo = HPMenuOptionCombo(CreateControl(class'HPMenuOptionCombo', ctlX, ctlY, buttonWidth, buttonHeight));
	DifficultyCombo.SetEditable(false);
	DifficultyCombo.EditBoxWidth = buttonWidth;
	DifficultyCombo.TextColor = LabelTextColor;
	DifficultyCombo.SetEditTextColor(ButtonTextColor);
	DifficultyCombo.AddItem(DifficultyLevel[0], "DifficultyEasy");
	DifficultyCombo.AddItem(DifficultyLevel[1], "DifficultyMedium");
	DifficultyCombo.AddItem(DifficultyLevel[2], "DifficultyHard");
	ctlY += 35;
  
	InQuidditch_Label = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY, ctlW, 1.0));
	InQuidditch_Label.SetText(InQuidditch_Text);
	InQuidditch_Label.SetFont(1);
	InQuidditch_Label.TextColor = GoupLabelTextColor;
	ctlY += 20;
  
	InvertBroomCheck = HPMenuOptionCheckBox(CreateControl(class'HPMenuOptionCheckBox', ctlX, ctlY, 160.0, 1.0));
	InvertBroomCheck.bChecked = IsFlyingControlInverted();
	InvertBroomCheck.SetText(InvertBroomText);
	InvertBroomCheck.SetFont(0);
	InvertBroomCheck.TextColor = LabelTextColor;
	ctlY += InQuidditch_VertSpacing[0];

	for(I = 0; I < 1; I++)
	{
		InQuidditch_KeyNames[I] = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY + textOffsetY, labelWidth + 200, 1.0));
		InQuidditch_KeyNames[I].SetText(InQuidditch_LabelList[I]);
		InQuidditch_KeyNames[I].SetFont(1);
		InQuidditch_KeyNames[I].TextColor = LabelTextColor;
		InQuidditch_KeyButtons[I] = HPMenuRaisedButton(CreateControl(class'HPMenuRaisedButton', ctlX, ctlY, buttonWidth, ctlH));
		InQuidditch_KeyButtons[I].UpTexture = HoverImage5;		//texture'FEOverOption5Texture';
		InQuidditch_KeyButtons[I].DownTexture = HoverImage;		//texture'FEOverOptionTexture';
		InQuidditch_KeyButtons[I].DisabledTexture = HoverImage;	//texture'FEOverOptionTexture';
		InQuidditch_KeyButtons[I].OverTexture = HoverImage3;		//texture'FEOverOption3Texture';
		InQuidditch_KeyButtons[I].SetFont(0);
		InQuidditch_KeyButtons[I].bAcceptsFocus = false;
		InQuidditch_KeyButtons[I].bIgnoreLDoubleClick = true;
		InQuidditch_KeyButtons[I].bIgnoreMDoubleClick = true;
		InQuidditch_KeyButtons[I].bIgnoreRDoubleClick = true;
		InQuidditch_KeyButtons[I].TextColor = ButtonTextColor;
		ctlY += InQuidditch_VertSpacing[I];
	}
	
	ctlY += 13;
	InWizardDuel_Label = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY, ctlW, 1.0));
	InWizardDuel_Label.SetText(InWizardDuel_Text);
	InWizardDuel_Label.SetFont(1);
	InWizardDuel_Label.TextColor = GoupLabelTextColor;
	ctlY += 25;

	for(I = 0; I < 1; I++)
	{
		InWizardDuel_KeyNames[I] = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY + textOffsetY, labelWidth, 1.0));
		InWizardDuel_KeyNames[I].SetText(InWizardDuel_LabelList[I]);
		InWizardDuel_KeyNames[I].SetFont(1);
		InWizardDuel_KeyNames[I].TextColor = LabelTextColor;
		InWizardDuel_KeyButtons[I] = HPMenuRaisedButton(CreateControl(class'HPMenuRaisedButton', ctlX, ctlY, buttonWidth, ctlH));
		InWizardDuel_KeyButtons[I].UpTexture = HoverImage5;		//texture'FEOverOption5Texture';
		InWizardDuel_KeyButtons[I].DownTexture = HoverImage;		//texture'FEOverOptionTexture';
		InWizardDuel_KeyButtons[I].DisabledTexture = HoverImage;	//texture'FEOverOptionTexture';
		InWizardDuel_KeyButtons[I].OverTexture = HoverImage3;		//texture'FEOverOption3Texture';
		InWizardDuel_KeyButtons[I].SetFont(0);
		InWizardDuel_KeyButtons[I].bAcceptsFocus = false;
		InWizardDuel_KeyButtons[I].bIgnoreLDoubleClick = true;
		InWizardDuel_KeyButtons[I].bIgnoreMDoubleClick = true;
		InWizardDuel_KeyButtons[I].bIgnoreRDoubleClick = true;
		InWizardDuel_KeyButtons[I].TextColor = ButtonTextColor;
		ctlY += InWizardDuel_VertSpacing[I];
	}
  
	ctlY = 40 - offsetY;
	ctlX = 430 - offsetX;
	labelX = 330 - offsetX;
	InGame_Label = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY, ctlW, 1.0));
	InGame_Label.SetText(InGame_Text);
	InGame_Label.SetFont(1);
	InGame_Label.TextColor = GoupLabelTextColor;
	ctlY += 25;

	for(I = 0; I < 11; I++)
	{
		InGame_KeyNames[I] = HGameLabelControl(CreateControl(class'HGameLabelControl', labelX, ctlY + textOffsetY, labelWidth, 1.0));
		InGame_KeyNames[I].SetText(InGame_LabelList[I]);
		InGame_KeyNames[I].SetFont(1);
		InGame_KeyNames[I].TextColor = LabelTextColor;
		InGame_KeyButtons[I] = HPMenuRaisedButton(CreateControl(class'HPMenuRaisedButton', ctlX, ctlY, buttonWidth, ctlH));
		InGame_KeyButtons[I].UpTexture = HoverImage5; 		//texture'FEOverOption5Texture';
		InGame_KeyButtons[I].DownTexture = HoverImage;		//texture'FEOverOptionTexture';
		InGame_KeyButtons[I].DisabledTexture = HoverImage;	//texture'FEOverOptionTexture';
		InGame_KeyButtons[I].OverTexture = HoverImage3;		//texture'FEOverOption3Texture';
		InGame_KeyButtons[I].SetFont(0);
		InGame_KeyButtons[I].bAcceptsFocus = false;
		InGame_KeyButtons[I].bIgnoreLDoubleClick = true;
		InGame_KeyButtons[I].bIgnoreMDoubleClick = true;
		InGame_KeyButtons[I].bIgnoreRDoubleClick = true;
		InGame_KeyButtons[I].TextColor = ButtonTextColor;
		ctlY += InGame_VertSpacing[I];
	}
	
	LoadAvailableSettings();
	CreateBackPageButton();
}

function ShowWindow()
{
  Super.ShowWindow();
  if ( HPConsole(Root.Console).bDebugMode )
  {
    DifficultyLabel.ShowWindow();
    DifficultyCombo.ShowWindow();
  } else {
    DifficultyLabel.HideWindow();
    DifficultyCombo.HideWindow();
  }
}

function HideWindow()
{
  Super.HideWindow();
  DifficultyCombo.CloseUpWithNoSound();
  GetPlayerOwner().SaveConfig();
}

function PlayClick()
{
  if ( buttonClickSound != None )
  {
    GetPlayerOwner().PlaySound(buttonClickSound,SLOT_Interact);
  }
}

function BeforePaint (Canvas C, float X, float Y)
{
  local int I;
  local int J;

  for(I = 0; I < 11; I++)
  {
    if ( BoundKey1[I] == 0 )
    {
      InGame_KeyButtons[I].SetText("");
    } else //{
      if ( BoundKey2[I] == 0 )
      {
        InGame_KeyButtons[I].SetText(LocalizedKeyName[BoundKey1[I]]);
      } else {
        InGame_KeyButtons[I].SetText(LocalizedKeyName[BoundKey1[I]] $ OrString $ LocalizedKeyName[BoundKey2[I]]);
      }
    //}
  }

  for(I = 0; I < 2; I++)
  {
    J = 11 + I;
    if ( BoundKey1[J] == 0 )
    {
      InQuidditch_KeyButtons[I].SetText("");
    } else //{
      if ( BoundKey2[J] == 0 )
      {
        InQuidditch_KeyButtons[I].SetText(LocalizedKeyName[BoundKey1[J]]);
      } else {
        InQuidditch_KeyButtons[I].SetText(LocalizedKeyName[BoundKey1[J]] $ OrString $ LocalizedKeyName[BoundKey2[J]]);
      }
    //}
  }
  for(I = 0; I < 1; I++)
  {
    J = 12 + I;
    if ( BoundKey1[J] == 0 )
    {
      InWizardDuel_KeyButtons[I].SetText("");
    } else //{
      if ( BoundKey2[J] == 0 )
      {
        InWizardDuel_KeyButtons[I].SetText(LocalizedKeyName[BoundKey1[J]]);
      } else {
        InWizardDuel_KeyButtons[I].SetText(LocalizedKeyName[BoundKey1[J]] $ OrString $ LocalizedKeyName[BoundKey2[J]]);
      }
    //}
  }
}

function LoadAvailableSettings()
{
  local string ParseString;
  local int p;
  local int I;
  local string TempStr;

  bInitialized = False;
  DifficultyCombo.SetSelectedIndex(GetPlayerOwner().Difficulty);
  SensitivitySlider.SetValue(GetPlayerOwner().MouseSensitivity);
  bInitialized = True;
}

function SwitchFlyingControlAliases()
{
  local string tmp;

  tmp = AliasNames2[0];
  AliasNames2[0] = AliasNames2[1];
  AliasNames2[1] = tmp;
  Log("Flying control aliases switched");
}

function bool IsFlyingControlInverted()
{
  return harry(GetPlayerOwner()).bInvertBroomPitch;
}

function LoadExistingKeys()
{
  local int I;
  local int J;
  local int Pos;
  local string KeyName;
  local string Alias;

  // J = 0;
  // if ( J < 14 )
  for(J = 0; J < ArrayCount(AliasNames1); J++)
  {
    AliasNames1[J] = Caps(AliasNames1[J]);
    AliasNames2[J] = Caps(AliasNames2[J]);
    AliasNames3[J] = Caps(AliasNames3[J]);
    // J++;
    // goto JL0007;
  }
  // I = 0;
  // if ( I < 13 )
  for(I = 0; I < 13; I++)
  {
// JL006F:
    BoundKey1[I] = 0;
    BoundKey2[I] = 0;
    // I++;
    // goto JL006F;
  }
  // I = 0;
  // if ( I < 255 )
  for(I = 0; I < 255; I++)
  {
    KeyName = GetPlayerOwner().ConsoleCommand("KEYNAME " $I);
    RealKeyName[I] = KeyName;
    if ( KeyName != "" )
    {
      Alias = GetPlayerOwner().ConsoleCommand("KEYBINDING " $KeyName);
      if ( Alias != "" )
      {
        Alias = Caps(Alias);

		for(J = 0; J < ArrayCount(AliasNames1); J++)
        {
          if ( AliasNames1[J] != "" && InStr(Alias,Caps(AliasNames1[J])) != -1 )
          {
            if ( BoundKey1[J] == 0 )
            {
              BoundKey1[J] = I;
            } else //{
              if ( BoundKey2[J] == 0 )
              {
                BoundKey2[J] = I;
              }
            //}
            Log(" Found in AliasNames1[" $ string(J) $ "] (" $ AliasNames1[J] $ ") set to BoundKey[" $ string(J) $ "] ");
		  }
        }
      }
    }
  }
}

function WindowDone (UWindowWindow W)
{
  if ( W == ConfirmSettings )
  {
    if ( (ConfirmSettings.Result == "") || (ConfirmSettings.Result == GetLocalFEString("Main_Menu_0009")) )
    {
      if ( ConfirmSettings.bClosedFromTick )
      {
        HPConsole(Root.Console).ResTimeOutSettings = OldSettings;
      } else {
        GetPlayerOwner().ConsoleCommand("SetRes " $ OldSettings);
      }
      LoadAvailableSettings();
      doHPMessageBox(ConfirmSettingsCancelText,"Okay");
    }
    ConfirmSettings = None;
  }
}

function SensitivityChanged()
{
  GetPlayerOwner().MouseSensitivity = SensitivitySlider.Value;
  Log("Sensitivity changed to " $ string(GetPlayerOwner().MouseSensitivity));
}

function MouseSmoothChanged()
{
  GetPlayerOwner().bMaxMouseSmoothing = MouseSmoothCheck.bChecked;
  Log("bMaxMouseSmoothing changed to " $ string(MouseSmoothCheck.bChecked));
}

function MouseInvertChanged()
{
  GetPlayerOwner().InvertMouse(MouseInvertCheck.bChecked);
  GetPlayerOwner().ConsoleCommand("set ini:Engine.PlayerPawn bInvertMouse " $ AutoCenterCamCheck.bChecked);
  Log("MouseInvert changed to " $ string(MouseInvertCheck.bChecked));
}

function AutoCenterCamChanged()
{
  harry(GetPlayerOwner()).bAutoCenterCamera = AutoCenterCamCheck.bChecked;
  GetPlayerOwner().ConsoleCommand("set ini:HGame.Harry bAutoCenterCamera " $ AutoCenterCamCheck.bChecked);
  Log("AutoCenterCam changed to " $ string(AutoCenterCamCheck.bChecked));
}

function AutoDrinkPotionChanged()
{
  harry(GetPlayerOwner()).bAutoQuaff = AutoDrinkPotionCheck.bChecked;
  GetPlayerOwner().ConsoleCommand("set ini:HGame.Harry bAutoQuaff " $ AutoDrinkPotionCheck.bChecked);
  Log("bAutoQuaff changed to " $ string(AutoDrinkPotionCheck.bChecked));
}

function MoveWhileCastingChanged()
{
  harry(GetPlayerOwner()).bMoveWhileCasting = MoveWhileCastingCheck.bChecked;
  GetPlayerOwner().ConsoleCommand("set ini:HGame.Harry bMoveWhileCasting " $ MoveWhileCastingCheck.bChecked);
  Log("MoveWhileCasting changed to " $ string(MoveWhileCastingCheck.bChecked));
}

function AutoJumpChanged()
{
  GetPlayerOwner().AutoJump(AutoJumpCheck.bChecked);
  Log("AutoJumpChanged changed to " $ string(AutoJumpCheck.bChecked));
}

function InvertBroomChanged()
{
  harry(GetPlayerOwner()).InvertBroomPitch(InvertBroomCheck.bChecked);
}

function DifficultyChanged()
{
  local string Str;

  switch (DifficultyCombo.GetSelectedIndex())
  {
    case 0:
    GetPlayerOwner().Difficulty = DifficultyEasy;
    Str = "DifficultyEasy";
    break;
    case 1:
    GetPlayerOwner().Difficulty = DifficultyMedium;
    Str = "DifficultyMedium";
    break;
    case 2:
    GetPlayerOwner().Difficulty = DifficultyHard;
    Str = "DifficultyHard";
    break;
    default:
    GetPlayerOwner().Difficulty = DifficultyMedium;
    Str = "DifficultyMedium";
    break;
  }
  GetPlayerOwner().ConsoleCommand("set ini:HGame.Harry Difficulty " $ Str);
  Log("Difficulty changed to " $ string(GetPlayerOwner().Difficulty));
}

/*
function RemoveExistingKey (int KeyNo, string KeyName)
{
  local int I;

  // I = RemoveExistingBoundKeyMinIndex;
  // if ( (I < 13) && (I < RemoveExistingBoundKeyMaxIndex) )
  for(I = RemoveExistingBoundKeyMinIndex; I < ArrayCount(Boundkey1) && I < RemoveExistingBoundKeyMaxIndex; I++)
  {
    if ( I != Selection )
    {
      if ( BoundKey2[I] == KeyNo )
      {
        BoundKey2[I] = 0;
        Log(" Removing Key -" $ RealKeyName[KeyNo] $ "- with AliasNames1[I] -" $ AliasNames1[I] $ " 2 -" $ AliasNames2[I] $ " 3 -" $ AliasNames3[I]);
        GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey(RealKeyName[KeyNo],AliasNames1[I]));
        if ( AliasNames2[I] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey(RealKeyName[KeyNo],AliasNames2[I]));
        }
        if ( AliasNames3[I] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey(RealKeyName[KeyNo],AliasNames3[I]));
        }
      }
      if ( BoundKey1[I] == KeyNo )
      {
        BoundKey1[I] = BoundKey2[I];
        BoundKey2[I] = 0;
        Log(" Removing Key -" $ RealKeyName[KeyNo] $ "- with AliasNames1[I] -" $ AliasNames1[I] $ " 2 -" $ AliasNames2[I] $ " 3 -" $ AliasNames3[I]);
        GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey(RealKeyName[KeyNo],AliasNames1[I]));
        if ( AliasNames2[I] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey(RealKeyName[KeyNo],AliasNames2[I]));
        }
        if ( AliasNames3[I] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey(RealKeyName[KeyNo],AliasNames3[I]));
        }
      }
    }
    // I++;
    // goto JL000B;
  }
}

function string AddTokenToString (string InString, string InToken)
{
  local int J;

  InString = Caps(InString);
  InToken = Caps(InToken);
  if ( InToken == "" )
  {
    return InString;
  }
  if ( InStr(InString,InToken) != -1 )
  {
    return InString;
  }
  J = Len(InString);
  if ( J > 0 )
  {
    J--;
    // if ( (J > 0) && ((Mid(InString,J,1) == "|") || (Mid(InString,J,1) == " ")) )
	while ( J > 0 && (Mid(InString,J,1) == "|" || Mid(InString,J,1) == " ") )
    {
      if ( Mid(InString,J,1) == "=" )
      {
        Log(" InString[" $ string(J) $ "] == '=' so we will return -" $ InString @ InToken);
        return InString @ InToken;
      }
      J--;
      // goto JL0067;
    }
    Log(" InString[" $ string(J) $ "] != '=' so we will return -" $ InString @ "|" @ InToken);
    return InString @ "|" @ InToken;
  } else {
    return InToken;
  }
}

function string RemoveTokenFromString (string InString, string InToken)
{
  local string L;
  local string R;
  local int I;
  local int J;

  if ( (InString == "") || (InToken == "") )
  {
    return InString;
  }
  InString = Caps(InString);
  InToken = Caps(InToken);
  I = InStr(InString,InToken);
  if ( I != -1 )
  {
    Log("Removing Token:" $ InToken $ " from string:" $ InString $ "!");
    L = Left(InString,I);
    R = Right(InString,Len(InString) - (I + Len(InToken)));
    Log("InStr returned:" $ string(I) $ " Len(leftPart):" $ string(Len(L)) $ " Len(InToken):" $ string(Len(InToken)));
    J = Len(L);
    J--;
    // if ( (J > 0) && ((Mid(L,J,1) == "|") || (Mid(L,J,1) == " ")) )
	while ( J > 0 && (Mid(L,J,1) == "|" || Mid(L,J,1) == " ") )
    {
      Log("j=" $ string(J) $ "! Mid(l, j, 1)=" $ Mid(L,J,1) $ "!l=" $ L $ "!");
      L = Left(L,J-- );
      // goto JL0130;
    }
    Log("After cleanup left:" $ L);
    Log("right:" $ R);
    Log("final:" $ L $ R);
    L = L $ R;
    // if ( (Len(L) > 0) && ((Mid(L,0,1) == "|") || (Mid(L,0,1) == " ")) )
	while ( Len(L) > 0 && (Mid(L,0,1) == "|" || Mid(L,0,1) == " ") )
    {
      Log("j=" $ string(J) $ "! Mid(l, 0, 1)=" $ Mid(L,0,1) $ "!l=" $ L $ "!");
      L = Right(L,Len(L) - 1);
      // goto JL021C;
    }
    Log("After cleanup final:" $ L);
    return L;
  }
  return InString;
}

function string RemoveActionFromKey (string KeyName, string ActionName)
{
  local string keybinding;

  keybinding = GetPlayerOwner().ConsoleCommand("KEYBINDING " $KeyName);
  Log("Calling RemoveActionFromKey(" $ keybinding $ "," $ ActionName $ ");");
  return RemoveTokenFromString(keybinding,ActionName);
}

function string AddActionToKey (string KeyName, string ActionName)
{
  local string keybinding;

  keybinding = GetPlayerOwner().ConsoleCommand("KEYBINDING " $KeyName);
  Log("Calling AddActionToKey(" $ keybinding $ "," $ ActionName $ ");");
  return AddTokenToString(keybinding,ActionName);
}

function SetKey (int KeyNo, string KeyName)
{
  local string RemoveKeyName;

  Log("options Setkey" @ KeyName $ " KeyNo" @ string(KeyNo));
  if ( BoundKey1[Selection] != 0 )
  {
    if ( KeyNo == BoundKey1[Selection] )
    {
      if ( BoundKey2[Selection] != 0 )
      {
        RemoveKeyName = RealKeyName[BoundKey2[Selection]];
        GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames1[Selection]));
        if ( AliasNames2[Selection] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames2[Selection]));
        }
        if ( AliasNames3[Selection] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames3[Selection]));
        }
        BoundKey2[Selection] = 0;
      }
    } else //{
      if ( KeyNo == BoundKey2[Selection] )
      {
        RemoveKeyName = RealKeyName[BoundKey1[Selection]];
        GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames1[Selection]));
        if ( AliasNames2[Selection] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames2[Selection]));
        }
        if ( AliasNames3[Selection] != "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames3[Selection]));
        }
        BoundKey1[Selection] = BoundKey2[Selection];
        BoundKey2[Selection] = 0;
      } else {
        if ( BoundKey2[Selection] != 0 )
        {
          RemoveKeyName = RealKeyName[BoundKey2[Selection]];
          GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames1[Selection]));
          if ( AliasNames2[Selection] != "" )
          {
            GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames2[Selection]));
          }
          if ( AliasNames3[Selection] != "" )
          {
            GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey(RemoveKeyName,AliasNames3[Selection]));
          }
          BoundKey2[Selection] = 0;
        }
        BoundKey2[Selection] = BoundKey1[Selection];
        BoundKey1[Selection] = KeyNo;
        if ( AliasNames2[Selection] == "" )
        {
          GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames1[Selection]));
        } else {
          if ( AliasNames3[Selection] == "" )
          {
            GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames1[Selection]));
            GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames2[Selection]));
          } else {
            GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames1[Selection]));
            GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames2[Selection]));
            GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames3[Selection]));
          }
        }
      }
    //}
  } else {
    BoundKey1[Selection] = KeyNo;
    if ( AliasNames2[Selection] == "" )
    {
      GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames1[Selection]));
    } else {
      if ( AliasNames3[Selection] == "" )
      {
        GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames1[Selection]));
        GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames2[Selection]));
      } else {
        GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames1[Selection]));
        GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames2[Selection]));
        GetPlayerOwner().ConsoleCommand("SET Input" @KeyName@AddActionToKey(KeyName,AliasNames3[Selection]));
      }
    }
  }
}
*/

//all these functions are rewritten by me because the originals are broken -AdamJD
// start ------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RemoveExistingKey(int KeyNo, string KeyName)
{
	local int I;

	for(I=RemoveExistingBoundKeyMinIndex; I<ArrayCount(Boundkey1) && I<RemoveExistingBoundKeyMaxIndex; I++)
	{
		if (I != Selection)
		{
			if ( BoundKey2[I] == KeyNo )
			{			
				BoundKey2[I] = 0;

				log(" Removing Key -" $RealKeyName[KeyNo] $"- with AliasNames1[I] -" $AliasNames1[I] $" 2 -" $AliasNames2[I] $" 3 -" $AliasNames3[I] );
				
				GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey( RealKeyName[KeyNo], AliasNames1[I] ) );
				
				if( AliasNames2[I] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey( RealKeyName[KeyNo], AliasNames2[I] ) );
				}
				if( AliasNames3[I] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey( RealKeyName[KeyNo], AliasNames3[I] ) );
				}
			}
			
			if ( BoundKey1[I] == KeyNo )
			{
				BoundKey1[I] = BoundKey2[I];
				BoundKey2[I] = 0;

				log(" Removing Key -" $RealKeyName[KeyNo] $"- with AliasNames1[I] -" $AliasNames1[I] $" 2 -" $AliasNames2[I] $" 3 -" $AliasNames3[I] );

				GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey( RealKeyName[KeyNo], AliasNames1[I] ) );
				
				if( AliasNames2[I] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey( RealKeyName[KeyNo], AliasNames2[I] ) );
				}
				if( AliasNames3[I] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RealKeyName[KeyNo]@RemoveActionFromKey( RealKeyName[KeyNo], AliasNames3[I] ) );
				}
			}
		}
	}
}

function string AddTokenToString(string InString, string InToken)
{
	local int j;

	InString = Caps( InString );
	InToken  = Caps( InToken );
	
	if( InToken == "" )
	{
		return InString;
	}
	
	if( InStr(InString, InToken ) != -1 )
	{
		return InString;
	}

	j = Len( InString );

	if ( j > 0 )
	{
		j--;
		
		while ( j > 0 && (Mid(InString, j, 1) == "|" || Mid(InString, j, 1) == " ") )
		{
			if ( Mid(InString, j, 1) == "=" )
			{
				log(" InString["$j$"] == '=' so we will return -" $InString@InToken );
				return (InString@InToken);
			}
			j--;
		}
		log(" InString["$j$"] != '=' so we will return -" $(InString@"|"@InToken) );
		
		return (InString@"|"@InToken);
	}
	else
	{
		return (InToken);
	}
}

function string RemoveTokenFromString(string InString, string InToken)
{
	local string l, r;
	local int i, j;

	if ( InString == "" || InToken == "" )
	{
		return InString;
	}
	
	InString = Caps( InString );
	InToken  = Caps( InToken );
	
	i = InStr(InString, InToken );
	if ( i != -1 )
	{
		log( "Removing Token:" $InToken $" from string:" $InString $"!" );
		
		l = Left( InString, i );
		
		r = Right( InString, Len(InString) - (i+Len(InToken)) );
		log( "InStr returned:" $i $" Len(leftPart):" $Len(l) $" Len(InToken):" $Len(InToken) );
		
		j = Len( l );
		j--;
		
		while ( j > 0 && (Mid(l, j, 1) == "|" || Mid(l, j, 1) == " ") )
		{
			log( "j=" $j $"! Mid(l, j, 1)=" $Mid(l, j, 1) $"!l=" $l $"!" );

			l = Left( l, j--);
		}
		
		log("After cleanup left:" $l );
		log("right:" $r );
		log("final:" $l$r );
		
		l = l$r;
		
		while ( Len( l ) > 0 && (Mid(l, 0, 1) == "|" || Mid(l, 0, 1) == " ") )
		{
			log( "j=" $j $"! Mid(l, 0, 1)=" $Mid(l, 0, 1) $"!l=" $l $"!" );
			
			l = Right( l, Len( l )-1);
		}

		log("After cleanup final:" $l );

		return (l);
	}
	return InString;
}

function string RemoveActionFromKey(string KeyName, string ActionName)
{
	local string keybinding;
	
	keybinding = GetPlayerOwner().ConsoleCommand( "KEYBINDING "$KeyName );
	log("Calling RemoveActionFromKey(" $keybinding $"," $ActionName$");");
	return RemoveTokenFromString( keybinding, ActionName );
}

function string AddActionToKey(string KeyName, string ActionName)
{
	local string keybinding;
	
	keybinding = GetPlayerOwner().ConsoleCommand( "KEYBINDING "$KeyName );
	log("Calling AddActionToKey(" $keybinding $"," $ActionName$");");
	return AddTokenToString( keybinding, ActionName );
}

function SetKey(int KeyNo, string KeyName)
{
	local string RemoveKeyName;

	log( "options Setkey"@KeyName $" KeyNo"@KeyNo );

	if ( BoundKey1[Selection] != 0 )
	{
		if( KeyNo == BoundKey1[Selection] )
		{
			if( BoundKey2[Selection] != 0 )
			{
				RemoveKeyName = RealKeyName[BoundKey2[Selection]];
				GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames1[Selection] ) );
				
				if( AliasNames2[Selection] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames2[Selection] ) );
				}
				if( AliasNames3[Selection] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames3[Selection] ) );
				}

				BoundKey2[Selection] = 0;
			}
		}
		else if ( KeyNo == BoundKey2[Selection] )
		{			
			RemoveKeyName = RealKeyName[BoundKey1[Selection]];
			GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames1[Selection] ) );
			
			if( AliasNames2[Selection] != "" )
			{
				GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames2[Selection] ) );
			}
			if( AliasNames3[Selection] != "" )
			{
				GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames3[Selection] ) );
			}
			
			BoundKey1[Selection] = BoundKey2[Selection];
			BoundKey2[Selection] = 0;
		}
		else
		{
			if( BoundKey2[Selection] != 0 )
			{
				RemoveKeyName = RealKeyName[BoundKey2[Selection]];
				GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames1[Selection] ) );
				
				if( AliasNames2[Selection] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames2[Selection] ) );
				}
				if( AliasNames3[Selection] != "" )
				{
					GetPlayerOwner().ConsoleCommand("SET Input "@RemoveKeyName@RemoveActionFromKey( RemoveKeyName, AliasNames3[Selection] ) );
				}

				BoundKey2[Selection] = 0;
			}
			
			BoundKey2[Selection] = BoundKey1[Selection];
			BoundKey1[Selection] = KeyNo;
			
			if( AliasNames2[Selection] == "" )
			{
				GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames1[Selection]) );
			}
			else
			{
				if( AliasNames3[Selection] == "" )
				{	
					GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames1[Selection]) );
					GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames2[Selection]) );	
				}
				else
				{
					GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames1[Selection]) );
					GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames2[Selection]) );	
					GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames3[Selection]) );	
				}
			}
		}
	}
	
	else
	{
		BoundKey1[Selection] = KeyNo;

		if( AliasNames2[Selection] == "" )
		{
			GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames1[Selection]) );
		}
		else
		{
			if( AliasNames3[Selection] == "" )
			{
				GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames1[Selection]) );
				GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames2[Selection]) );	
			}
			else
			{
				GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames1[Selection]) );
				GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames2[Selection]) );	
				GetPlayerOwner().ConsoleCommand("SET Input"@KeyName@AddActionToKey( KeyName, AliasNames3[Selection]) );	
			}
		}
	}
}
// end ------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ProcessKey (int KeyNo)
{
  local string KeyName;

  KeyName = RealKeyName[KeyNo];
  Log("InputPage selection:" $ string(Selection) $ " has AliasNames1:'" $ AliasNames1[Selection] $ "' attempt to set as " $ string(KeyNo) $ ":" $ KeyName);
  PlayClick();
  if ( (KeyName == "") || (KeyName == "Escape") || (KeyNo >= 112) && (KeyNo <= 121) || (KeyNo >= 48) && (KeyNo <= 57) || (KeyNo == 91) || (KeyNo == 92) || (KeyNo == 93) || (KeyNo == 236) || (KeyNo == 237) )
  {
    return;
  }
  Log("InputPage KeyNo = " $ string(KeyNo) $ " keyName = " $ KeyName $ ", got through filters!");
  RemoveExistingKey(KeyNo,KeyName);
  SetKey(KeyNo,KeyName);
  GetPlayerOwner().SaveConfig();
}

function bool KeyEvent (byte KeyNo, byte Action, float Delta)
{
  Log("KeyEvent called! KeyNo = '" $ string(KeyNo) $ "' Action = " $ string(Action));
  if ( Action == 1 && bPolling && KeyNo >= 5 )
  {
    Log("ProcessKey called! KeyNo = '" $ string(KeyNo) $ "Action = " $ string(Action));
    ProcessKey(KeyNo);
    bPolling = False;
    SelectedButton.bDisabled = False;
    return True;
  }
  return Super.KeyEvent(KeyNo,Action,Delta);
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  Super.Notify(C,E);
  switch (E)
  {
    case DE_Change:
    switch (C)
    {
      case DifficultyCombo:
      DifficultyChanged();
      break;
      case SensitivitySlider:
      SensitivityChanged();
      break;
      case MouseSmoothCheck:
      MouseSmoothChanged();
      break;
      case InvertBroomCheck:
      InvertBroomChanged();
      break;
      case AutoJumpCheck:
      AutoJumpChanged();
      break;
      case MouseInvertCheck:
      MouseInvertChanged();
      break;
      case AutoCenterCamCheck:
      AutoCenterCamChanged();
      break;
      case AutoDrinkPotionCheck:
      AutoDrinkPotionChanged();
      break;
      case MoveWhileCastingCheck:
      MoveWhileCastingChanged();
      break;
      default:
    }
    case DE_Click:
    if ( bPolling )
    {
      bPolling = False;
      SelectedButton.bDisabled = False;
      if ( C == SelectedButton )
      {
        ProcessKey(1);
        return;
      }
    }
    if ( HGameButton(C) != None )
    {
      PlayClick();

	  for(I = 0; I < 11; I++)
      {
        if ( InGame_KeyButtons[I] == C )
        {
          RemoveExistingBoundKeyMinIndex = 0;
          RemoveExistingBoundKeyMaxIndex = 11;
          SetKeyType = KT_Game;
          SelectedButton = HGameButton(C);
          Selection = I;
          Log("InputPage InGame_KeyButtons Selection" $ string(Selection) $ " is:" $ AliasNames1[Selection] $ "' clicked ...");
          bPolling = True;
          Log("Polling set to true");
          SelectedButton.bDisabled = True;
          return;
        }
      }

	  for(I = 0; I < 2; I++)
      {
        if ( InQuidditch_KeyButtons[I] == C )
        {
          RemoveExistingBoundKeyMinIndex = 11;
          RemoveExistingBoundKeyMaxIndex = 12;
          SetKeyType = KT_Quidditch;
          SelectedButton = HGameButton(C);
          Selection = 11 + I;
          Log("InputPage InQuidditch_KeyButtons Selection" $ string(Selection) $ " is:" $ AliasNames1[Selection] $ "' clicked ...");
          bPolling = True;
          Log("Polling set to true");
          SelectedButton.bDisabled = True;
          return;
        }
      }

	  for(I = 0; I < 1; I++)
      {
        if ( InWizardDuel_KeyButtons[I] == C )
        {
          RemoveExistingBoundKeyMinIndex = 12;
          RemoveExistingBoundKeyMaxIndex = 13;
          SetKeyType = KT_WizardDuel;
          SelectedButton = HGameButton(C);
          Selection = 12 + I;
          Log("InputPage InWizardDuel_KeyButtons Selection" $ string(Selection) $ " is:" $ AliasNames1[Selection] $ "' clicked ...");
          bPolling = True;
          Log("Polling set to true");
          SelectedButton.bDisabled = True;
          return;
        }
      }
    }
    switch (C)
    {
      case BackPageButton:
      FEBook(book).DoEscapeFromPage();
      return;
    }
    break;
    case DE_RClick:
    if ( bPolling )
    {
      bPolling = False;
      SelectedButton.bDisabled = False;
      if ( C == SelectedButton )
      {
        ProcessKey(2);
        return;
      }
    }
    break;
    case DE_MClick:
    if ( bPolling )
    {
      bPolling = False;
      SelectedButton.bDisabled = False;
      if ( C == SelectedButton )
      {
        ProcessKey(4);
        return;
      }
    }
    break;
    default:
  }
}

defaultproperties
{
    optionsText="OPTIONS"

    InGame_Text="In Game"

    InQuidditch_Text="In Quidditch"

    InWizardDuel_Text="In Wizard Duel"

    SensitivityText="Sensitivity"

    MouseSmoothText="Mouse Smoothing"

    KeyboardText="Keyboard"

    LocalizedKeyName(1)="LeftMouse"

    LocalizedKeyName(2)="RightMouse"

    LocalizedKeyName(3)="Cancel"

    LocalizedKeyName(4)="MiddleMouse"

    LocalizedKeyName(5)="Unknown05"

    LocalizedKeyName(6)="Unknown06"

    LocalizedKeyName(7)="Unknown07"

    LocalizedKeyName(8)="Backspace"

    LocalizedKeyName(9)="Tab"

    LocalizedKeyName(10)="Unknown0A"

    LocalizedKeyName(11)="Unknown0B"

    LocalizedKeyName(12)="Unknown0C"

    LocalizedKeyName(13)="Enter"

    LocalizedKeyName(14)="Unknown0E"

    LocalizedKeyName(15)="Unknown0F"

    LocalizedKeyName(16)="Shift"

    LocalizedKeyName(17)="Ctrl"

    LocalizedKeyName(18)="Alt"

    LocalizedKeyName(19)="Pause"

    LocalizedKeyName(20)="CapsLock"

    LocalizedKeyName(21)="Unknown15"

    LocalizedKeyName(22)="Unknown16"

    LocalizedKeyName(23)="Unknown17"

    LocalizedKeyName(24)="Unknown18"

    LocalizedKeyName(25)="Unknown19"

    LocalizedKeyName(26)="Unknown1A"

    LocalizedKeyName(27)="Escape"

    LocalizedKeyName(28)="Unknown1C"

    LocalizedKeyName(29)="Unknown1D"

    LocalizedKeyName(30)="Unknown1E"

    LocalizedKeyName(31)="Unknown1F"

    LocalizedKeyName(32)="Space"

    LocalizedKeyName(33)="PageUp"

    LocalizedKeyName(34)="PageDown"

    LocalizedKeyName(35)="End"

    LocalizedKeyName(36)="Home"

    LocalizedKeyName(37)="Left"

    LocalizedKeyName(38)="Up"

    LocalizedKeyName(39)="Right"

    LocalizedKeyName(40)="Down"

    LocalizedKeyName(41)="Select"

    LocalizedKeyName(42)="Print"

    LocalizedKeyName(43)="Execute"

    LocalizedKeyName(44)="PrintScrn"

    LocalizedKeyName(45)="Insert"

    LocalizedKeyName(46)="Delete"

    LocalizedKeyName(47)="Help"

    LocalizedKeyName(48)="0"

    LocalizedKeyName(49)="1"

    LocalizedKeyName(50)="2"

    LocalizedKeyName(51)="3"

    LocalizedKeyName(52)="4"

    LocalizedKeyName(53)="5"

    LocalizedKeyName(54)="6"

    LocalizedKeyName(55)="7"

    LocalizedKeyName(56)="8"

    LocalizedKeyName(57)="9"

    LocalizedKeyName(58)="Unknown3A"

    LocalizedKeyName(59)="Unknown3B"

    LocalizedKeyName(60)="Unknown3C"

    LocalizedKeyName(61)="Unknown3D"

    LocalizedKeyName(62)="Unknown3E"

    LocalizedKeyName(63)="Unknown3F"

    LocalizedKeyName(64)="Unknown40"

    LocalizedKeyName(65)="A"

    LocalizedKeyName(66)="B"

    LocalizedKeyName(67)="C"

    LocalizedKeyName(68)="D"

    LocalizedKeyName(69)="E"

    LocalizedKeyName(70)="F"

    LocalizedKeyName(71)="G"

    LocalizedKeyName(72)="H"

    LocalizedKeyName(73)="I"

    LocalizedKeyName(74)="J"

    LocalizedKeyName(75)="K"

    LocalizedKeyName(76)="L"

    LocalizedKeyName(77)="M"

    LocalizedKeyName(78)="N"

    LocalizedKeyName(79)="O"

    LocalizedKeyName(80)="P"

    LocalizedKeyName(81)="Q"

    LocalizedKeyName(82)="R"

    LocalizedKeyName(83)="S"

    LocalizedKeyName(84)="T"

    LocalizedKeyName(85)="U"

    LocalizedKeyName(86)="V"

    LocalizedKeyName(87)="W"

    LocalizedKeyName(88)="X"

    LocalizedKeyName(89)="Y"

    LocalizedKeyName(90)="Z"

    LocalizedKeyName(91)="Unknown5B"

    LocalizedKeyName(92)="Unknown5C"

    LocalizedKeyName(93)="Unknown5D"

    LocalizedKeyName(94)="Unknown5E"

    LocalizedKeyName(95)="Unknown5F"

    LocalizedKeyName(96)="NumPad0"

    LocalizedKeyName(97)="NumPad1"

    LocalizedKeyName(98)="NumPad2"

    LocalizedKeyName(99)="NumPad3"

    LocalizedKeyName(100)="NumPad4"

    LocalizedKeyName(101)="NumPad5"

    LocalizedKeyName(102)="NumPad6"

    LocalizedKeyName(103)="NumPad7"

    LocalizedKeyName(104)="NumPad8"

    LocalizedKeyName(105)="NumPad9"

    LocalizedKeyName(106)="GreyStar"

    LocalizedKeyName(107)="GreyPlus"

    LocalizedKeyName(108)="Separator"

    LocalizedKeyName(109)="GreyMinus"

    LocalizedKeyName(110)="NumPadPeriod"

    LocalizedKeyName(111)="GreySlash"

    LocalizedKeyName(112)="F1"

    LocalizedKeyName(113)="F2"

    LocalizedKeyName(114)="F3"

    LocalizedKeyName(115)="F4"

    LocalizedKeyName(116)="F5"

    LocalizedKeyName(117)="F6"

    LocalizedKeyName(118)="F7"

    LocalizedKeyName(119)="F8"

    LocalizedKeyName(120)="F9"

    LocalizedKeyName(121)="F10"

    LocalizedKeyName(122)="F11"

    LocalizedKeyName(123)="F12"

    LocalizedKeyName(124)="F13"

    LocalizedKeyName(125)="F14"

    LocalizedKeyName(126)="F15"

    LocalizedKeyName(127)="F16"

    LocalizedKeyName(128)="F17"

    LocalizedKeyName(129)="F18"

    LocalizedKeyName(130)="F19"

    LocalizedKeyName(131)="F20"

    LocalizedKeyName(132)="F21"

    LocalizedKeyName(133)="F22"

    LocalizedKeyName(134)="F23"

    LocalizedKeyName(135)="F24"

    LocalizedKeyName(136)="Unknown88"

    LocalizedKeyName(137)="Unknown89"

    LocalizedKeyName(138)="Unknown8A"

    LocalizedKeyName(139)="Unknown8B"

    LocalizedKeyName(140)="Unknown8C"

    LocalizedKeyName(141)="Unknown8D"

    LocalizedKeyName(142)="Unknown8E"

    LocalizedKeyName(143)="Unknown8F"

    LocalizedKeyName(144)="NumLock"

    LocalizedKeyName(145)="ScrollLock"

    LocalizedKeyName(146)="Unknown92"

    LocalizedKeyName(147)="Unknown93"

    LocalizedKeyName(148)="Unknown94"

    LocalizedKeyName(149)="Unknown95"

    LocalizedKeyName(150)="Unknown96"

    LocalizedKeyName(151)="Unknown97"

    LocalizedKeyName(152)="Unknown98"

    LocalizedKeyName(153)="Unknown99"

    LocalizedKeyName(154)="Unknown9A"

    LocalizedKeyName(155)="Unknown9B"

    LocalizedKeyName(156)="Unknown9C"

    LocalizedKeyName(157)="Unknown9D"

    LocalizedKeyName(158)="Unknown9E"

    LocalizedKeyName(159)="Unknown9F"

    LocalizedKeyName(160)="LShift"

    LocalizedKeyName(161)="RShift"

    LocalizedKeyName(162)="LControl"

    LocalizedKeyName(163)="RControl"

    LocalizedKeyName(164)="UnknownA4"

    LocalizedKeyName(165)="UnknownA5"

    LocalizedKeyName(166)="UnknownA6"

    LocalizedKeyName(167)="UnknownA7"

    LocalizedKeyName(168)="UnknownA8"

    LocalizedKeyName(169)="UnknownA9"

    LocalizedKeyName(170)="UnknownAA"

    LocalizedKeyName(171)="UnknownAB"

    LocalizedKeyName(172)="UnknownAC"

    LocalizedKeyName(173)="UnknownAD"

    LocalizedKeyName(174)="UnknownAE"

    LocalizedKeyName(175)="UnknownAF"

    LocalizedKeyName(176)="UnknownB0"

    LocalizedKeyName(177)="UnknownB1"

    LocalizedKeyName(178)="UnknownB2"

    LocalizedKeyName(179)="UnknownB3"

    LocalizedKeyName(180)="UnknownB4"

    LocalizedKeyName(181)="UnknownB5"

    LocalizedKeyName(182)="UnknownB6"

    LocalizedKeyName(183)="UnknownB7"

    LocalizedKeyName(184)="UnknownB8"

    LocalizedKeyName(185)="UnknownB9"

    LocalizedKeyName(186)="Semicolon"

    LocalizedKeyName(187)="Equals"

    LocalizedKeyName(188)="Comma"

    LocalizedKeyName(189)="Minus"

    LocalizedKeyName(190)="Period"

    LocalizedKeyName(191)="Slash"

    LocalizedKeyName(192)="Tilde"

    LocalizedKeyName(193)="UnknownC1"

    LocalizedKeyName(194)="UnknownC2"

    LocalizedKeyName(195)="UnknownC3"

    LocalizedKeyName(196)="UnknownC4"

    LocalizedKeyName(197)="UnknownC5"

    LocalizedKeyName(198)="UnknownC6"

    LocalizedKeyName(199)="UnknownC7"

    LocalizedKeyName(200)="Joy1"

    LocalizedKeyName(201)="Joy2"

    LocalizedKeyName(202)="Joy3"

    LocalizedKeyName(203)="Joy4"

    LocalizedKeyName(204)="Joy5"

    LocalizedKeyName(205)="Joy6"

    LocalizedKeyName(206)="Joy7"

    LocalizedKeyName(207)="Joy8"

    LocalizedKeyName(208)="Joy9"

    LocalizedKeyName(209)="Joy10"

    LocalizedKeyName(210)="Joy11"

    LocalizedKeyName(211)="Joy12"

    LocalizedKeyName(212)="Joy13"

    LocalizedKeyName(213)="Joy14"

    LocalizedKeyName(214)="Joy15"

    LocalizedKeyName(215)="Joy16"

    LocalizedKeyName(216)="UnknownD8"

    LocalizedKeyName(217)="UnknownD9"

    LocalizedKeyName(218)="UnknownDA"

    LocalizedKeyName(219)="LeftBracket"

    LocalizedKeyName(220)="Backslash"

    LocalizedKeyName(221)="RightBracket"

    LocalizedKeyName(222)="SingleQuote"

    LocalizedKeyName(223)="UnknownDF"

    LocalizedKeyName(224)="JoyX"

    LocalizedKeyName(225)="JoyY"

    LocalizedKeyName(226)="JoyZ"

    LocalizedKeyName(227)="JoyR"

    LocalizedKeyName(228)="MouseX"

    LocalizedKeyName(229)="MouseY"

    LocalizedKeyName(230)="MouseZ"

    LocalizedKeyName(231)="MouseW"

    LocalizedKeyName(232)="JoyU"

    LocalizedKeyName(233)="JoyV"

    LocalizedKeyName(234)="UnknownEA"

    LocalizedKeyName(235)="UnknownEB"

    LocalizedKeyName(236)="MouseWheelUp"

    LocalizedKeyName(237)="MouseWheelDown"

    LocalizedKeyName(238)="Unknown10E"

    LocalizedKeyName(239)="Unknown10F"

    LocalizedKeyName(240)="JoyPovUp"

    LocalizedKeyName(241)="JoyPovDown"

    LocalizedKeyName(242)="JoyPovLeft"

    LocalizedKeyName(243)="JoyPovRight"

    LocalizedKeyName(244)="UnknownF4"

    LocalizedKeyName(245)="UnknownF5"

    LocalizedKeyName(246)="Attn"

    LocalizedKeyName(247)="CrSel"

    LocalizedKeyName(248)="ExSel"

    LocalizedKeyName(249)="ErEof"

    LocalizedKeyName(250)="Play"

    LocalizedKeyName(251)="Zoom"

    LocalizedKeyName(252)="NoName"

    LocalizedKeyName(253)="PA1"

    LocalizedKeyName(254)="OEMClear"

    OrString="or"

    AliasNames1(0)="MoveForward"

    AliasNames1(1)="MoveBackward"

    AliasNames1(2)="RotLeft"

    AliasNames1(3)="RotRight"

    AliasNames1(4)="Jump"

    AliasNames1(5)="AltFire"

    AliasNames1(6)="button bDrinkWiggenwell"

    AliasNames1(7)="StrafeLeft"

    AliasNames1(8)="StrafeRight"

    AliasNames1(9)="button bOpenMap"

    AliasNames1(10)="button bSkipCutScene"

    AliasNames1(11)="button bBroomAction"

    AliasNames1(12)="button bDuelCycleSpell"

    AliasNames2(0)="button bBroomPitchUp"

    AliasNames2(1)="button bBroomPitchDown"

    AliasNames2(2)="button bBroomYawLeft"

    AliasNames2(3)="button bBroomYawRight"

    InGame_LabelList(0)="Forward"

    InGame_LabelList(1)="Backward"

    InGame_LabelList(2)="Turn Left"

    InGame_LabelList(3)="Turn Right"

    InGame_LabelList(4)="Jump"

    InGame_LabelList(5)="Use Wand"

    InGame_LabelList(6)="Drink Potion"

    InGame_LabelList(7)="Strafe Left"

    InGame_LabelList(8)="Strafe Right"

    InGame_LabelList(9)="Open Map"

    InGame_LabelList(10)="Skip CutScene"

    InGame_VertSpacing(0)=32

    InGame_VertSpacing(1)=32

    InGame_VertSpacing(2)=32

    InGame_VertSpacing(3)=32

    InGame_VertSpacing(4)=32

    InGame_VertSpacing(5)=32

    InGame_VertSpacing(6)=32

    InGame_VertSpacing(7)=32

    InGame_VertSpacing(8)=32

    InGame_VertSpacing(9)=32

    InGame_VertSpacing(10)=32

    InQuidditch_LabelList="Quidditch Action"

    InQuidditch_VertSpacing(0)=32

    InQuidditch_VertSpacing(1)=32

    InWizardDuel_LabelList="Cycle Spell"

    InWizardDuel_VertSpacing=32

    AutoJumpText="Auto Jump"

    InvertBroomText="Invert Broom"

    DifficultyText=" "

    DifficultyLevel(0)="Easy"

    DifficultyLevel(1)="Medium"

    DifficultyLevel(2)="Hard"

    LabelTextColor=(R=40,G=180,B=40,A=0)

    GoupLabelTextColor=(R=255,G=255,B=255,A=0)

    ButtonTextColor=(R=255,G=255,B=255,A=0)
	
	//get the imported textures -AdamJD
	//
	HoverImage5=FEOverOption5Texture
	
	HoverImage=FEOverOptionTexture
	
	HoverImage3=FEOverOption3Texture
}
