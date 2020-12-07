//================================================================================
// WCCliodne.
//================================================================================

class WCCliodne extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardCliodneBigTexture.PNG	GROUP=Icons	Name=WizCardCliodneBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardCliodneTex0.PNG	GROUP=Skins	Name=WizardCardCliodneTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Cliodne";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=16

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCliodneBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCliodneBigTexture'

    strDescriptionId="WizCard_0054"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCliodneTex0'
	Skin=Texture'HGame.Skins.WizardCardCliodneTex0'
}
