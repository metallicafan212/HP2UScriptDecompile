//================================================================================
// WCChittock.
//================================================================================

class WCChittock extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Glenda Chittock";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=23

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE020"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardChittockBigTexture'
	textureBig=Texture'HGame.Icons.WizCardChittockBigTexture'

    strDescriptionId="WizCard_0019"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardChittockTex0'
	Skin=Texture'HGame.Skins.WizardCardChittockTex0'
}
