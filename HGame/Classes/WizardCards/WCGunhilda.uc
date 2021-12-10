//================================================================================
// WCGunhilda.
//================================================================================

class WCGunhilda extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardGunhildaBigTexture.PNG	GROUP=Icons	Name=WizCardGunhildaBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardGunhildaTex0.PNG	GROUP=Skins	Name=WizardCardGunhildaTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Gunhilda of Gorsemoor";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=9

    textureBig=Texture'HGame.Icons.WizCardGunhildaBigTexture'

    strDescriptionId="WizCard_0047"

    Skin=Texture'HGame.Skins.WizardCardGunhildaTex0'

}
