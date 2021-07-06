//================================================================================
// WCCatchlove.
//================================================================================

class WCCatchlove extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardCatchloveBigTexture.PNG	GROUP=Icons	Name=WizCardCatchloveBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardCatchloveTex0.PNG	GROUP=Skins	Name=WizardCardCatchloveTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Greta Catchlove";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=53

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCatchloveBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCatchloveBigTexture'

    strDescriptionId="WizCard_0089"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCatchloveTex0'
	Skin=Texture'HGame.Skins.WizardCardCatchloveTex0'
}
