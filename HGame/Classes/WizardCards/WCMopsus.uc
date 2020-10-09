//================================================================================
// WCMopsus.
//================================================================================

class WCMopsus extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Mopsus";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=73

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardMopsusBigTexture'

    strDescriptionId="WizCard_0078"

    Skin=Texture'HGame.Skins.WizardCardMopsusTex0'

}
