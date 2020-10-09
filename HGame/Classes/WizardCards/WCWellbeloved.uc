//================================================================================
// WCWellbeloved.
//================================================================================

class WCWellbeloved extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Dorcas Wellbeloved";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=86

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardWellbelovedBigTexture'

    strDescriptionId="WizCard_0000"

    Skin=Texture'HGame.Skins.WizardCardWellbelovedTex0'

}
