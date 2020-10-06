//================================================================================
// WCCronk.
//================================================================================

class WCCronk extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Crispin Cronk";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=42

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCronkBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCronkBigTexture'

    strDescriptionId="WizCard_0080"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCronkTex0'
	Skin=Texture'HGame.Skins.WizardCardCronkTex0'
}
