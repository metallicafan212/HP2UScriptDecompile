//================================================================================
// WCStalk.
//================================================================================

class WCStalk extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Blenheim Stalk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=85

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardStalkBigTexture'

    strDescriptionId="WizCard_0010"

    Skin=Texture'HGame.Skins.WizardCardStalkTex0'

}
