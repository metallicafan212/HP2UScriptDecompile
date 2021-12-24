//================================================================================
// WCDuke.
//================================================================================

class WCDuke extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardDukeBigTexture.PNG	GROUP=Icons	Name=WizCardDukeBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardDukeTex0.PNG	GROUP=Skins	Name=WizardCardDukeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Kirley Duke";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=68

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE020"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardDukeBigTexture'
	textureBig=Texture'HGame.Icons.WizCardDukeBigTexture'

    strDescriptionId="WizCard_0062"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardDukeTex0'
	Skin=Texture'HGame.Skins.WizardCardDukeTex0'
}
