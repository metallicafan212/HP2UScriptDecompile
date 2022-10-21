//================================================================================
// WCNutcombe.
//================================================================================

class WCNutcombe extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardNutcombeBigTexture.PNG	GROUP=Icons	Name=WizCardNutcombeBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardNutcombeTex0.PNG	GROUP=Skins	Name=WizardCardNutcombeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Honoria Nutcombe";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=55

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardNutcombeBigTexture'

    strDescriptionId="WizCard_0091"

    Skin=Texture'HGame.Skins.WizardCardNutcombeTex0'

}
