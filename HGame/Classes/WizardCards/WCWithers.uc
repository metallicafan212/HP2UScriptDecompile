//================================================================================
// WCWithers.
//================================================================================

class WCWithers extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWithersBigTexture.PNG	GROUP=Icons	Name=WizCardWithersBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWithersTex0.PNG	GROUP=Skins	Name=WizardCardWithersTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Lord Stoddard Withers";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=21

    textureBig=Texture'HGame.Icons.WizCardWithersBigTexture'

    strDescriptionId="WizCard_0046"

    Skin=Texture'HGame.Skins.WizardCardWithersTex0'

}
