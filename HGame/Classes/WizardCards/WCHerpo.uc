//================================================================================
// WCHerpo.
//================================================================================

class WCHerpo extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Herpo!";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=11

    textureBig=Texture'HGame.Icons.WizCardHerpoBigTexture'

    strDescriptionId="WizCard_0049"

    textureLayers(0)=Texture'HGame.Icons.WizCardHerpoBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardHerpoBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardHerpoBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardHerpoTex0'

}
