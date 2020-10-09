//================================================================================
// WCStarkey.
//================================================================================

class WCStarkey extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Hesper Starkey";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=7

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE000"

    textureBig=Texture'HGame.Icons.WizCardStarkeyBigTexture'

    strDescriptionId="WizCard_0045"

    Skin=Texture'HGame.Skins.WizardCardStarkeyTex0'

}
