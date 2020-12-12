//================================================================================
// WCToke.
//================================================================================

class WCToke extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardTokeBigTexture.PNG	GROUP=Icons	Name=WizCardTokeBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardTokeTex0.PNG	GROUP=Skins	Name=WizardCardTokeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Tilly Toke";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=28

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE090"

    textureBig=Texture'HGame.Icons.WizCardTokeBigTexture'

    strDescriptionId="WizCard_0024"

    Skin=Texture'HGame.Skins.WizardCardTokeTex0'

}
