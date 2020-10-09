//================================================================================
// WCWenlock.
//================================================================================

class WCWenlock extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Bridget Wenlock";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=32

    textureBig=Texture'HGame.Icons.WizCardWenlockBigTexture'

    strDescriptionId="WizCard_0028"

    Skin=Texture'HGame.Skins.WizardCardWenlockTex0'

}
