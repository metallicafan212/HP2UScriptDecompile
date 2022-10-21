//================================================================================
// WCThruston.
//================================================================================

class WCThruston extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardThrustonBigTexture.PNG	GROUP=Icons	Name=WizCardThrustonBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardThrustonTex0.PNG	GROUP=Skins	Name=WizardCardThrustonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Orsino Thruston";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=78

    textureBig=Texture'HGame.Icons.WizCardThrustonBigTexture'

    strDescriptionId="WizCard_0072"

    Skin=Texture'HGame.Skins.WizardCardThrustonTex0'

}
