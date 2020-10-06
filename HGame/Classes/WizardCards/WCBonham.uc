//================================================================================
// WCBonham.
//================================================================================

class WCBonham extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Mungo Bonham";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=75

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBonhamBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBonhamBigTexture'

    strDescriptionId="WizCard_0058"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBonhamTex0'
	Skin=Texture'HGame.Skins.WizardCardBonhamTex0'
}
