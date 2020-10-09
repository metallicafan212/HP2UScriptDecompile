//================================================================================
// WCHipworth.
//================================================================================

class WCHipworth extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Glover Hipworth";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=58

    textureBig=Texture'HGame.Icons.WizCardHipworthBigTexture'

    strDescriptionId="WizCard_0094"

    Skin=Texture'HGame.Skins.WizardCardHipworthTex0'

}
