//================================================================================
// WCPokeby.
//================================================================================

class WCPokeby extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Gulliver Pokeby";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=5

    textureBig=Texture'HGame.Icons.WizCardPokebyBigTexture'

    strDescriptionId="WizCard_0043"

    Skin=Texture'HGame.Skins.WizardCardPokebyTex0'

}
