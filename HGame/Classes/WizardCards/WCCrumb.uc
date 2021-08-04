//================================================================================
// WCCrumb.
//================================================================================

class WCCrumb extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardCrumbBigTexture.PNG	GROUP=Icons	Name=WizCardCrumbBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardCrumbTex0.PNG	GROUP=Skins	Name=WizardCardCrumbTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
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
