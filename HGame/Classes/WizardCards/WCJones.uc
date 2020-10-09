//================================================================================
// WCJones.
//================================================================================

class WCJones extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Gwenog Jones";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=39

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardJonesBigTexture'

    strDescriptionId="WizCard_0059"

    Skin=Texture'HGame.Skins.WizardCardJonesTex0'

}
