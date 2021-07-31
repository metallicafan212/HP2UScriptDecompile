//================================================================================
// WCPinkstone.
//================================================================================

class WCPinkstone extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPinkstoneBigTexture.PNG	GROUP=Icons	Name=WizCardPinkstoneBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardCarlottaBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardCarlottaBigTextureLayer0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardCarlottaBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardCarlottaBigTextureLayer1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Icons\WizCardCarlottaBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardCarlottaBigTextureLayer2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardPinkstoneTex0.PNG	GROUP=Skins	Name=WizardCardPinkstoneTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Carlotta Pinkstone";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=40

    textureBig=Texture'HGame.Icons.WizCardPinkstoneBigTexture'

    strDescriptionId="WizCard_0017"

    textureLayers(0)=Texture'HGame.Icons.WizCardCarlottaBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardCarlottaBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardCarlottaBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardPinkstoneTex0'

}
