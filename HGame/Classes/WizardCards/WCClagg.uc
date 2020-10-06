//================================================================================
// WCClagg.
//================================================================================

class WCClagg extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Elfrida Clagg";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=3

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardClaggBigTexture'
	textureBig=Texture'HGame.Icons.WizCardClaggBigTexture'

    strDescriptionId="WizCard_0041"
	
	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardClaggTex0'
	Skin=Texture'HGame.Skins.WizardCardClaggTex0'
}
