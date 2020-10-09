//================================================================================
// WCYoudle.
//================================================================================

class WCYoudle extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Cyprian Youdle";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=43

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardYoudleBigTexture'

    strDescriptionId="WizCard_0081"

    Skin=Texture'HGame.Skins.WizardCardYoudleTex0'

}
