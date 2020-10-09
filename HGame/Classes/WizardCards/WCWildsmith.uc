//================================================================================
// WCWildsmith.
//================================================================================

class WCWildsmith extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Ignatia Wildsmith";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=62

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardWildsmithBigTexture'

    strDescriptionId="WizCard_0098"

    Skin=Texture'HGame.Skins.WizardCardWildsmithTex0'

}
