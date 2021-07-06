//================================================================================
// WCSlytherin.
//================================================================================

class WCSlytherin extends Goldcards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardSlytherinBigTexture.PNG	GROUP=Icons	Name=WizCardSlytherinBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardSlytherinTex0.PNG	GROUP=Skins	Name=WizardCardSlytherinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Salazar Slytherin";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=48

    textureBig=Texture'HGame.Icons.WizCardSlytherinBigTexture'

    strDescriptionId="WizCard_0086"

    Skin=Texture'HGame.Skins.WizardCardSlytherinTex0'

}
