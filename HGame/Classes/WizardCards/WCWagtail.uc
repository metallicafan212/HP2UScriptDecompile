//================================================================================
// WCWagtail.
//================================================================================

class WCWagtail extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWagtailBigTexture.PNG	GROUP=Icons	Name=WizCardWagtailBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWagtailTex0.PNG	GROUP=Skins	Name=WizardCardWagtailTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Myron Wagtail";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=76

    textureBig=Texture'HGame.Icons.WizCardWagtailBigTexture'

    strDescriptionId="WizCard_0070"

    Skin=Texture'HGame.Skins.WizardCardWagtailTex0'

}
