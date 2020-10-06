//================================================================================
// WCBelby.
//================================================================================

class WCBelby extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Flavius Belby";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=66

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBelbyBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBelbyBigTexture'
	
    strDescriptionId="WizCard_0060"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBelbyTex0'
	Skin=Texture'HGame.Skins.WizardCardBelbyTex0'
}
