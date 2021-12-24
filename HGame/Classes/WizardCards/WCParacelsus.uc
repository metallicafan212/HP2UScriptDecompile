//================================================================================
// WCParacelsus.
//================================================================================

class WCParacelsus extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardParacelsusBigTexture.PNG	GROUP=Icons	Name=WizCardParacelsusBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardParacelsusTex0.PNG	GROUP=Skins	Name=WizardCardParacelsusTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Paracelsus";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=15

    textureBig=Texture'HGame.Icons.WizCardParacelsusBigTexture'

    strDescriptionId="WizCard_0053"

    Skin=Texture'HGame.Skins.WizardCardParacelsusTex0'

}
