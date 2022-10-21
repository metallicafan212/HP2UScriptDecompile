//================================================================================
// WCCirce.
//================================================================================

class WCCirce extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardCirceBigTexture.PNG	GROUP=Icons	Name=WizCardCirceBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardCirceTex0.PNG	GROUP=Skins	Name=WizardCardCirceTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
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
