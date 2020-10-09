//================================================================================
// WCSawbridge.
//================================================================================

class WCSawbridge extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Almerick Sawbridge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=26

    textureBig=Texture'HGame.Icons.WizCardSawbridgeBigTexture'

    strDescriptionId="WizCard_0022"

    Skin=Texture'HGame.Skins.WizardCardSawbridgeTex0'

}
