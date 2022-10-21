//================================================================================
// WCWendelin.
//================================================================================

class WCWendelin extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWendelinBigTexture.PNG	GROUP=Icons	Name=WizCardWendelinBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWendelinTex0.PNG	GROUP=Skins	Name=WizardCardWendelinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Wendelin the Weird";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=20

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardWendelinBigTexture'

    strDescriptionId="WizCard_0025"

    Skin=Texture'HGame.Skins.WizardCardWendelinTex0'

}
