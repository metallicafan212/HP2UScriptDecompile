//================================================================================
// WCDodderidge.
//================================================================================

class WCDodderidge extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Daisy Dodderidge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=99

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardDodderidgeBigTexture'
	textureBig=Texture'HGame.Icons.WizCardDodderidgeBigTexture'

    strDescriptionId="WizCard_0011"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardDodderidgeTex0'
	Skin=Texture'HGame.Skins.WizardCardDodderidgeTex0'
}
