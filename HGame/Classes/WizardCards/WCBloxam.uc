//================================================================================
// WCBloxam.
//================================================================================

class WCBloxam extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBloxamBigTexture.PNG	GROUP=Icons	Name=WizCardBloxamBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBloxamTex0.PNG	GROUP=Skins	Name=WizardCardBloxamTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Beatrix Bloxham";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=80

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBloxamBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBloxamBigTexture'

    strDescriptionId="WizCard_0074"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBloxamTex0'
	Skin=Texture'HGame.Skins.WizardCardBloxamTex0'
}
