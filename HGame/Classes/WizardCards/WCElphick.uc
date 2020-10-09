//================================================================================
// WCElphick.
//================================================================================

class WCElphick extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Wilfred Elphick";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=91

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE170"

    textureBig=Texture'HGame.Icons.WizCardElphickBigTexture'

    strDescriptionId="WizCard_0005"

    Skin=Texture'HGame.Skins.WizardCardElphickTex0'

}
