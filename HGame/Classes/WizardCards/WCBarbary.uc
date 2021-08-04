//================================================================================
// WCBarbary.
//================================================================================

class WCBarbary extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBarbaryBigTexture.PNG	GROUP=Icons	Name=WizCardBarbaryBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBarbaryTex0.PNG	GROUP=Skins	Name=WizardCardBarbaryTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Heathcote Barbary";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=93

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBarbaryBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBarbaryBigTexture'

    strDescriptionId="WizCard_0007"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBarbaryTex0'
	Skin=Texture'HGame.Skins.WizardCardBarbaryTex0'
}
