//================================================================================
// WCThurkell.
//================================================================================

class WCThurkell extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Thaddeus Thurkell";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=87

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardThurkellBigTexture'

    strDescriptionId="WizCard_0001"

    Skin=Texture'HGame.Skins.WizardCardThurkellTex0'

}
