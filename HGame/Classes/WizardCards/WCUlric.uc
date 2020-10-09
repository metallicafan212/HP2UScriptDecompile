//================================================================================
// WCUlric.
//================================================================================

class WCUlric extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Uric the Oddball";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=18

    textureBig=Texture'HGame.Icons.WizCardUricBigTexture'

    strDescriptionId="WizCard_0056"

    Skin=Texture'HGame.Skins.WizardCardUricTex0'

}
