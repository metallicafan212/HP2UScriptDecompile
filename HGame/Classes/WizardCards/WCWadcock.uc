//================================================================================
// WCWadcock.
//================================================================================

class WCWadcock extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWadcockBigTexture.PNG	GROUP=Icons	Name=WizCardWadcockBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardWadcockTex0.PNG	GROUP=Skins	Name=WizardCardWadcockTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Joscelind Wadcock";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=36

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardWadcockBigTexture'

    strDescriptionId="WizCard_0032"

    Skin=Texture'HGame.Skins.WizardCardWadcockTex0'

}
