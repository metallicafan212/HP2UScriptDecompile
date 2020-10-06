//================================================================================
// WCBarkwith.
//================================================================================

class WCBarkwith extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Musidora Barkwith";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=50

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBarkwithBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBarkwithBigTexture'

    strDescriptionId="WizCard_0008"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBarkwithTex0'
	Skin=Texture'HGame.Skins.WizardCardBarkwithTex0'
}
