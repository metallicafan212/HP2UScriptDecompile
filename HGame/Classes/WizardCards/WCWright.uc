//================================================================================
// WCWright.
//================================================================================

class WCWright extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Bowman Wright";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=35

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardWrightBigTexture'

    strDescriptionId="WizCard_0031"

    Skin=Texture'HGame.Skins.WizardCardWrightTex0'

}
