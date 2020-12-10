//================================================================================
// WCMuldoon.
//================================================================================

class WCMuldoon extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMuldoonBigTexture.PNG	GROUP=Icons	Name=WizCardMuldoonBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardMuldoonTex0.PNG	GROUP=Skins	Name=WizardCardMuldoonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Burdock Muldoon";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=10

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE100"

    textureBig=Texture'HGame.Icons.WizCardMuldoonBigTexture'

    strDescriptionId="WizCard_0037"

    Skin=Texture'HGame.Skins.WizardCardMuldoonTex0'

}
