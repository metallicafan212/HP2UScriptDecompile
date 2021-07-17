//================================================================================
// HPMenuOptionHSlider.
//================================================================================

class HPMenuOptionHSlider extends HGameHSlider;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\FESliderTexture.PNG	GROUP=Icons	Name=FESliderTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEOverSliderTexture.PNG	GROUP=Icons	Name=FEOverSliderTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FESliderKnobTexture.PNG	GROUP=Icons	Name=FESliderKnobTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2

var Texture Image;
var Texture overImage;
var Texture knobImage;
var float fSliderOffsetX;

//texture vars for importing -AdamJD
var Texture textureSlider;
Var Texture textureOverSlider;
var Texture textureSliderKnob;

var bool bStretchTex;


function Created ()
{
	// Metallicafan212:	Needed for scaling
	WinHeight 		= 24.0;

	Super.Created();
	
	SliderWidth 	= 145.0;
	
	Image 			= textureSlider;			//Texture'FESliderTexture';
	overImage 		= textureOverSlider;	//Texture'FEOverSliderTexture';
	knobImage 		= textureSliderKnob;	//Texture'FESliderKnobTexture';
	
	fSliderOffsetX 	= 2.0;
	TrackWidth 		= 22.0;
}

function BeforePaint (Canvas C, float X, float Y)
{
	local float W;
	local float H;
	
	local float HScale;
	
	HScale = Class'M212HScale'.Static.UWindowGetHeightScale(Root);

	TextSize(C, Text, W, H);
	
	SliderDrawX 	= (fSliderOffsetX + WinWidth - (SliderWidth * HScale));
	TextX 			= SliderDrawX - (W) - 23;
	SliderDrawY 	= ((WinHeight - 2) * HScale) / 2;
	TextY 			= (WinHeight - H) / 2;
	TrackStart 		= SliderDrawX + ((SliderWidth - TrackWidth) * HScale) * (Value - MinValue) / (MaxValue - MinValue);
}

function DrawStretchedTextureSegment( Canvas C, float X, float Y, float W, float H, 
									  float tX, float tY, float tW, float tH, texture Tex ) 
{
	local float OrgX, OrgY, ClipX, ClipY;

	OrgX = C.OrgX;
	OrgY = C.OrgY;
	ClipX = C.ClipX;
	ClipY = C.ClipY;

	C.SetOrigin(OrgX + ClippingRegion.X * Root.GUIScale, OrgY + ClippingRegion.Y * Root.GUIScale);
	C.SetClip(Root.RealWidth, Root.RealHeight);//ClippingRegion.W * Root.GUIScale, ClippingRegion.H * Root.GUIScale);

	C.SetPos((X - ClippingRegion.X) * Root.GUIScale, (Y - ClippingRegion.Y) * Root.GUIScale);
	
	if(bStretchTex)
	{
		C.DrawTileClipped(Tex, W * Root.GUIScale, H * Root.GUIScale * Class'M212HScale'.Static.UWindowGetHeightScale(Root), tX, tY, tW, tH);
	}
	else
	{
		C.DrawTileClipped( Tex, W * Root.GUIScale * Class'M212HScale'.Static.UWindowGetHeightScale(Root), H * Root.GUIScale * Class'M212HScale'.Static.UWindowGetHeightScale(Root), tX, tY, tW, tH);
	}
	
	C.SetClip(ClipX, ClipY);
	C.SetOrigin(OrgX, OrgY);
}

function Paint (Canvas C, float X, float Y)
{
	local Texture t;
	local Region R;

	t = GetLookAndFeelTexture();
	if ( Text != "" )
	{
		C.DrawColor = TextColor;
		ClipText(C, TextX, TextY, Text);
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;
	}
	R = LookAndFeel.HLine;
	
	// Metallicafan212:	Force it to scale correctly
	//bStretchTex = true;
	DrawClippedTexture(C, SliderDrawX - fSliderOffsetX, 0.0, Image);
	
	if ( MouseIsOver() )
	{
		DrawClippedTexture(C, SliderDrawX - fSliderOffsetX, 0.0, overImage);
	}
	//bStretchTex = false;
	
	DrawClippedTexture(C, TrackStart, 0.0, knobImage);
}

//get the imported textures -AdamJD
defaultproperties
{
	textureSlider=FESliderTexture
	
	textureOverSlider=FEOverSliderTexture
	
	textureSliderKnob=FESliderKnobTexture
}
