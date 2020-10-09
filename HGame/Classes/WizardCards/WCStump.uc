//================================================================================
// WCStump.
//================================================================================

class WCStump extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Grogan Stump";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=4

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardStumpBigTexture'

    strDescriptionId="WizCard_0042"

    Skin=Texture'HGame.Skins.WizardCardStumpTex0'

}
