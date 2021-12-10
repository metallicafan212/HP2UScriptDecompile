//================================================================================
// WCWenlock.
//================================================================================

class WCWenlock extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWenlockBigTexture.PNG	GROUP=Icons	Name=WizCardWenlockBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWenlockTex0.PNG	GROUP=Skins	Name=WizardCardWenlockTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Bridget Wenlock";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=32

    textureBig=Texture'HGame.Icons.WizCardWenlockBigTexture'

    strDescriptionId="WizCard_0028"

    Skin=Texture'HGame.Skins.WizardCardWenlockTex0'

}
