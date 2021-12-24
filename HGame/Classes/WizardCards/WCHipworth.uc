//================================================================================
// WCHipworth.
//================================================================================

class WCHipworth extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardHipworthBigTexture.PNG	GROUP=Icons	Name=WizCardHipworthBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardHipworthTex0.PNG	GROUP=Skins	Name=WizardCardHipworthTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Glover Hipworth";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=58

    textureBig=Texture'HGame.Icons.WizCardHipworthBigTexture'

    strDescriptionId="WizCard_0094"

    Skin=Texture'HGame.Skins.WizardCardHipworthTex0'

}
