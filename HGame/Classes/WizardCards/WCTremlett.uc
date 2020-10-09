//================================================================================
// WCTremlett.
//================================================================================

class WCTremlett extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Donaghan Tremlett";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=34

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE020"

    textureBig=Texture'HGame.Icons.WizCardTremlettBigTexture'

    strDescriptionId="WizCard_0030"

    Skin=Texture'HGame.Skins.WizardCardTremlettTex0'

}
