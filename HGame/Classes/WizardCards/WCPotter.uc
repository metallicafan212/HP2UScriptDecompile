//================================================================================
// WCPotter.
//================================================================================

class WCPotter extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPotterBigTexture.PNG	GROUP=Icons	Name=WizCardPotterBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHarryBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardHarryBigTextureLayer0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHarryBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardHarryBigTextureLayer1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHarryBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardHarryBigTextureLayer2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardPotterTex0.PNG	GROUP=Skins	Name=WizardCardPotterTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Harry Potter";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=100

    textureBig=Texture'HGame.Icons.WizCardPotterBigTexture'

    strDescriptionId="WizCard_0038"

    textureLayers(0)=Texture'HGame.Icons.WizCardHarryBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardHarryBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardHarryBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardPotterTex0'

}
