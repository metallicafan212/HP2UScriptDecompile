//================================================================================
// WCPlunkett.
//================================================================================

class WCPlunkett extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Mirabella Plunkett";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=27

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardPlunkettBigTexture'

    strDescriptionId="WizCard_0023"

    Skin=Texture'HGame.Skins.WizardCardPlunkettTex0'

}
