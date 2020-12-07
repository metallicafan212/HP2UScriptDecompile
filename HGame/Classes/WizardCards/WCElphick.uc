//================================================================================
// WCElphick.
//================================================================================

class WCElphick extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardElphickBigTexture.PNG	GROUP=Icons	Name=WizCardElphickBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardElphickTex0.PNG	GROUP=Skins	Name=WizardCardElphickTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Wilfred Elphick";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=91

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE170"

    textureBig=Texture'HGame.Icons.WizCardElphickBigTexture'

    strDescriptionId="WizCard_0005"

    Skin=Texture'HGame.Skins.WizardCardElphickTex0'

}
