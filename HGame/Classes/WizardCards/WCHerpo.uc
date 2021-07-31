//================================================================================
// WCHerpo.
//================================================================================

class WCHerpo extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardHerpoBigTexture.PNG	GROUP=Icons	Name=WizCardHerpoBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHerpoBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardHerpoBigTextureLayer0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHerpoBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardHerpoBigTextureLayer1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHerpoBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardHerpoBigTextureLayer2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardHerpoTex0.PNG	GROUP=Skins	Name=WizardCardHerpoTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Herpo!";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=11

    textureBig=Texture'HGame.Icons.WizCardHerpoBigTexture'

    strDescriptionId="WizCard_0049"

    textureLayers(0)=Texture'HGame.Icons.WizCardHerpoBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardHerpoBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardHerpoBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardHerpoTex0'

}
