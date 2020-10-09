//================================================================================
// WCWithers.
//================================================================================

class WCWithers extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Lord Stoddard Withers";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=21

    textureBig=Texture'HGame.Icons.WizCardWithersBigTexture'

    strDescriptionId="WizCard_0046"

    Skin=Texture'HGame.Skins.WizardCardWithersTex0'

}
