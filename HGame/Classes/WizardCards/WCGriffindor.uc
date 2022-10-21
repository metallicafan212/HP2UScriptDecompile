//================================================================================
// WCGriffindor.
//================================================================================

class WCGriffindor extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardGryffindorBigTexture.PNG	GROUP=Icons	Name=WizCardGryffindorBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardGryffindorTex0.PNG	GROUP=Skins	Name=WizardCardGryffindorTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Godric Gryffindor";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=41

    textureBig=Texture'HGame.Icons.WizCardGryffindorBigTexture'

    strDescriptionId="WizCard_0048"

    Skin=Texture'HGame.Skins.WizardCardGryffindorTex0'

}
