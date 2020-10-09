//================================================================================
// WCPinkstone.
//================================================================================

class WCPinkstone extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Carlotta Pinkstone";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=40

    textureBig=Texture'HGame.Icons.WizCardPinkstoneBigTexture'

    strDescriptionId="WizCard_0017"

    bIsLayered=True

    textureLayers(0)=Texture'HGame.Icons.WizCardCarlottaBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardCarlottaBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardCarlottaBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardPinkstoneTex0'

}
