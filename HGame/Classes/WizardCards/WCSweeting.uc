//================================================================================
// WCSweeting.
//================================================================================

class WCSweeting extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Havelock Sweeting";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=61

    textureBig=Texture'HGame.Icons.WizCardSweetingBigTexture'

    strDescriptionId="WizCard_0097"

    Skin=Texture'HGame.Skins.WizardCardSweetingTex0'

}
