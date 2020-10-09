//================================================================================
// WCOglethorpe.
//================================================================================

class WCOglethorpe extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Dunbar Oglethorpe";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=45

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardOglethorpeBigTexture'

    strDescriptionId="WizCard_0083"

    Skin=Texture'HGame.Skins.WizardCardOglethorpeTex0'

}
