//================================================================================
// WCMerwyn.
//================================================================================

class WCMerwyn extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMerwynBigTexture.PNG	GROUP=Icons	Name=WizCardMerwynBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardMerwynTex0.PNG	GROUP=Skins	Name=WizardCardMerwynTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Merwyn the Malicious";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=12

    textureBig=Texture'HGame.Icons.WizCardMerwynBigTexture'

    strDescriptionId="WizCard_0050"

    Skin=Texture'HGame.Skins.WizardCardMerwynTex0'

}
