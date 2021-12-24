//================================================================================
// WCPlatt.
//================================================================================

class WCPlatt extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPlattBigTexture.PNG	GROUP=Icons	Name=WizCardPlattBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardPlattTex0.PNG	GROUP=Skins	Name=WizardCardPlattTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Yardley Platt";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=95

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardPlattBigTexture'

    strDescriptionId="WizCard_0014"

    Skin=Texture'HGame.Skins.WizardCardPlattTex0'

}
