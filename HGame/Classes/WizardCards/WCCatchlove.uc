//================================================================================
// WCCatchlove.
//================================================================================

class WCCatchlove extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Greta Catchlove";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=53

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCatchloveBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCatchloveBigTexture'

    strDescriptionId="WizCard_0089"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCatchloveTex0'
	Skin=Texture'HGame.Skins.WizardCardCatchloveTex0'
}
