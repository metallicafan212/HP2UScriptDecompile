//================================================================================
// WCWhitehorn.
//================================================================================

class WCWhitehorn extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Devlin Whitehorn";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=44

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardWhitehornBigTexture'

    strDescriptionId="WizCard_0082"

    Skin=Texture'HGame.Skins.WizardCardWhitehornTex0'

}
