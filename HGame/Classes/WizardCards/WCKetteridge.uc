//================================================================================
// WCKetteridge.
//================================================================================

class WCKetteridge extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardKetteridgeBigTexture.PNG	GROUP=Icons	Name=WizCardKetteridgeBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardKetteridgeTex0.PNG	GROUP=Skins	Name=WizardCardKetteridgeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Elladora Ketteridge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=49

    textureBig=Texture'HGame.Icons.WizCardKetteridgeBigTexture'

    strDescriptionId="WizCard_0087"

    Skin=Texture'HGame.Skins.WizardCardKetteridgeTex0'

}
