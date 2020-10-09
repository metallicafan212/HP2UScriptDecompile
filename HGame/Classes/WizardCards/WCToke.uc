//================================================================================
// WCToke.
//================================================================================

class WCToke extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Tilly Toke";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=28

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE090"

    textureBig=Texture'HGame.Icons.WizCardTokeBigTexture'

    strDescriptionId="WizCard_0024"

    Skin=Texture'HGame.Skins.WizardCardTokeTex0'

}
