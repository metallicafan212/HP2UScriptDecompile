//================================================================================
// WCSummerbee.
//================================================================================

class WCSummerbee extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardSummerbeeBigTexture.PNG	GROUP=Icons	Name=WizCardSummerbeeBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardSummerbeeTex0.PNG	GROUP=Skins	Name=WizardCardSummerbeeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Felix Summerbee";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=52

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardSummerbeeBigTexture'

    strDescriptionId="WizCard_0035"

    Skin=Texture'HGame.Skins.WizardCardSummerbeeTex0'

}
