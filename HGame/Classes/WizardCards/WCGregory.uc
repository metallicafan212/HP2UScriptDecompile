//================================================================================
// WCGregory.
//================================================================================

class WCGregory extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Gregory the Smarmy";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=59

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE050"

    textureBig=Texture'HGame.Icons.WizCardGregoryBigTexture'

    strDescriptionId="WizCard_0095"

    Skin=Texture'HGame.Skins.WizardCardGregoryTex0'

}
