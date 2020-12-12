//================================================================================
// WCWellbeloved.
//================================================================================

class WCWellbeloved extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardWellbelovedBigTexture.PNG	GROUP=Icons	Name=WizCardWellbelovedBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardWellbelovedTex0.PNG	GROUP=Skins	Name=WizardCardWellbelovedTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Dorcas Wellbeloved";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=86

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardWellbelovedBigTexture'

    strDescriptionId="WizCard_0000"

    Skin=Texture'HGame.Skins.WizardCardWellbelovedTex0'

}
