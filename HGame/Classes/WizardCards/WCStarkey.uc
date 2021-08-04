//================================================================================
// WCStarkey.
//================================================================================

class WCStarkey extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardStarkeyBigTexture.PNG	GROUP=Icons	Name=WizCardStarkeyBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardStarkeyTex0.PNG	GROUP=Skins	Name=WizardCardStarkeyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Hesper Starkey";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=7

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE000"

    textureBig=Texture'HGame.Icons.WizCardStarkeyBigTexture'

    strDescriptionId="WizCard_0045"

    Skin=Texture'HGame.Skins.WizardCardStarkeyTex0'

}
