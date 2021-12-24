//================================================================================
// WCEthelred.
//================================================================================

class WCEthelred extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardEthelredBigTexture.PNG	GROUP=Icons	Name=WizCardEthelredBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardEthelredTex0.PNG	GROUP=Skins	Name=WizardCardEthelredTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Ethelred the Ever-Ready";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=51

    textureBig=Texture'HGame.Icons.WizCardEthelredBigTexture'

    strDescriptionId="WizCard_0099"

    Skin=Texture'HGame.Skins.WizardCardEthelredTex0'

}
