//================================================================================
// WCMontmorency.
//================================================================================

class WCMontmorency extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMontmorencyBigTexture.PNG	GROUP=Icons	Name=WizCardMontmorencyBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardMontmorencyTex0.PNG	GROUP=Skins	Name=WizardCardMontmorencyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Laverne de Montmorency";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=60

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardMontmorencyBigTexture'

    strDescriptionId="WizCard_0096"

    Skin=Texture'HGame.Skins.WizardCardMontmorencyTex0'

}
