//================================================================================
// WCWagtail.
//================================================================================

class WCWagtail extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Myron Wagtail";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=76

    textureBig=Texture'HGame.Icons.WizCardWagtailBigTexture'

    strDescriptionId="WizCard_0070"

    Skin=Texture'HGame.Skins.WizardCardWagtailTex0'

}
