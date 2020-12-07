//================================================================================
// WCCronk.
//================================================================================

class WCCronk extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardCronkBigTexture.PNG	GROUP=Icons	Name=WizCardCronkBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardCronkTex0.PNG	GROUP=Skins	Name=WizardCardCronkTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

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
