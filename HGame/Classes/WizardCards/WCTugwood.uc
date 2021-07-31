//================================================================================
// WCTugwood.
//================================================================================

class WCTugwood extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardTugwoodBigTexture.PNG	GROUP=Icons	Name=WizCardTugwoodBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardTugwoodTex0.PNG	GROUP=Skins	Name=WizardCardTugwoodTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Sacharissa Tugwood";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=90

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE090"

    textureBig=Texture'HGame.Icons.WizCardTugwoodBigTexture'

    strDescriptionId="WizCard_0004"

    Skin=Texture'HGame.Skins.WizardCardTugwoodTex0'

}
