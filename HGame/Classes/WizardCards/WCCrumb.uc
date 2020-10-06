//================================================================================
// WCCrumb.
//================================================================================

class WCCrumb extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Gideon Crumb";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=56

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE020"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCrumbBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCrumbBigTexture'

    strDescriptionId="WizCard_0092"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCrumbTex0'
	Skin=Texture'HGame.Skins.WizardCardCrumbTex0'
}
