//================================================================================
// WCSykes.
//================================================================================

class WCSykes extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Jocunda Sykes";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=64

    textureBig=Texture'HGame.Icons.WizCardSykesBigTexture'

    strDescriptionId="WizCard_0067"

    Skin=Texture'HGame.Skins.WizardCardSykesTex0'

}
