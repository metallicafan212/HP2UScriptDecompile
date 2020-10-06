//================================================================================
// WCBeamish.
//================================================================================

class WCBeamish extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Oswald Beamish";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=79

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE100"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBeamishBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBeamishBigTexture'

    strDescriptionId="WizCard_0073"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBeamishTex0'
	Skin=Texture'HGame.Skins.WizardCardBeamishTex0'
}
