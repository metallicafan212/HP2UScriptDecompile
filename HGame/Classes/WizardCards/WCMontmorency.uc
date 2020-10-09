//================================================================================
// WCMontmorency.
//================================================================================

class WCMontmorency extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Laverne de Montmorency";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=60

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardMontmorencyBigTexture'

    strDescriptionId="WizCard_0096"

    Skin=Texture'HGame.Skins.WizardCardMontmorencyTex0'

}
