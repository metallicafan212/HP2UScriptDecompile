//================================================================================
// WCPlumpton.
//================================================================================

class WCPlumpton extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Roderic Plumpton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=83

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardPlumptonBigTexture'

    strDescriptionId="WizCard_0077"

    Skin=Texture'HGame.Skins.WizardCardPlumptonTex0'

}
