//================================================================================
// WCWaffling.
//================================================================================

class WCWaffling extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Adalbert Waffling";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=24

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardWafflingBigTexture'

    strDescriptionId="WizCard_0020"

    Skin=Texture'HGame.Skins.WizardCardWafflingTex0'

}
