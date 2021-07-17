// Metallicafan212:	A combo box that scales correctly
class ScalingComboBox based on UWindowComboControl;

function Resized()
{
	Super.Resized();
	
	// Metallicafan212:	Now set everything up
	EditBox.SetSize(WinWidth - 12, WinHeight);
	
	Button.SetSize(WinWidth - 12, 12);
	
	if(LeftButton != None)
		LeftButton.SetSize(WinWidth - 12, 12);
		
	if(RightButton != None)
		RightButton.SetSize(WinWidth - 12, 12);
		
	EditBoxWidth = WinWidth;
	EditAreaDrawX = 0.0;
	EditAreaDrawY = 0.0;
}