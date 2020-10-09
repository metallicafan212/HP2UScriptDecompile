//================================================================================
// WCRastrick.
//================================================================================

class WCRastrick extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Xavier Rastrick";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=92

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardRastrickBigTexture'

    strDescriptionId="WizCard_0006"

    Skin=Texture'HGame.Skins.WizardCardRastrickTex0'

}
