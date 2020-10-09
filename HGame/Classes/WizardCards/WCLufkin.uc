//================================================================================
// WCLufkin.
//================================================================================

class WCLufkin extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Artemisia Lufkin";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=30

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardLufkinBigTexture'

    strDescriptionId="WizCard_0026"

    Skin=Texture'HGame.Skins.WizardCardLufkinTex0'

}
