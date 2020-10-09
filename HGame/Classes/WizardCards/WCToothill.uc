//================================================================================
// WCToothill.
//================================================================================

class WCToothill extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Alberta Toothill";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=89

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardToothillBigTexture'

    strDescriptionId="WizCard_0003"

    Skin=Texture'HGame.Skins.WizardCardToothillTex0'

}
