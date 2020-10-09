//================================================================================
// WCSmethwyck.
//================================================================================

class WCSmethwyck extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Leopoldina Smethwyck";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=70

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardSmethwyckBigTexture'

    strDescriptionId="WizCard_0064"

    Skin=Texture'HGame.Skins.WizardCardSmethwyckTex0'

}
