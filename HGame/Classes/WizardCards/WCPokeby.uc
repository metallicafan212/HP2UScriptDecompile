//================================================================================
// WCPokeby.
//================================================================================

class WCPokeby extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPokebyBigTexture.PNG	GROUP=Icons	Name=WizCardPokebyBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardPokebyTex0.PNG	GROUP=Skins	Name=WizardCardPokebyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Gulliver Pokeby";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=5

    textureBig=Texture'HGame.Icons.WizCardPokebyBigTexture'

    strDescriptionId="WizCard_0043"

    Skin=Texture'HGame.Skins.WizardCardPokebyTex0'

}
