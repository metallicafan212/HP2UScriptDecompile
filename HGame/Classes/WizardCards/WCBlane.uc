//================================================================================
// WCBlane.
//================================================================================

class WCBlane extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBlaneBigTexture.PNG	GROUP=Icons	Name=WizCardBlaneBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBlaneTex0.PNG	GROUP=Skins	Name=WizardCardBlaneTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Balfour Blane";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=31

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBlaneBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBlaneBigTexture'

    strDescriptionId="WizCard_0016"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBlaneTex0'
	Skin=Texture'HGame.Skins.WizardCardBlaneTex0'
}
