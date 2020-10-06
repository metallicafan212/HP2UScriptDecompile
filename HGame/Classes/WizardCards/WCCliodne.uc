//================================================================================
// WCCliodne.
//================================================================================

class WCCliodne extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Cliodne";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=16

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCliodneBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCliodneBigTexture'

    strDescriptionId="WizCard_0054"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCliodneTex0'
	Skin=Texture'HGame.Skins.WizardCardCliodneTex0'
}
