//================================================================================
// WCBeamish.
//================================================================================

class WCBeamish extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardBeamishBigTexture.PNG	GROUP=Icons	Name=WizCardBeamishBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardBeamishTex0.PNG	GROUP=Skins	Name=WizardCardBeamishTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
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
