//================================================================================
// WCSmethwyck.
//================================================================================

class WCSmethwyck extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardSmethwyckBigTexture.PNG	GROUP=Icons	Name=WizCardSmethwyckBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardSmethwyckTex0.PNG	GROUP=Skins	Name=WizardCardSmethwyckTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Leopoldina Smethwyck";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=70

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardSmethwyckBigTexture'

    strDescriptionId="WizCard_0064"

    Skin=Texture'HGame.Skins.WizardCardSmethwyckTex0'

}
