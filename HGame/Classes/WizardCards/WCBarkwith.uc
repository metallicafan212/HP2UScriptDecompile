//================================================================================
// WCBarkwith.
//================================================================================

class WCBarkwith extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBarkwithBigTexture.PNG	GROUP=Icons	Name=WizCardBarkwithBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBarkwithTex0.PNG	GROUP=Skins	Name=WizardCardBarkwithTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Musidora Barkwith";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=50

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBarkwithBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBarkwithBigTexture'

    strDescriptionId="WizCard_0008"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBarkwithTex0'
	Skin=Texture'HGame.Skins.WizardCardBarkwithTex0'
}
