//================================================================================
// WCWhitehorn.
//================================================================================

class WCWhitehorn extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWhitehornBigTexture.PNG	GROUP=Icons	Name=WizCardWhitehornBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardWhitehornTex0.PNG	GROUP=Skins	Name=WizardCardWhitehornTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Devlin Whitehorn";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=44

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardWhitehornBigTexture'

    strDescriptionId="WizCard_0082"

    Skin=Texture'HGame.Skins.WizardCardWhitehornTex0'

}
