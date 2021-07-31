//================================================================================
// WCShimpling.
//================================================================================

class WCShimpling extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardShimplingBigTexture.PNG	GROUP=Icons	Name=WizCardShimplingBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardShimplingTex0.PNG	GROUP=Skins	Name=WizardCardShimplingTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Derwent Shimpling";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=8

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardShimplingBigTexture'

    strDescriptionId="WizCard_0057"

    Skin=Texture'HGame.Skins.WizardCardShimplingTex0'

}
