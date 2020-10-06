//================================================================================
// WCAlderton.
//================================================================================

class WCAlderton extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Archibald Alderton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=29

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardAldertonBigTexture'
    textureBig=Texture'HGame.Icons.WizCardAldertonBigTexture'

    strDescriptionId="WizCard_0036"
	
	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardAldertonTex0'
    Skin=Texture'HGame.Skins.WizardCardAldertonTex0'
}
