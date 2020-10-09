//================================================================================
// WCRavenclaw.
//================================================================================

class WCRavenclaw extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Rowena Ravenclaw";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=82

    textureBig=Texture'HGame.Icons.WizCardRavenclawBigTexture'

    strDescriptionId="WizCard_0076"

    textureLayers(0)=Texture'HGame.Icons.WizCardRowenaBigTextureLayer0'

    textureLayers(1)=Texture'HGame.Icons.WizCardRowenaBigTextureLayer1'

    textureLayers(2)=Texture'HGame.Icons.WizCardRowenaBigTextureLayer2'

    Skin=Texture'HGame.Skins.WizardCardRavenclawTex0'

}
