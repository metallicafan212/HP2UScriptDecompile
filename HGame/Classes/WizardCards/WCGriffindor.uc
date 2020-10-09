//================================================================================
// WCGriffindor.
//================================================================================

class WCGriffindor extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Godric Gryffindor";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=41

    textureBig=Texture'HGame.Icons.WizCardGryffindorBigTexture'

    strDescriptionId="WizCard_0048"

    Skin=Texture'HGame.Skins.WizardCardGryffindorTex0'

}
