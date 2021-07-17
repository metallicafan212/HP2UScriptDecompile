// Metallicafan212:	This class only exists to cleanup my scaling code
class M212HScale based on Object
	abstract;
	
static final function float CanvasGetHeightScale(Canvas C)
{
	local float Scale;
	
	Scale = (4.0 / 3.0) / (C.SizeX / float(C.SizeY));
	
	// Metallicafan212:	Force it to be 4/3 if below 4/3, so the menus don't fuck up
	if(Scale > 1.0)
		return 1.0;
	
	return Scale;
}

static final function float UWindowGetHeightScale(UWindowRootWindow Root)
{
	local float Scale;
	
	Scale = (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);
	
	// Metallicafan212:	Force it to be 4/3 if below 4/3, so the menus don't fuck up
	if(Scale > 1.0)
		return 1.0;
	
	return Scale;
}