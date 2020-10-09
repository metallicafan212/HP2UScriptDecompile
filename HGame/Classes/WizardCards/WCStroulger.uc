//================================================================================
// WCStroulger.
//================================================================================

class WCStroulger extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Edgar Stroulger";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=47

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardStroulgerBigTexture'

    strDescriptionId="WizCard_0085"

    Skin=Texture'HGame.Skins.WizardCardStroulgerTex0'

}
