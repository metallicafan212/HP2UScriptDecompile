//================================================================================
// WCTugwood.
//================================================================================

class WCTugwood extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Sacharissa Tugwood";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=90

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE090"

    textureBig=Texture'HGame.Icons.WizCardTugwoodBigTexture'

    strDescriptionId="WizCard_0004"

    Skin=Texture'HGame.Skins.WizardCardTugwoodTex0'

}
