//================================================================================
// FESoundVideoPage.
//================================================================================

class FESoundVideoPage extends baseFEPage;

var string GameRenderDriver;
var bool bInitialized;
var string OldSettings;
var HGameButton OptionsLabel;
var localized string optionsText;
var HGameLabelControl VideoLabel;
var localized string videoText;
var HGameLabelControl ResolutionLabel;
var HPMenuOptionCombo ResolutionCombo;
var localized string ResolutionText;
//var HGameLabelControl ColorDepthLabel;
//var HPMenuOptionCombo ColorDepthCombo;
var localized string ColorDepthText;
var localized string BitsText;
var HGameLabelControl BrightnessLabel;
var HGameLabelControl BrightnessHiText;
var HGameLabelControl BrightnessLoText;
var HGameHSlider BrightnessSlider;
var localized string BrightnessText;
var localized string DetailLevel[5];
var HGameLabelControl TextureDetailLabel;
var HPMenuOptionCombo TextureDetailCombo;
var localized string TextureDetailText;
var int OldTextureDetail;
var HGameLabelControl ObjectDetailLabel;
var HGameLabelControl ObjectDetailHiText;
var HGameLabelControl ObjectDetailLoText;
var HGameHSlider ObjectDetailSlider;
var localized string ObjectDetailText;
var HGameLabelControl AudioLabel;
var localized string audioText;
var HGameHSlider MusicVolumeSlider;
var HGameLabelControl MusicVolumeLabel;
var localized string MusicVolumeText;
var HGameLabelControl MusicVolumeHiText;
var HGameLabelControl MusicVolumeLoText;
var HGameHSlider SoundVolumeSlider;
var HGameLabelControl SoundVolumeLabel;
var localized string SoundVolumeText;
var HGameLabelControl SoundVolumeHiText;
var HGameLabelControl SoundVolumeLoText;
var localized string VolumeHiText;
var localized string VolumeLoText;
var HPMessageBox ConfirmSettings;
var localized string ConfirmSettingsTitle;
var localized string ConfirmSettingsText;
var localized string ConfirmSettingsCancelTitle;
var localized string ConfirmSettingsCancelText;
var HGameButton SelectedButton;
var bool bPolling;
var int Selection;
var Color ButtonTextColor;
var Color LabelTextColor;
var Color GoupLabelTextColor;
var int vertSpacing[8];
var Sound buttonClickSound;
var float fLeftMargin;
var float fLeftMarginIndent;
var float fRightMargin;
var float fRightMarginIndent;

function LocalizeStrings()
{
	local int I;
	local string tmpStr;

	VolumeHiText = GetLocalFEString("Options_0002");
	VolumeLoText = GetLocalFEString("Options_0005");
	ResolutionText = GetLocalFEString("Options_0033");
	ColorDepthText = GetLocalFEString("Options_0026");
	BrightnessText = GetLocalFEString("Options_0006");
	TextureDetailText = GetLocalFEString("Options_0000");
	ObjectDetailText = GetLocalFEString("Options_0007");
	audioText = GetLocalFEString("Options_0009");
	MusicVolumeText = GetLocalFEString("Options_0010");
	SoundVolumeText = GetLocalFEString("Options_0011");
	DetailLevel[0] = GetLocalFEString("Options_0001");
	DetailLevel[1] = GetLocalFEString("Options_0002");
	DetailLevel[2] = GetLocalFEString("Options_0003");
	DetailLevel[3] = GetLocalFEString("Options_0005");
	DetailLevel[4] = GetLocalFEString("Options_0016");
	optionsText = GetLocalFEString("Options_0024");
	videoText = GetLocalFEString("Options_0044");
	//BitsText = GetLocalFEString("Options_0051");
	ConfirmSettingsTitle = GetLocalFEString("Options_0047");
	ConfirmSettingsText = GetLocalFEString("Options_0048");
	ConfirmSettingsCancelTitle = GetLocalFEString("Options_0049");
	ConfirmSettingsCancelText = GetLocalFEString("Options_0050");
}

