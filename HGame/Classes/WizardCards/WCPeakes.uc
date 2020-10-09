//================================================================================
// WCPeakes.
//================================================================================

class WCPeakes extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Glanmore Peakes";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=6

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardPeakesBigTexture'

    strDescriptionId="WizCard_0044"

    Skin=Texture'HGame.Skins.WizardCardPeakesTex0'

}
