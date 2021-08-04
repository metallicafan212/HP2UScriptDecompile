//================================================================================
// WCAlderton.
//================================================================================

class WCAlderton extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardAldertonBigTexture.PNG	GROUP=Icons	Name=WizCardAldertonBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardAldertonTex0.PNG	GROUP=Skins	Name=WizardCardAldertonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Archibald Alderton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=29

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardAldertonBigTexture'
    textureBig=Texture'HGame.Icons.WizCardAldertonBigTexture'

    strDescriptionId="WizCard_0036"
	
	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardAldertonTex0'
    Skin=Texture'HGame.Skins.WizardCardAldertonTex0'
}
