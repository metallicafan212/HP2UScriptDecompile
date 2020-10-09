//================================================================================
// WCShingleton.
//================================================================================

class WCShingleton extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Gaspard Shingleton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=54

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardShingletonBigTexture'

    strDescriptionId="WizCard_0079"

    Skin=Texture'HGame.Skins.WizardCardShingletonTex0'

}
