//================================================================================
// HPMenuOptionCheckBox.
//================================================================================

class HPMenuOptionCheckBox extends HGameCheckbox;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\FEOptionTickCheckedTex.PNG	GROUP=Icons	Name=FEOptionTickCheckedTex COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEOptionTickCheckedOverTex.PNG	GROUP=Icons	Name=FEOptionTickCheckedOverTex COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEOptionTickUncheckedTex.PNG	GROUP=Icons	Name=FEOptionTickUncheckedTex COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\FEOptionTickUncheckedOverTex.PNG	GROUP=Icons	Name=FEOptionTickUncheckedOverTex COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2

//texture vars for importing -AdamJD
var Texture TBoxChecked;
var Texture TBoxCheckedOver;
var Texture TBoxUnchecked;
var Texture TBoxUncheckedOver;


function Checkbox_SetupSizes (HGameCheckbox W, Canvas C)
{
	local float TW;
	local float TH;

	W.TextSize(C, W.Text, TW, TH);
	W.WinHeight = Max(TH + 1, 16);
	W.ImageX 	= 0.0;
	W.TextX 	= 13.0 + 4;
	W.ImageY 	= ((W.WinHeight - 12) * Class'M212HScale'.Static.UWindowGetHeightScale(Root)) / 2;
	W.TextY 	= ((W.WinHeight - TH) * Class'M212HScale'.Static.UWindowGetHeightScale(Root)) / 2;
	
	if ( W.bChecked )
	{
		W.UpTexture = TBoxChecked; 			//Texture'FEOptionTickCheckedTex';
		W.DownTexture = TBoxCheckedOver; 	//Texture'FEOptionTickCheckedOverTex';
		W.OverTexture = TBoxCheckedOver;	//Texture'FEOptionTickCheckedOverTex';
		W.DisabledTexture = None;
	} 
	else 
	{
		W.UpTexture = TBoxUnchecked; 		//Texture'FEOptionTickUncheckedTex';
		W.DownTexture = TBoxUncheckedOver; 	//Texture'FEOptionTickUncheckedOverTex';
		W.OverTexture = TBoxUncheckedOver; 	//Texture'FEOptionTickUncheckedOverTex';
		W.DisabledTexture = None;
	}
}

function BeforePaint (Canvas C, float X, float Y)
{
	Checkbox_SetupSizes(self,C);
}

function Paint (Canvas C, float X, float Y)
{
	Super.Paint(C,X,Y);
}

//get the imported textures -AdamJD
defaultproperties
{
	TBoxChecked=FEOptionTickCheckedTex
	
	TBoxCheckedOver=FEOptionTickCheckedOverTex
	
	TBoxUnchecked=FEOptionTickUncheckedTex
	
	TBoxUncheckedOver=FEOptionTickUncheckedOverTex
}
