//================================================================================
// WCMerlin.
//================================================================================

class WCMerlin extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Merlin";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=1

    textureBig=Texture'HGame.Icons.WizCardMerlinBigTexture'

    strDescriptionId="WizCard_0039"

    Skin=Texture'HGame.Skins.WizardCardMerlinTex0'

}
