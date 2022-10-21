//================================================================================
// WCRastrick.
//================================================================================

class WCRastrick extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardRastrickBigTexture.PNG	GROUP=Icons	Name=WizCardRastrickBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardRastrickTex0.PNG	GROUP=Skins	Name=WizardCardRastrickTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Xavier Rastrick";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=92

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardRastrickBigTexture'

    strDescriptionId="WizCard_0006"

    Skin=Texture'HGame.Skins.WizardCardRastrickTex0'

}
