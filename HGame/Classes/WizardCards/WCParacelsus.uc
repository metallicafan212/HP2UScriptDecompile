//================================================================================
// WCParacelsus.
//================================================================================

class WCParacelsus extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Paracelsus";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=15

    textureBig=Texture'HGame.Icons.WizCardParacelsusBigTexture'

    strDescriptionId="WizCard_0053"

    Skin=Texture'HGame.Skins.WizardCardParacelsusTex0'

}
