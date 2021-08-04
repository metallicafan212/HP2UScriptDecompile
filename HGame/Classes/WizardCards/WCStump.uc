//================================================================================
// WCStump.
//================================================================================

class WCStump extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardStumpBigTexture.PNG	GROUP=Icons	Name=WizCardStumpBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardStumpTex0.PNG	GROUP=Skins	Name=WizardCardStumpTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Grogan Stump";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=4

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardStumpBigTexture'

    strDescriptionId="WizCard_0042"

    Skin=Texture'HGame.Skins.WizardCardStumpTex0'

}
