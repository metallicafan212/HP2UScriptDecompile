//================================================================================
// WCBloxam.
//================================================================================

class WCBloxam extends BronzeCards;

function PostBeginPlay ()
{
  WizardName = "Beatrix Bloxham";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=80

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBloxamBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBloxamBigTexture'

    strDescriptionId="WizCard_0074"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBloxamTex0'
	Skin=Texture'HGame.Skins.WizardCardBloxamTex0'
}
