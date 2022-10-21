//================================================================================
// WCTwonk.
//================================================================================

class WCTwonk extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardTwonkBigTexture.PNG	GROUP=Icons	Name=WizCardTwonkBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardTwonkTex0.PNG	GROUP=Skins	Name=WizardCardTwonkTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Norvel Twonk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=77

    textureBig=Texture'HGame.Icons.WizCardTwonkBigTexture'

    strDescriptionId="WizCard_0071"

    Skin=Texture'HGame.Skins.WizardCardTwonkTex0'

}
