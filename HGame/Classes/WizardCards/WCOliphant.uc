//================================================================================
// WCOliphant.
//================================================================================

class WCOliphant extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Gondoline Oliphant";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=65

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardOliphantBigTexture'

    strDescriptionId="WizCard_0088"

    Skin=Texture'HGame.Skins.WizardCardOliphantTex0'

}
