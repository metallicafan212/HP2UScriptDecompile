//================================================================================
// WCShimpling.
//================================================================================

class WCShimpling extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Derwent Shimpling";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=8

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardShimplingBigTexture'

    strDescriptionId="WizCard_0057"

    Skin=Texture'HGame.Skins.WizardCardShimplingTex0'

}
