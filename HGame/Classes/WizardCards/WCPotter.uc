//================================================================================
// WCPotter.
//================================================================================

class WCPotter extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Harry Potter";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=100

    textureBig=Texture'HGame.Icons.WizCardPotterBigTexture'

    strDescriptionId="WizCard_0038"

    textureLayers(0)=Texture'HGame.Icons.WizCardHarryBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardHarryBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardHarryBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardPotterTex0'

}
