//================================================================================
// WCShingleton.
//================================================================================

class WCShingleton extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardShingletonBigTexture.PNG	GROUP=Icons	Name=WizCardShingletonBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardShingletonTex0.PNG	GROUP=Skins	Name=WizardCardShingletonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Gaspard Shingleton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=54

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardShingletonBigTexture'

    strDescriptionId="WizCard_0079"

    Skin=Texture'HGame.Skins.WizardCardShingletonTex0'

}
