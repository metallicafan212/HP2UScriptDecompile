//================================================================================
// WCCirce.
//================================================================================

class WCCirce extends SilverCards;

function PostBeginPlay ()
{
  WizardName = "Circe";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=22

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardCirceBigTexture'
	textureBig=Texture'HGame.Icons.WizCardCirceBigTexture'

    strDescriptionId="WizCard_0018"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardCirceTex0'
	Skin=Texture'HGame.Skins.WizardCardCirceTex0'
}
