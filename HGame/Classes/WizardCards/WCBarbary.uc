//================================================================================
// WCBarbary.
//================================================================================

class WCBarbary extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Heathcote Barbary";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=93

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBarbaryBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBarbaryBigTexture'

    strDescriptionId="WizCard_0007"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBarbaryTex0'
	Skin=Texture'HGame.Skins.WizardCardBarbaryTex0'
}
