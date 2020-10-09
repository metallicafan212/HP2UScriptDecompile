//================================================================================
// WCEthelred.
//================================================================================

class WCEthelred extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Ethelred the Ever-Ready";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=51

    textureBig=Texture'HGame.Icons.WizCardEthelredBigTexture'

    strDescriptionId="WizCard_0099"

    Skin=Texture'HGame.Skins.WizardCardEthelredTex0'

}
