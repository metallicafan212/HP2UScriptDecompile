//================================================================================
// WCAgrippa.
//================================================================================

class WCAgrippa extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardAgrippaBigTexture.PNG	GROUP=Icons	Name=WizCardAgrippaBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardAgrippaTex0.PNG	GROUP=Skins	Name=WizardCardAgrippaTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Cornelius Agrippa";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=2

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardAgrippaBigTexture'
	textureBig=Texture'HGame.Icons.WizCardAgrippaBigTexture'

    strDescriptionId="WizCard_0040"
	
	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardAgrippaTex0'
	Skin=Texture'HGame.Skins.WizardCardAgrippaTex0'
}
