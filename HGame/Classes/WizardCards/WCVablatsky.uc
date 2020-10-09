//================================================================================
// WCVablatsky.
//================================================================================

class WCVablatsky extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Cassandra Vablatsky";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=37

    textureBig=Texture'HGame.Icons.WizCardVablatskyBigTexture'

    strDescriptionId="WizCard_0033"

    Skin=Texture'HGame.Skins.WizardCardVablatskyTex0'

}
