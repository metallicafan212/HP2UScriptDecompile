//================================================================================
// WCWildsmith.
//================================================================================

class WCWildsmith extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWildsmithBigTexture.PNG	GROUP=Icons	Name=WizCardWildsmithBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWildsmithTex0.PNG	GROUP=Skins	Name=WizardCardWildsmithTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Ignatia Wildsmith";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=62

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardWildsmithBigTexture'

    strDescriptionId="WizCard_0098"

    Skin=Texture'HGame.Skins.WizardCardWildsmithTex0'

}
