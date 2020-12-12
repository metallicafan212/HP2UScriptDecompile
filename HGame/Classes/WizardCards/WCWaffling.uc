//================================================================================
// WCWaffling.
//================================================================================

class WCWaffling extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWafflingBigTexture.PNG	GROUP=Icons	Name=WizCardWafflingBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardWafflingTex0.PNG	GROUP=Skins	Name=WizardCardWafflingTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Adalbert Waffling";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=24

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardWafflingBigTexture'

    strDescriptionId="WizCard_0020"

    Skin=Texture'HGame.Skins.WizardCardWafflingTex0'

}
