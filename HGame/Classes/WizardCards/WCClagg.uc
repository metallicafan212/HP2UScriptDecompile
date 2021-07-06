//================================================================================
// WCClagg.
//================================================================================

class WCClagg extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardClaggBigTexture.PNG	GROUP=Icons	Name=WizCardClaggBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardClaggTex0.PNG	GROUP=Skins	Name=WizardCardClaggTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Elfrida Clagg";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=3

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardClaggBigTexture'
	textureBig=Texture'HGame.Icons.WizCardClaggBigTexture'

    strDescriptionId="WizCard_0041"
	
	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardClaggTex0'
	Skin=Texture'HGame.Skins.WizardCardClaggTex0'
}
