//================================================================================
// WCDuke.
//================================================================================

class WCDuke extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Kirley Duke";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=68

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE020"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardDukeBigTexture'
	textureBig=Texture'HGame.Icons.WizCardDukeBigTexture'

    strDescriptionId="WizCard_0062"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardDukeTex0'
	Skin=Texture'HGame.Skins.WizardCardDukeTex0'
}
