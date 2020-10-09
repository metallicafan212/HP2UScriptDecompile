//================================================================================
// WCOllerton.
//================================================================================

class WCOllerton extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Gifford Ollerton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=57

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardOllertonBigTexture'

    strDescriptionId="WizCard_0093"

    Skin=Texture'HGame.Skins.WizardCardOllertonTex0'

}
