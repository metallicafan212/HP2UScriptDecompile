//================================================================================
// WCPlatt.
//================================================================================

class WCPlatt extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Yardley Platt";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=95

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardPlattBigTexture'

    strDescriptionId="WizCard_0014"

    Skin=Texture'HGame.Skins.WizardCardPlattTex0'

}
