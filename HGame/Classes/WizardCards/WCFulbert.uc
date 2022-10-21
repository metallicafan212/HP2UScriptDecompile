//================================================================================
// WCFulbert.
//================================================================================

class WCFulbert extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardFulbertBigTexture.PNG	GROUP=Icons	Name=WizCardFulbertBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardFulbertTex0.PNG	GROUP=Skins	Name=WizardCardFulbertTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Fulbert the Fearful";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=14

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE050"

    textureBig=Texture'HGame.Icons.WizCardFulbertBigTexture'

    strDescriptionId="WizCard_0052"

    Skin=Texture'HGame.Skins.WizardCardFulbertTex0'

}
