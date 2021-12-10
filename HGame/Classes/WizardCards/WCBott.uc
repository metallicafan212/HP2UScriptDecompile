//================================================================================
// WCBott.
//================================================================================

class WCBott extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBottBigTexture.PNG	GROUP=Icons	Name=WizCardBottBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardBertieBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardBertieBigTextureLayer0 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardBertieBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardBertieBigTextureLayer1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardBertieBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardBertieBigTextureLayer2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBottTex0.PNG	GROUP=Skins	Name=WizardCardBottTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Bertie Bott";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=69

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBottBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBottBigTexture'

    strDescriptionId="WizCard_0063"

	//you have to do this for every gold card... -AdamJD
	//
	textureLayers(0)=Texture'HGame.Icons.WizCardBertieBigTextureLayer0'
    textureLayers(1)=Texture'HGame.Icons.WizCardBertieBigTextureLayer1'
    textureLayers(2)=Texture'HGame.Icons.WizCardBertieBigTextureLayer2'

    // textureLayers(0)=Texture'Icons.WizCardBertieBigTextureLayer0'
    // textureLayers(1)=Texture'Icons.WizCardBertieBigTextureLayer1'
    // textureLayers(2)=Texture'Icons.WizCardBertieBigTextureLayer2'

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBottTex0'
	Skin=Texture'HGame.Skins.WizardCardBottTex0'
}
