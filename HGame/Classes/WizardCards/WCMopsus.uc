//================================================================================
// WCMopsus.
//================================================================================

class WCMopsus extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMopsusBigTexture.PNG	GROUP=Icons	Name=WizCardMopsusBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardMopsusTex0.PNG	GROUP=Skins	Name=WizardCardMopsusTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Mopsus";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=73

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardMopsusBigTexture'

    strDescriptionId="WizCard_0078"

    Skin=Texture'HGame.Skins.WizardCardMopsusTex0'

}
