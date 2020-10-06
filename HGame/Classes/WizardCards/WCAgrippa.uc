//================================================================================
// WCAgrippa.
//================================================================================

class WCAgrippa extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Cornelius Agrippa";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=2

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardAgrippaBigTexture'
	textureBig=Texture'HGame.Icons.WizCardAgrippaBigTexture'

    strDescriptionId="WizCard_0040"
	
	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardAgrippaTex0'
	Skin=Texture'HGame.Skins.WizardCardAgrippaTex0'
}
