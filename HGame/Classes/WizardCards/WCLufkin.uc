//================================================================================
// WCLufkin.
//================================================================================

class WCLufkin extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardLufkinBigTexture.PNG	GROUP=Icons	Name=WizCardLufkinBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardLufkinTex0.PNG	GROUP=Skins	Name=WizardCardLufkinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Artemisia Lufkin";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=30

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardLufkinBigTexture'

    strDescriptionId="WizCard_0026"

    Skin=Texture'HGame.Skins.WizardCardLufkinTex0'

}
