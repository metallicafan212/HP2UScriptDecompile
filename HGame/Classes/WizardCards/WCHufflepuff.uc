//================================================================================
// WCHufflepuff.
//================================================================================

class WCHufflepuff extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardHufflepuffBigTexture.PNG	GROUP=Icons	Name=WizCardHufflepuffBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHelgaBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardHelgaBigTextureLayer0 COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHelgaBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardHelgaBigTextureLayer1 COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardHelgaBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardHelgaBigTextureLayer2 COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardHufflepuffTex0.PNG	GROUP=Skins	Name=WizardCardHufflepuffTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Helga Hufflepuff";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=72

    textureBig=Texture'HGame.Icons.WizCardHufflepuffBigTexture'

    strDescriptionId="WizCard_0066"

    textureLayers(0)=Texture'HGame.Icons.WizCardHelgaBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardHelgaBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardHelgaBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardHufflepuffTex0'

}
