//================================================================================
// WCMarjoribanks.
//================================================================================

class WCMarjoribanks extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMarjoribanksBigTexture.PNG	GROUP=Icons	Name=WizCardMarjoribanksBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardMarjoribanksTex0.PNG	GROUP=Skins	Name=WizardCardMarjoribanksTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Beaumont Marjoribanks";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=33

    textureBig=Texture'HGame.Icons.WizCardMarjoribanksBigTexture'

    strDescriptionId="WizCard_0029"

    Skin=Texture'HGame.Skins.WizardCardMarjoribanksTex0'

}
