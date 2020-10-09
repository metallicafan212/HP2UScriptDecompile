//================================================================================
// WCWoodcroft.
//================================================================================

class WCWoodcroft extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Hengist of Woodcroft";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=96

    textureBig=Texture'HGame.Icons.WizCardWoodcroftBigTexture'

    strDescriptionId="WizCard_0009"

    Skin=Texture'HGame.Skins.WizardCardWoodcroftTex0'

}
