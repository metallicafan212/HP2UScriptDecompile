//================================================================================
// WCTwonk.
//================================================================================

class WCTwonk extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Norvel Twonk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=77

    textureBig=Texture'HGame.Icons.WizCardTwonkBigTexture'

    strDescriptionId="WizCard_0071"

    Skin=Texture'HGame.Skins.WizardCardTwonkTex0'

}
