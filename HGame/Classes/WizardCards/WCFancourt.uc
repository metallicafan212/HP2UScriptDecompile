//================================================================================
// WCFancourt.
//================================================================================

class WCFancourt extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardFancourtBigTexture.PNG	GROUP=Icons	Name=WizCardFancourtBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardFancourtTex0.PNG	GROUP=Skins	Name=WizardCardFancourtTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Perpetua Fancourt";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=25

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardFancourtBigTexture'

    strDescriptionId="WizCard_0021"

    Skin=Texture'HGame.Skins.WizardCardFancourtTex0'

}
