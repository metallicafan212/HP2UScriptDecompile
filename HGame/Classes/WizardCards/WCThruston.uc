//================================================================================
// WCThruston.
//================================================================================

class WCThruston extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Orsino Thruston";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=78

    textureBig=Texture'HGame.Icons.WizCardThrustonBigTexture'

    strDescriptionId="WizCard_0072"

    Skin=Texture'HGame.Skins.WizardCardThrustonTex0'

}
