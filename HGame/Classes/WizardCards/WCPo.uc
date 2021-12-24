//================================================================================
// WCPo.
//================================================================================

class WCPo extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPoBigTexture.PNG	GROUP=Icons	Name=WizCardPoBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardPoTex0.PNG	GROUP=Skins	Name=WizardCardPoTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Quong Po";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=81

    textureBig=Texture'HGame.Icons.WizCardPoBigTexture'

    strDescriptionId="WizCard_0075"

    Skin=Texture'HGame.Skins.WizardCardPoTex0'

}
