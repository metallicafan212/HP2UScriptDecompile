//================================================================================
// WCScamander.
//================================================================================

class WCScamander extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardScamanderBigTexture.PNG	GROUP=Icons	Name=WizCardScamanderBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardScamanderTex0.PNG	GROUP=Skins	Name=WizardCardScamanderTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Newt Scamander";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=19

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardScamanderBigTexture'

    strDescriptionId="WizCard_0027"

    Skin=Texture'HGame.Skins.WizardCardScamanderTex0'

}
