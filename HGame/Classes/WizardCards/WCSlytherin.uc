//================================================================================
// WCSlytherin.
//================================================================================

class WCSlytherin extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Salazar Slytherin";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=48

    textureBig=Texture'HGame.Icons.WizCardSlytherinBigTexture'

    strDescriptionId="WizCard_0086"

    Skin=Texture'HGame.Skins.WizardCardSlytherinTex0'

}
