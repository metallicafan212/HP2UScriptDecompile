//================================================================================
// WCMarjoribanks.
//================================================================================

class WCMarjoribanks extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Beaumont Marjoribanks";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=33

    textureBig=Texture'HGame.Icons.WizCardMarjoribanksBigTexture'

    strDescriptionId="WizCard_0029"

    Skin=Texture'HGame.Skins.WizardCardMarjoribanksTex0'

}
