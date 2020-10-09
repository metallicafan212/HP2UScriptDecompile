//================================================================================
// WCWarbeck.
//================================================================================

class WCWarbeck extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Celestina Warbeck";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=88

    textureBig=Texture'HGame.Icons.WizCardWarbeckBigTexture'

    strDescriptionId="WizCard_0002"

    Skin=Texture'HGame.Skins.WizardCardWarbeckTex0'

}
