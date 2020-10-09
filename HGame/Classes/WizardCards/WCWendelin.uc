//================================================================================
// WCWendelin.
//================================================================================

class WCWendelin extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Wendelin the Weird";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=20

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardWendelinBigTexture'

    strDescriptionId="WizCard_0025"

    Skin=Texture'HGame.Skins.WizardCardWendelinTex0'

}
