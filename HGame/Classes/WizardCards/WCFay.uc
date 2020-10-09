//================================================================================
// WCFay.
//================================================================================

class WCFay extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Morgan le Fay";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=17

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardFayBigTexture'

    strDescriptionId="WizCard_0055"

    Skin=Texture'HGame.Skins.WizardCardFayTex0'

}
