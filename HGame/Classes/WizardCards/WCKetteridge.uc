//================================================================================
// WCKetteridge.
//================================================================================

class WCKetteridge extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Elladora Ketteridge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=49

    textureBig=Texture'HGame.Icons.WizCardKetteridgeBigTexture'

    strDescriptionId="WizCard_0087"

    Skin=Texture'HGame.Skins.WizardCardKetteridgeTex0'

}
