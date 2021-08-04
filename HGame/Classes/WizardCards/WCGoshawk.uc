//================================================================================
// WCGoshawk.
//================================================================================

class WCGoshawk extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardGoshawkBigTexture.PNG	GROUP=Icons	Name=WizCardGoshawkBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardGoshawkTex0.PNG	GROUP=Skins	Name=WizardCardGoshawkTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Miranda Goshawk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=46

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardGoshawkBigTexture'

    strDescriptionId="WizCard_0084"

    Skin=Texture'HGame.Skins.WizardCardGoshawkTex0'

}
