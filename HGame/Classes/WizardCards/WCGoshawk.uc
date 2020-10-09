//================================================================================
// WCGoshawk.
//================================================================================

class WCGoshawk extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Miranda Goshawk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=46

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardGoshawkBigTexture'

    strDescriptionId="WizCard_0084"

    Skin=Texture'HGame.Skins.WizardCardGoshawkTex0'

}
