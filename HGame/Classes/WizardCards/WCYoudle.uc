//================================================================================
// WCYoudle.
//================================================================================

class WCYoudle extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardYoudleBigTexture.PNG	GROUP=Icons	Name=WizCardYoudleBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardYoudleTex0.PNG	GROUP=Skins	Name=WizardCardYoudleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Cyprian Youdle";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=43

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardYoudleBigTexture'

    strDescriptionId="WizCard_0081"

    Skin=Texture'HGame.Skins.WizardCardYoudleTex0'

}
