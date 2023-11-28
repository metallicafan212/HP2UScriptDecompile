// Omega: Scaling version of the asset:
Class M212WrappedTextArea based on UWindowWrappedTextArea;

var float WX, WY, WW, WH, XOffset, YOffset;

function ResolutionChanged(float W, float H)
{
	Super.ResolutionChanged(W, H);
	
	// Metallicafan212:	Say we were resized
	Resized();
}

function Resized()
{
	//local float HScale;
	
	Super.Resized();
	
	//HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);
	
	// Metallicafan212:	Scale our wanted values
	//WinTop		= (WY * HScale) + YOffset;
	//WinWidth	= WW * HScale;
	//WinHeight	= WH * HScale;
	// Omega: Align our button based on its alignment type
	WinLeft		= AlignButton(WX + XOffset);
}

defaultproperties
{

}