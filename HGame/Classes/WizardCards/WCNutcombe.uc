//================================================================================
// WCNutcombe.
//================================================================================

class WCNutcombe extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Honoria Nutcombe";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=55

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardNutcombeBigTexture'

    strDescriptionId="WizCard_0091"

    Skin=Texture'HGame.Skins.WizardCardNutcombeTex0'

}
