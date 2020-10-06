//================================================================================
// WCAndros.
//================================================================================

class WCAndros extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Andros the Invincible";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=13

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"
	
	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardAndrosBigTexture'
	textureBig=Texture'HGame.Icons.WizCardAndrosBigTexture'

    strDescriptionId="WizCard_0051"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardAndrosTex0'
	Skin=Texture'HGame.Skins.WizardCardAndrosTex0'
}
