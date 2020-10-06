//================================================================================
// WCBlane.
//================================================================================

class WCBlane extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Balfour Blane";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=31

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBlaneBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBlaneBigTexture'

    strDescriptionId="WizCard_0016"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBlaneTex0'
	Skin=Texture'HGame.Skins.WizardCardBlaneTex0'
}
