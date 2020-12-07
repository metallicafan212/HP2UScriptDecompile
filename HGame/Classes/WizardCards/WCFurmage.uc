//================================================================================
// WCFurmage.
//================================================================================

class WCFurmage extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardFurmageBigTexture.PNG	GROUP=Icons	Name=WizCardFurmageBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardFurmageTex0.PNG	GROUP=Skins	Name=WizardCardFurmageTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Dymphna Furmage";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=98

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardFurmageBigTexture'

    strDescriptionId="WizCard_0012"

    Skin=Texture'HGame.Skins.WizardCardFurmageTex0'

}
