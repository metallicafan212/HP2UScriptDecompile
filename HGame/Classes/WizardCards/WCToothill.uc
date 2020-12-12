//================================================================================
// WCToothill.
//================================================================================

class WCToothill extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardToothillBigTexture.PNG	GROUP=Icons	Name=WizCardToothillBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardToothillTex0.PNG	GROUP=Skins	Name=WizardCardToothillTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Alberta Toothill";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=89

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardToothillBigTexture'

    strDescriptionId="WizCard_0003"

    Skin=Texture'HGame.Skins.WizardCardToothillTex0'

}
