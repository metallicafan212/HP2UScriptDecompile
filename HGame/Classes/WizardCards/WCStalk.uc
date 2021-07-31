//================================================================================
// WCStalk.
//================================================================================

class WCStalk extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardStalkBigTexture.PNG	GROUP=Icons	Name=WizCardStalkBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardStalkTex0.PNG	GROUP=Skins	Name=WizardCardStalkTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Blenheim Stalk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=85

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardStalkBigTexture'

    strDescriptionId="WizCard_0010"

    Skin=Texture'HGame.Skins.WizardCardStalkTex0'

}
