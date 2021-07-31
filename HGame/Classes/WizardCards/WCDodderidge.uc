//================================================================================
// WCDodderidge.
//================================================================================

class WCDodderidge extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardDodderidgeBigTexture.PNG	GROUP=Icons	Name=WizCardDodderidgeBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardDodderidgeTex0.PNG	GROUP=Skins	Name=WizardCardDodderidgeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Daisy Dodderidge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=99

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardDodderidgeBigTexture'
	textureBig=Texture'HGame.Icons.WizCardDodderidgeBigTexture'

    strDescriptionId="WizCard_0011"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardDodderidgeTex0'
	Skin=Texture'HGame.Skins.WizardCardDodderidgeTex0'
}
