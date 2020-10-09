//================================================================================
// WCPilliwickle.
//================================================================================

class WCPilliwickle extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Justus Pilliwickle";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=67

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardPilliwickleBigTexture'

    strDescriptionId="WizCard_0061"

    Skin=Texture'HGame.Skins.WizardCardPilliwickleTex0'

}
