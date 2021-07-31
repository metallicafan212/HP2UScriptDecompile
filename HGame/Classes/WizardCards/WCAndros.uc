//================================================================================
// WCAndros.
//================================================================================

class WCAndros extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardAndrosBigTexture.PNG	GROUP=Icons	Name=WizCardAndrosBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardAndrosTex0.PNG	GROUP=Skins	Name=WizardCardAndrosTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Andros the Invincible";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=13

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"
	
	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardAndrosBigTexture'
	textureBig=Texture'HGame.Icons.WizCardAndrosBigTexture'

    strDescriptionId="WizCard_0051"

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardAndrosTex0'
	Skin=Texture'HGame.Skins.WizardCardAndrosTex0'
}
