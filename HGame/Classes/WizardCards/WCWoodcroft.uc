//================================================================================
// WCWoodcroft.
//================================================================================

class WCWoodcroft extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWoodcroftBigTexture.PNG	GROUP=Icons	Name=WizCardWoodcroftBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardWoodcroftTex0.PNG	GROUP=Skins	Name=WizardCardWoodcroftTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Hengist of Woodcroft";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=96

    textureBig=Texture'HGame.Icons.WizCardWoodcroftBigTexture'

    strDescriptionId="WizCard_0009"

    Skin=Texture'HGame.Skins.WizardCardWoodcroftTex0'

}
