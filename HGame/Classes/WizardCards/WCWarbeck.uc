//================================================================================
// WCWarbeck.
//================================================================================

class WCWarbeck extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWarbeckBigTexture.PNG	GROUP=Icons	Name=WizCardWarbeckBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWarbeckTex0.PNG	GROUP=Skins	Name=WizardCardWarbeckTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Celestina Warbeck";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=88

    textureBig=Texture'HGame.Icons.WizCardWarbeckBigTexture'

    strDescriptionId="WizCard_0002"

    Skin=Texture'HGame.Skins.WizardCardWarbeckTex0'

}
