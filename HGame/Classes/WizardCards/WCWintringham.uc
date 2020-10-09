//================================================================================
// WCWintringham.
//================================================================================

class WCWintringham extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Herman Wintringham";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=63

    textureBig=Texture'HGame.Icons.WizCardWintringhamBigTexture'

    strDescriptionId="WizCard_0069"

    Skin=Texture'HGame.Skins.WizardCardWintringhamTex0'

}
