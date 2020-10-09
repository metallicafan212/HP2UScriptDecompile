//================================================================================
// WCMerwyn.
//================================================================================

class WCMerwyn extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Merwyn the Malicious";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=12

    textureBig=Texture'HGame.Icons.WizCardMerwynBigTexture'

    strDescriptionId="WizCard_0050"

    Skin=Texture'HGame.Skins.WizardCardMerwynTex0'

}
