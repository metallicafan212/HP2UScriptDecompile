//================================================================================
// WCWintringham.
//================================================================================

class WCWintringham extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWintringhamBigTexture.PNG	GROUP=Icons	Name=WizCardWintringhamBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWintringhamTex0.PNG	GROUP=Skins	Name=WizardCardWintringhamTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Herman Wintringham";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=63

    textureBig=Texture'HGame.Icons.WizCardWintringhamBigTexture'

    strDescriptionId="WizCard_0069"

    Skin=Texture'HGame.Skins.WizardCardWintringhamTex0'

}
