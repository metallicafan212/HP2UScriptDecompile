//================================================================================
// WCOliphant.
//================================================================================

class WCOliphant extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardOliphantBigTexture.PNG	GROUP=Icons	Name=WizCardOliphantBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardOliphantTex0.PNG	GROUP=Skins	Name=WizardCardOliphantTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Gondoline Oliphant";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=65

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardOliphantBigTexture'

    strDescriptionId="WizCard_0088"

    Skin=Texture'HGame.Skins.WizardCardOliphantTex0'

}
