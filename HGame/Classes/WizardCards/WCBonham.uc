//================================================================================
// WCBonham.
//================================================================================

class WCBonham extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBonhamBigTexture.PNG	GROUP=Icons	Name=WizCardBonhamBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardBonhamTex0.PNG	GROUP=Skins	Name=WizardCardBonhamTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Mungo Bonham";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=75

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBonhamBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBonhamBigTexture'

    strDescriptionId="WizCard_0058"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBonhamTex0'
	Skin=Texture'HGame.Skins.WizardCardBonhamTex0'
}
