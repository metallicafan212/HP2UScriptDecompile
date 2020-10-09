//================================================================================
// WCKegg.
//================================================================================

class WCKegg extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Roland Kegg";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=84

    textureBig=Texture'HGame.Icons.WizCardKeggBigTexture'

    strDescriptionId="WizCard_0090"

    Skin=Texture'HGame.Skins.WizardCardKeggTex0'

}
