//================================================================================
// WCChittock.
//================================================================================

class WCChittock extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardChittockBigTexture.PNG	GROUP=Icons	Name=WizCardChittockBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardChittockTex0.PNG	GROUP=Skins	Name=WizardCardChittockTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
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
