//================================================================================
// WCKnightley.
//================================================================================

class WCKnightley extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Montague Knightley";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=74

    textureBig=Texture'HGame.Icons.WizCardKnightleyBigTexture'

    strDescriptionId="WizCard_0068"

    textureLayers(0)=Texture'HGame.Icons.WizCardMontagueBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardMontagueBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardMontagueBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardKnightleyTex0'

}
