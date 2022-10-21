//================================================================================
// WCBelby.
//================================================================================

class WCBelby extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBelbyBigTexture.PNG	GROUP=Icons	Name=WizCardBelbyBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBelbyTex0.PNG	GROUP=Skins	Name=WizardCardBelbyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Flavius Belby";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=66

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBelbyBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBelbyBigTexture'
	
    strDescriptionId="WizCard_0060"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBelbyTex0'
	Skin=Texture'HGame.Skins.WizardCardBelbyTex0'
}
