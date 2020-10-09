//================================================================================
// WCOldridge.
//================================================================================

class WCOldridge extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Chauncey Oldridge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=38

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardOldridgeBigTexture'

    strDescriptionId="WizCard_0034"

    Skin=Texture'HGame.Skins.WizardCardOldridgeTex0'

}
