//================================================================================
// WCScamander.
//================================================================================

class WCScamander extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Newt Scamander";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=19

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardScamanderBigTexture'

    strDescriptionId="WizCard_0027"

    Skin=Texture'HGame.Skins.WizardCardScamanderTex0'

}
