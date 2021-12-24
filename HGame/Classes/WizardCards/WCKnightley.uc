//================================================================================
// WCKnightley.
//================================================================================

class WCKnightley extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardKnightleyBigTexture.PNG	GROUP=Icons	Name=WizCardKnightleyBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMontagueBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardMontagueBigTextureLayer0 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMontagueBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardMontagueBigTextureLayer1 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Icons\WizCardMontagueBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardMontagueBigTextureLayer2 COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardKnightleyTex0.PNG	GROUP=Skins	Name=WizardCardKnightleyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Montague Knightley";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=74

    textureBig=Texture'HGame.Icons.WizCardKnightleyBigTexture'

    strDescriptionId="WizCard_0068"

    textureLayers(0)=Texture'HGame.Icons.WizCardMontagueBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardMontagueBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardMontagueBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardKnightleyTex0'

}
