//================================================================================
// WCSummerbee.
//================================================================================

class WCSummerbee extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Felix Summerbee";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=52

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardSummerbeeBigTexture'

    strDescriptionId="WizCard_0035"

    Skin=Texture'HGame.Skins.WizardCardSummerbeeTex0'

}
