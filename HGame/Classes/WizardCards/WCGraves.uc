//================================================================================
// WCGraves.
//================================================================================

class WCGraves extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardGravesBigTexture.PNG	GROUP=Icons	Name=WizCardGravesBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardGravesTex0.PNG	GROUP=Skins	Name=WizardCardGravesTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Merton Graves";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=94

    textureBig=Texture'HGame.Icons.WizCardGravesBigTexture'

    strDescriptionId="WizCard_0015"

    Skin=Texture'HGame.Skins.WizardCardGravesTex0'

}
