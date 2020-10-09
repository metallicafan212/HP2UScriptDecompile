//================================================================================
// WCPo.
//================================================================================

class WCPo extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Quong Po";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=81

    textureBig=Texture'HGame.Icons.WizCardPoBigTexture'

    strDescriptionId="WizCard_0075"

    Skin=Texture'HGame.Skins.WizardCardPoTex0'

}
