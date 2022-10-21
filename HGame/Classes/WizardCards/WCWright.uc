//================================================================================
// WCWright.
//================================================================================

class WCWright extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWrightBigTexture.PNG	GROUP=Icons	Name=WizCardWrightBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWrightTex0.PNG	GROUP=Skins	Name=WizardCardWrightTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Bowman Wright";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=35

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardWrightBigTexture'

    strDescriptionId="WizCard_0031"

    Skin=Texture'HGame.Skins.WizardCardWrightTex0'

}
