//================================================================================
// WCWadcock.
//================================================================================

class WCWadcock extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Joscelind Wadcock";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=36

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardWadcockBigTexture'

    strDescriptionId="WizCard_0032"

    Skin=Texture'HGame.Skins.WizardCardWadcockTex0'

}
