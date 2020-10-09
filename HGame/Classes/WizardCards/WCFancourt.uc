//================================================================================
// WCFancourt.
//================================================================================

class WCFancourt extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Perpetua Fancourt";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=25

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardFancourtBigTexture'

    strDescriptionId="WizCard_0021"

    Skin=Texture'HGame.Skins.WizardCardFancourtTex0'

}
