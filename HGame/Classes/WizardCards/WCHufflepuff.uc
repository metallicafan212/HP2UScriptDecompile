//================================================================================
// WCHufflepuff.
//================================================================================

class WCHufflepuff extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Helga Hufflepuff";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=72

    textureBig=Texture'HGame.Icons.WizCardHufflepuffBigTexture'

    strDescriptionId="WizCard_0066"

    textureLayers(0)=Texture'HGame.Icons.WizCardHelgaBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardHelgaBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardHelgaBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardHufflepuffTex0'

}
