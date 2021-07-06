//================================================================================
// WCRavenclaw.
//================================================================================

class WCRavenclaw extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardRavenclawBigTexture.PNG	GROUP=Icons	Name=WizCardRavenclawBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\WizCardRowenaBigTextureLayer0.PNG	GROUP=Icons	Name=WizCardRowenaBigTextureLayer0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\WizCardRowenaBigTextureLayer1.PNG	GROUP=Icons	Name=WizCardRowenaBigTextureLayer1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Icons\WizCardRowenaBigTextureLayer2.PNG	GROUP=Icons	Name=WizCardRowenaBigTextureLayer2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardRavenclawTex0.PNG	GROUP=Skins	Name=WizardCardRavenclawTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Rowena Ravenclaw";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=82

    textureBig=Texture'HGame.Icons.WizCardRavenclawBigTexture'

    strDescriptionId="WizCard_0076"

    textureLayers(0)=Texture'HGame.Icons.WizCardRowenaBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardRowenaBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardRowenaBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardRavenclawTex0'

}
