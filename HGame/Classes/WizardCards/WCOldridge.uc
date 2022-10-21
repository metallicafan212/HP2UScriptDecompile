//================================================================================
// WCOldridge.
//================================================================================

class WCOldridge extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardOldridgeBigTexture.PNG	GROUP=Icons	Name=WizCardOldridgeBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardOldridgeTex0.PNG	GROUP=Skins	Name=WizardCardOldridgeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Chauncey Oldridge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=38

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardOldridgeBigTexture'

    strDescriptionId="WizCard_0034"

    Skin=Texture'HGame.Skins.WizardCardOldridgeTex0'

}
