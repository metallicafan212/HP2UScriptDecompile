//================================================================================
// WCFay.
//================================================================================

class WCFay extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardFayBigTexture.PNG	GROUP=Icons	Name=WizCardFayBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardFayTex0.PNG	GROUP=Skins	Name=WizardCardFayTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Morgan le Fay";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=17

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardFayBigTexture'

    strDescriptionId="WizCard_0055"

    Skin=Texture'HGame.Skins.WizardCardFayTex0'

}