function Created()
{  
	local int ctlX;
	local int ctlY;
	local int ctlW;
	local int ctlH;
	local int labelWidth;
	local int labelHeight;
	local int labelX;
	local int offsetX;
	local int offsetY;
	local int I;
	local int MusicVolume;
	local int SoundVolume;
	local string sens;
	local float fHalfX;
	local float fFourthX;
	local float fEighthX;
	local float fSixteenthX;
	local int buttonWidth;
	local int buttonHeight;
	local int SliderWidth;
	local int sliderHeight;
	local float textHeight;
	local float textOffsetY;

	LocalizeStrings();
  
	offsetX = 0;
	offsetY = 0;
	ctlX = 180 - offsetX;
	labelX = ctlX - 80;
	ctlY = 90 - offsetY;
	ctlH = 17;
	ctlW = 144;
	fHalfX = 640.0 / 2;
	fFourthX = 640.0 / 4;
	fEighthX = 640.0 / 8;
	fSixteenthX = 640.0 / 16;
	fLeftMargin = fEighthX;
	fLeftMarginIndent = fLeftMargin + fEighthX;
	fRightMargin = fHalfX + fEighthX;
	fRightMarginIndent = fRightMargin + fSixteenthX;
	fLeftMargin += offsetX;
	fLeftMarginIndent += offsetX;
	fRightMargin += offsetX;
  
	fRightMarginIndent += offsetX;
	buttonWidth = 180;
	buttonHeight = 24;
	SliderWidth = 133;
	sliderHeight = 24;
	labelWidth = 50 + ctlX - labelX;
	labelHeight = 24;
	textHeight = 10.0;
	textOffsetY = buttonHeight / 2 - textHeight / 2;
	VideoLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMargin,ctlY,labelWidth,1.0));
	VideoLabel.SetText(videoText);
	VideoLabel.SetFont(1);
	VideoLabel.TextColor = GoupLabelTextColor;
	ctlY += 40;
	I = 0;

	ResolutionLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMargin,ctlY + textOffsetY,labelWidth,labelHeight));
	ResolutionLabel.SetText(ResolutionText);
	ResolutionLabel.SetFont(1);
	ResolutionLabel.TextColor = LabelTextColor;
	ResolutionCombo = HPMenuOptionCombo(CreateControl(Class'HPMenuOptionCombo',fLeftMarginIndent,ctlY,buttonWidth,buttonHeight));
	ResolutionCombo.SetFont(1);
	ResolutionCombo.SetEditable(False);
	ResolutionCombo.EditBoxWidth = buttonWidth;
	ResolutionCombo.TextColor = LabelTextColor;
	ResolutionCombo.SetEditTextColor(ButtonTextColor);
	ctlY += vertSpacing[I++ ];
  
	/*
	ColorDepthLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMargin,ctlY + textOffsetY,labelWidth,labelHeight));
	ColorDepthLabel.SetText(ColorDepthText);
	ColorDepthLabel.SetFont(1);
	ColorDepthLabel.TextColor = LabelTextColor;
	ColorDepthCombo = HPMenuOptionCombo(CreateControl(Class'HPMenuOptionCombo',fLeftMarginIndent,ctlY,buttonWidth,buttonHeight));
	ColorDepthCombo.SetFont(1);
	ColorDepthCombo.SetEditable(False);
	ColorDepthCombo.EditBoxWidth = buttonWidth;
	ColorDepthCombo.TextColor = LabelTextColor;
	ColorDepthCombo.SetEditTextColor(ButtonTextColor);
	*/
	ctlY += vertSpacing[I++ ];
  
	TextureDetailLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMargin,ctlY + textOffsetY,labelWidth,labelHeight));
	TextureDetailLabel.SetText(TextureDetailText);
	TextureDetailLabel.SetFont(1);
	TextureDetailLabel.TextColor = LabelTextColor;
	TextureDetailCombo = HPMenuOptionCombo(CreateControl(Class'HPMenuOptionCombo',fLeftMarginIndent,ctlY,buttonWidth,buttonHeight));
	TextureDetailCombo.SetFont(1);
	TextureDetailCombo.SetEditable(False);
	TextureDetailCombo.EditBoxWidth = buttonWidth;
	TextureDetailCombo.TextColor = LabelTextColor;
	TextureDetailCombo.SetEditTextColor(ButtonTextColor);
	TextureDetailCombo.AddItem(DetailLevel[1],"High");
	TextureDetailCombo.AddItem(DetailLevel[2],"Medium");
	TextureDetailCombo.AddItem(DetailLevel[3],"Low");
	ctlY += 10 + vertSpacing[I++ ];
  
	ObjectDetailLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMargin,ctlY + textOffsetY,labelWidth,labelHeight));
	ObjectDetailLabel.SetText(ObjectDetailText);
	ObjectDetailLabel.SetFont(1);
	ObjectDetailLabel.TextColor = LabelTextColor;
	ObjectDetailSlider = HPMenuOptionHSlider(CreateControl(Class'HPMenuOptionHSlider',fLeftMarginIndent,ctlY,SliderWidth,sliderHeight));
	ObjectDetailSlider.bNoSlidingNotify = True;
	ObjectDetailSlider.SetRange(0.0,4.0,1);
	ObjectDetailSlider.SliderWidth = SliderWidth;
	ctlY += 32;
  
	ObjectDetailLoText = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMarginIndent,ctlY,labelWidth,labelHeight));
	ObjectDetailLoText.SetText(VolumeLoText);
	ObjectDetailLoText.SetFont(0);
	ObjectDetailLoText.TextColor = GoupLabelTextColor;
	ObjectDetailHiText = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMarginIndent + SliderWidth - 20,ctlY,labelWidth,labelHeight));
	ObjectDetailHiText.SetText(VolumeHiText);
	ObjectDetailHiText.SetFont(0);
	ObjectDetailHiText.TextColor = GoupLabelTextColor;
	ObjectDetailHiText.bEnableWidthResize = true;
	ObjectDetailHiText.ResizeRemoval = 20;
	ctlY += vertSpacing[I++ ];
  
	BrightnessLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMargin,ctlY + textOffsetY,labelWidth,labelHeight));
	BrightnessLabel.SetText(BrightnessText);
	BrightnessLabel.SetFont(1);
	BrightnessLabel.TextColor = LabelTextColor;
	BrightnessSlider = HPMenuOptionHSlider(CreateControl(Class'HPMenuOptionHSlider',fLeftMarginIndent,ctlY,SliderWidth,sliderHeight));
	BrightnessSlider.bNoSlidingNotify = True;
	BrightnessSlider.SetRange(2.0,10.0,1);
	BrightnessSlider.SliderWidth = SliderWidth;
	ctlY += 32;
  
	BrightnessLoText = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMarginIndent,ctlY,labelWidth,labelHeight));
	BrightnessLoText.SetText(VolumeLoText);
	BrightnessLoText.SetFont(0);
	BrightnessLoText.TextColor = GoupLabelTextColor;
	BrightnessHiText = HGameLabelControl(CreateControl(Class'HGameLabelControl',fLeftMarginIndent + SliderWidth - 20,ctlY,labelWidth,labelHeight));
	BrightnessHiText.SetText(VolumeHiText);
	BrightnessHiText.SetFont(0);
	BrightnessHiText.TextColor = GoupLabelTextColor;
	BrightnessHiText.bEnableWidthResize = true;
	BrightnessHiText.ResizeRemoval = 20;
  
	ctlY += vertSpacing[I++ ];
	ctlY = 90 - offsetY;
	ctlX = 380 - offsetX;
	labelX = 470 - offsetX;
  
	AudioLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fRightMargin,ctlY,labelWidth,labelHeight));
	AudioLabel.SetText(audioText);
	AudioLabel.SetFont(1);
	AudioLabel.TextColor = GoupLabelTextColor;
	ctlY += 30;
  
	//UTPT didn't decompile this(added from UEExplorer) -AdamJD
	MusicVolumeLabel = HGameLabelControl(CreateControl(Class'HGameLabelControl',fRightMargin,ctlY + textOffsetY,labelWidth,labelHeight));
	MusicVolumeLabel.SetText( MusicVolumeText $" - " $int(MusicVolumeSlider.Value) );
	MusicVolumeLabel.SetFont(1);
	MusicVolumeLabel.TextColor = LabelTextColor;
	ctlY += 30;
  
	MusicVolume = int(float(GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.AudioDevice MusicVolume")) * 100);
	MusicVolumeSlider = HPMenuOptionHSlider(CreateControl(class'HPMenuOptionHSlider', fRightMargin, ctlY, SliderWidth, sliderHeight));
	MusicVolumeSlider.SetRange(0.0, 100.0, 1);
	MusicVolumeSlider.SliderWidth = SliderWidth;
	MusicVolumeSlider.SetValue(MusicVolume);
	MusicVolumeSlider.SetText("");
	ctlY += 32;
  
	MusicVolumeLoText = HGameLabelControl(CreateControl(class'HGameLabelControl', fRightMargin, ctlY, labelWidth, labelHeight));
	MusicVolumeLoText.SetText(VolumeLoText);
	MusicVolumeLoText.SetFont(0);
	MusicVolumeLoText.TextColor = GoupLabelTextColor;
	MusicVolumeHiText = HGameLabelControl(CreateControl(class'HGameLabelControl', (fRightMargin + SliderWidth) - 20, ctlY, labelWidth, labelHeight));
	MusicVolumeHiText.SetText(VolumeHiText);
	MusicVolumeHiText.SetFont(0);
	MusicVolumeHiText.TextColor = GoupLabelTextColor;
	MusicVolumeHiText.bEnableWidthResize = true;
	MusicVolumeHiText.ResizeRemoval = 20;
	ctlY += 30;
  
	Log("Options::SoundVideoPage: MusicVolume " $ string(MusicVolume));
	SoundVolumeLabel = HGameLabelControl(CreateControl(class'HGameLabelControl', fRightMargin, ctlY + textOffsetY, labelWidth, labelHeight));
	SoundVolumeLabel.SetText( SoundVolumeText $ " - " $int(SoundVolumeSlider.Value) );
	SoundVolumeLabel.SetFont(1);
	SoundVolumeLabel.TextColor = LabelTextColor;
	ctlY += 30;
  
	SoundVolume = int(float(GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.AudioDevice SoundVolume")) * 100); 
	SoundVolumeSlider = HPMenuOptionHSlider(CreateControl(class'HPMenuOptionHSlider', fRightMargin, ctlY, SliderWidth, sliderHeight));
	SoundVolumeSlider.SetRange(0.0, 100.0, 1);
	SoundVolumeSlider.SliderWidth = SliderWidth;
	SoundVolumeSlider.SetValue(SoundVolume);
	SoundVolumeSlider.SetText("");
	ctlY += 32;
  
	SoundVolumeLoText = HGameLabelControl(CreateControl(class'HGameLabelControl', fRightMargin, ctlY, labelWidth, labelHeight));
	SoundVolumeLoText.SetText(VolumeLoText);
	SoundVolumeLoText.SetFont(0);
	SoundVolumeLoText.TextColor = GoupLabelTextColor;
	SoundVolumeHiText = HGameLabelControl(CreateControl(class'HGameLabelControl', (fRightMargin + SliderWidth) - 20, ctlY, labelWidth, labelHeight));
	SoundVolumeHiText.SetText(VolumeHiText);
	SoundVolumeHiText.SetFont(0);
	SoundVolumeHiText.TextColor = GoupLabelTextColor;
	SoundVolumeHiText.bEnableWidthResize = true;
	SoundVolumeHiText.ResizeRemoval = 20;
	ctlY += 38;
	
	Log("Options::SoundVideoPage: MusicVolume " $ string(SoundVolume));
  
	LoadAvailableSettings();
	CreateBackPageButton();
}

function PlayClick()
{
	local PlayerPawn Player;
	if ( buttonClickSound != None )
	{
		Player = GetPlayerOwner();
		
		if(Player.ViewTarget != none)
		{
			Player.ViewTarget.PlaySound(buttonClickSound, SLOT_Interact);
		}
		else
		{
			Player.PlaySound(buttonClickSound, SLOT_Interact);
		}
		
		//GetPlayerOwner().PlaySound(buttonClickSound, SLOT_Interact);
	}
}

function bool IsSupportedResolution (string TempStr)
{
	/*
	if ( GetPlayerOwner().IsSoftwareRendering() )
	{
		if ( TempStr ~= "512x384" )
		{
			return True;
		}
	} 
	else 
	{
		if ( HPConsole(Root.Console).bDebugMode )
		{
			if ( (TempStr ~= "640x480") || (TempStr ~= "800x600") || (TempStr ~= "1024x768") || (TempStr ~= "1280x1024") )
			{
				return True;
			}
		} 
		else 
		{
			if ( (TempStr ~= "640x480") || (TempStr ~= "800x600") || (TempStr ~= "1024x768") )
			{
				return True;
			}
		}
	}
	return False;
	*/
	
	// Metallicafan212:	We need to code in a new engine feature to enum the display settings in fullscreen, and then do that + add on some new resolutions in windowed mode
	return true;
}

function LoadAvailableSettings()
{
	local float Brightness;
	local string ParseString;
	local string CurrentDepth;
	local int p;
	local int I;
	local string TempStr;
	local string strIsFullscreen;
	local string strCurrentRes;
	
	local string ResX;
	local string ResY;
	
	local bool   bIsFull;
	
	bIsFull = bool(GetPlayerOwner().ConsoleCommand("IsFullscreen"));

	GameRenderDriver = GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine GameRenderDevice");
	bInitialized = False;
	ResolutionCombo.Clear();
	GetPlayerOwner().ClientMessage("GameRenderDriver:" $ GameRenderDriver);
	//if ( GetPlayerOwner().IsSoftwareRendering() )
	//{
	//	ResolutionCombo.AddItem("512x384");
	//	ResolutionCombo.SetValue("512x384");
	//} 
	//else 
	//{
	ParseString = GetPlayerOwner().ConsoleCommand("GetRes");
		
	log(ParseString);
		
	p = InStr(ParseString," ");
		
	while ( p != -1 )
	{
		TempStr = Left(ParseString, p);
				
		if ( IsSupportedResolution(TempStr) )
		{
			Log("Adding to our ResolutionCombo:" $ TempStr);
			ResolutionCombo.AddItem(TempStr);
		}
		ParseString = Mid(ParseString,p + 1);
		p = InStr(ParseString," ");
	}
	
	//strIsFullscreen = GetPlayerOwner().ConsoleCommand("IsFullscreen");
		
	// Metallicafan212:	Wow, you could've casted there dumbo
	if ( bIsFull )//bool(strIsFullscreen) )
	{
		Log("I think we are in fullscreen mode");
		strCurrentRes = GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager FullscreenViewportX");
		strCurrentRes = strCurrentRes $ "x";
		strCurrentRes = strCurrentRes $ GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager FullscreenViewportY");
	} 
	else 
	{
		Log("I think we are in window mode");
			
		// Metallicafan212:	4/3 1080p
		//ResolutionCombo.AddItem("1440x1080");
		//ResolutionCombo.Sort();
			
		strCurrentRes = GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager WindowedViewportX");
		strCurrentRes = strCurrentRes $ "x";
		strCurrentRes = strCurrentRes $ GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager WindowedViewportY");
	}
    
	GetPlayerOwner().ClientMessage("strIsFullscreen:" $ strIsFullscreen $ "strCurrentRes:" $ strCurrentRes);
	Log("Setting our ResolutionCombo to:" $ strCurrentRes);
	ResolutionCombo.SetValue(strCurrentRes);
	//}
  
	// Metallicafan212:	Not needed
	/*
	ColorDepthCombo.Clear();
	if ( GetPlayerOwner().IsSoftwareRendering() )
	{
		ParseString = GetPlayerOwner().ConsoleCommand("GetColorDepths");
		p = InStr(ParseString," ");
		if ( p != -1 )
		{
			ColorDepthCombo.AddItem(Left(ParseString,p) @ BitsText,Left(ParseString,p));
			ColorDepthCombo.SetValue(Left(ParseString,p) @ BitsText);
		}
	} 
	else 
	{
		ParseString = GetPlayerOwner().ConsoleCommand("GetColorDepths");
		p = InStr(ParseString," ");
		while ( p != -1 )
		{
			ColorDepthCombo.AddItem(Left(ParseString,p) @ BitsText,Left(ParseString,p));
			ParseString = Mid(ParseString,p + 1);
			p = InStr(ParseString," ");
		}
   
		ColorDepthCombo.AddItem(ParseString @ BitsText,ParseString);
		CurrentDepth = GetPlayerOwner().ConsoleCommand("GetCurrentColorDepth");
		ColorDepthCombo.SetValue(CurrentDepth @ BitsText,CurrentDepth);
	}
	*/
	
	Brightness = int(float(GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager Brightness")) * 10);
	BrightnessSlider.SetValue(Brightness);
	OldTextureDetail = Max(0,TextureDetailCombo.FindItemIndex2(GetPlayerOwner().ConsoleCommand("get ini:Engine.Engine.ViewportManager TextureDetail")));
	TextureDetailCombo.SetSelectedIndex(OldTextureDetail);
	
	switch (GetPlayerOwner().ObjectDetail)
	{
		case ObjectDetailVeryLow:
			ObjectDetailSlider.SetValue(0.0);
			break;
		case ObjectDetailLow:
			ObjectDetailSlider.SetValue(1.0);
			break;
		case ObjectDetailMedium:
			ObjectDetailSlider.SetValue(2.0);
			break;
		case ObjectDetailHigh:
			ObjectDetailSlider.SetValue(3.0);
			break;
		case ObjectDetailVeryHigh:
			ObjectDetailSlider.SetValue(4.0);
			break;
	}
	bInitialized = True;
}

function SettingsChanged()
{
	local string NewSettings;

	if ( bInitialized )
	{
		OldSettings = GetPlayerOwner().ConsoleCommand("GetCurrentRes") $ "x32"; //$ GetPlayerOwner().ConsoleCommand("GetCurrentColorDepth");
		
		// Metallicafan212:	Force 32 but color
		NewSettings = ResolutionCombo.GetValue() $ "x32"; //$ ColorDepthCombo.GetValue2();
		if ( NewSettings != OldSettings )
		{
			Log("Screen Settings Changed");
			GetPlayerOwner().ConsoleCommand("SetRes " $ NewSettings);
			LoadAvailableSettings();
			GetPlayerOwner().SaveConfig();
			ConfirmSettings = doHPMessageBox(ConfirmSettingsText,GetLocalFEString("Main_Menu_0001"),GetLocalFEString("Main_Menu_0009"),14.0);
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
      GetPlayerOwner().SaveConfig();
      doHPMessageBox(ConfirmSettingsCancelText,GetLocalFEString("Shared_Menu_0008"));
    }
    ConfirmSettings = None;
  }
}

function HideWindow()
{
	Super.HideWindow();
	ResolutionCombo.CloseUpWithNoSound();
	//ColorDepthCombo.CloseUpWithNoSound();
	TextureDetailCombo.CloseUpWithNoSound();
	GetPlayerOwner().SaveConfig();
}

function BrightnessChanged()
{
	if ( bInitialized )
	{
		GetPlayerOwner().ConsoleCommand("set ini:Engine.Engine.ViewportManager Brightness " $ string(BrightnessSlider.Value / 10));
		GetPlayerOwner().ConsoleCommand("FLUSH");
	}
}

function TextureDetailChanged()
{
	if ( bInitialized )
	{
		GetPlayerOwner().ConsoleCommand("set ini:Engine.Engine.ViewportManager TextureDetail " $ TextureDetailCombo.GetValue2());
		OldTextureDetail = TextureDetailCombo.GetSelectedIndex();
	}
}

function ObjectDetailChanged()
{
	switch (ObjectDetailSlider.GetValue())
	{
		case 0.0:
			GetPlayerOwner().ObjectDetail = ObjectDetailVeryLow;
			break;
		case 1.0:
			GetPlayerOwner().ObjectDetail = ObjectDetailLow;
			break;
		case 2.0:
			GetPlayerOwner().ObjectDetail = ObjectDetailMedium;
			break;
		case 3.0:
			GetPlayerOwner().ObjectDetail = ObjectDetailHigh;
			break;
		case 4.0:
			GetPlayerOwner().ObjectDetail = ObjectDetailVeryHigh;
		break;
	}
	
	switch (GetPlayerOwner().ObjectDetail)
	{
		case ObjectDetailVeryHigh:
			GetPlayerOwner().ConsoleCommand("MLOD 0.1");
			break;
		case ObjectDetailHigh:
			GetPlayerOwner().ConsoleCommand("MLOD 0.2");
			break;
		case ObjectDetailMedium:
			GetPlayerOwner().ConsoleCommand("MLOD 0.5");
			break;
		case ObjectDetailLow:
			GetPlayerOwner().ConsoleCommand("MLOD 0.8");
			break;
		case ObjectDetailVeryLow:
			GetPlayerOwner().ConsoleCommand("MLOD 1.0");
			break;
	}
	
	GetPlayerOwner().ConsoleCommand("set ini:HGame.Harry ObjectDetail " $ string(GetPlayerOwner().ObjectDetail));
}

function MusicVolumeChanged()
{
	//UTPT didn't decompile this (added from UEExplorer) -AdamJD
	MusicVolumeLabel.SetText( MusicVolumeText $" - " $int(MusicVolumeSlider.Value) );
	GetPlayerOwner().ConsoleCommand("SETVOLUMES MUSIC=" $(MusicVolumeSlider.Value / 100));
	GetPlayerOwner().ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume "$(MusicVolumeSlider.Value / 100));
}

function SoundVolumeChanged()
{
	//UTPT didn't decompile this (added from UEExplorer) -AdamJD
	SoundVolumeLabel.SetText( SoundVolumeText $" - " $int(SoundVolumeSlider.Value) );
	GetPlayerOwner().ConsoleCommand("SETVOLUMES SOUND=" $(SoundVolumeSlider.Value / 100));
	GetPlayerOwner().ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume "$(SoundVolumeSlider.Value / 100));
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
				case ResolutionCombo:
				//case ColorDepthCombo:
					SettingsChanged();
					break;
				case BrightnessSlider:
					BrightnessChanged();
					break;
				case TextureDetailCombo:
					TextureDetailChanged();
					break;
				case ObjectDetailSlider:
					ObjectDetailChanged();
					break;
				case MusicVolumeSlider:
					MusicVolumeChanged();
					break;
				case SoundVolumeSlider:
					SoundVolumeChanged();
					break;
			}
			break;
		case DE_Click:
			switch (C)
			{
				case BackPageButton:
				FEBook(book).DoEscapeFromPage();
			}
			break;
	}
}

defaultproperties
{
    GameRenderDriver="SoftDrv.SoftwareRenderDevice"

    optionsText="OPTIONS"

    videoText="Video"

    ResolutionText="Resolution"

    ColorDepthText="Color Depth"

    BitsText="bit"

    DetailLevel(0)="Very High"

    DetailLevel(1)="High"

    DetailLevel(2)="Medium"

    DetailLevel(3)="Low"

    DetailLevel(4)="Very Low"

    TextureDetailText="Texture Detail"

    ObjectDetailText="Object Detail"

    audioText="Audio"

    MusicVolumeText="Music Volume"

    SoundVolumeText="Sound Volume"

    ConfirmSettingsTitle="Confirm Video Settings Change"

    ConfirmSettingsText="Are you sure you wish to keep these new video settings?"

    ConfirmSettingsCancelTitle="Video Settings Change"

    ConfirmSettingsCancelText="Your previous video settings have been restored."

    ButtonTextColor=(R=200,G=200,B=200,A=0)

    LabelTextColor=(R=40,G=180,B=40,A=0)

    GoupLabelTextColor=(R=255,G=255,B=255,A=0)

    vertSpacing(0)=40

    vertSpacing(1)=40

    vertSpacing(2)=40

    vertSpacing(3)=40

    vertSpacing(4)=40

    vertSpacing(5)=40

    vertSpacing(6)=40

    vertSpacing(7)=40

}
