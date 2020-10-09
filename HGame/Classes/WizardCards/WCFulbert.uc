//================================================================================
// WCFulbert.
//================================================================================

class WCFulbert extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Fulbert the Fearful";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=14

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE050"

    textureBig=Texture'HGame.Icons.WizCardFulbertBigTexture'

    strDescriptionId="WizCard_0052"

    Skin=Texture'HGame.Skins.WizardCardFulbertTex0'

}
