//================================================================================
// WCMuldoon.
//================================================================================

class WCMuldoon extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Burdock Muldoon";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=10

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE100"

    textureBig=Texture'HGame.Icons.WizCardMuldoonBigTexture'

    strDescriptionId="WizCard_0037"

    Skin=Texture'HGame.Skins.WizardCardMuldoonTex0'

}
