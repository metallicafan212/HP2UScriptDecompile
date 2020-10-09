//================================================================================
// WCGraves.
//================================================================================

class WCGraves extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Merton Graves";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=94

    textureBig=Texture'HGame.Icons.WizCardGravesBigTexture'

    strDescriptionId="WizCard_0015"

    Skin=Texture'HGame.Skins.WizardCardGravesTex0'

}
