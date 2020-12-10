//================================================================================
// WCMerlin.
//================================================================================

class WCMerlin extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMerlinBigTexture.PNG	GROUP=Icons	Name=WizCardMerlinBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardMerlinTex0.PNG	GROUP=Skins	Name=WizardCardMerlinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Merlin";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=1

    textureBig=Texture'HGame.Icons.WizCardMerlinBigTexture'

    strDescriptionId="WizCard_0039"

    Skin=Texture'HGame.Skins.WizardCardMerlinTex0'

}
