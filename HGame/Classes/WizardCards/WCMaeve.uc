//================================================================================
// WCMaeve.
//================================================================================

class WCMaeve extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Queen Maeve";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=71

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardMaeveBigTexture'

    strDescriptionId="WizCard_0065"

    Skin=Texture'HGame.Skins.WizardCardMaeveTex0'

}
