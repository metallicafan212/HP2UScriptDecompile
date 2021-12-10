//================================================================================
// WCSweeting.
//================================================================================

class WCSweeting extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardSweetingBigTexture.PNG	GROUP=Icons	Name=WizCardSweetingBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardSweetingTex0.PNG	GROUP=Skins	Name=WizardCardSweetingTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Havelock Sweeting";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=61

    textureBig=Texture'HGame.Icons.WizCardSweetingBigTexture'

    strDescriptionId="WizCard_0097"

    Skin=Texture'HGame.Skins.WizardCardSweetingTex0'

}
