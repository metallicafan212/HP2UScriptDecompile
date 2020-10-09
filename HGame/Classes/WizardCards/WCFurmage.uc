//================================================================================
// WCFurmage.
//================================================================================

class WCFurmage extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Dymphna Furmage";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=98

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardFurmageBigTexture'

    strDescriptionId="WizCard_0012"

    Skin=Texture'HGame.Skins.WizardCardFurmageTex0'

}
