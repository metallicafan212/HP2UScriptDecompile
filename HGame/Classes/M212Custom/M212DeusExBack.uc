// Metallicafan212:	Deus Ex version for my mod
class M212DeusExBack based on M212CustBack;

// Metallicafan212:	Import all the characters
//#exec Texture Import File=Textures\DeusExShit\Anna.png				GROUP=DeusEx	Name=DXAnna 	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
//#exec Texture Import File=Textures\DeusExShit\JC.png				GROUP=DeusEx	Name=DXJC 		COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
//#exec Texture Import File=Textures\DeusExShit\Paul.png				GROUP=DeusEx	Name=DXPaul 	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
//#exec Texture Import File=Textures\DeusExShit\LaputanMachine.png	GROUP=DeusEx	Name=DXLM 		COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
//#exec Texture Import File=Textures\DeusExShit\Logo.png				GROUP=DeusEx	Name=DXLogo 	COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914

var Texture Ann;
var Texture JC;
var Texture Paul;
var Texture LM;
var Texture DX;

// Metallicafan212:	Draw each
static function AfterBackgroundLayer(Canvas C, BaseFEPage P)
{
	// Metallicafan212:	Draw in order, based on how they overlap
	//					Starting with JC
	
}