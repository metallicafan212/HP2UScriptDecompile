//================================================================================
// WCSykes.
//================================================================================

class WCSykes extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardSykesBigTexture.PNG	GROUP=Icons	Name=WizCardSykesBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardSykesTex0.PNG	GROUP=Skins	Name=WizardCardSykesTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Jocunda Sykes";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=64

    textureBig=Texture'HGame.Icons.WizCardSykesBigTexture'

    strDescriptionId="WizCard_0067"

    Skin=Texture'HGame.Skins.WizardCardSykesTex0'

}
