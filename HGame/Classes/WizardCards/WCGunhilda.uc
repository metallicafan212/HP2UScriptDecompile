//================================================================================
// WCGunhilda.
//================================================================================

class WCGunhilda extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Gunhilda of Gorsemoor";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=9

    textureBig=Texture'HGame.Icons.WizCardGunhildaBigTexture'

    strDescriptionId="WizCard_0047"

    Skin=Texture'HGame.Skins.WizardCardGunhildaTex0'

}
