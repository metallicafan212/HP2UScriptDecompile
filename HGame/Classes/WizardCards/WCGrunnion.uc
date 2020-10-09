//================================================================================
// WCGrunnion.
//================================================================================

class WCGrunnion extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Alberic Grunnion";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=97

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardGrunnionBigTexture'

    strDescriptionId="WizCard_0013"

    Skin=Texture'HGame.Skins.WizardCardGrunnionTex0'

}
