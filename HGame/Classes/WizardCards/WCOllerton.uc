//================================================================================
// WCOllerton.
//================================================================================

class WCOllerton extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardOllertonBigTexture.PNG	GROUP=Icons	Name=WizCardOllertonBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardOllertonTex0.PNG	GROUP=Skins	Name=WizardCardOllertonTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Gifford Ollerton";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=57

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE150"

    textureBig=Texture'HGame.Icons.WizCardOllertonBigTexture'

    strDescriptionId="WizCard_0093"

    Skin=Texture'HGame.Skins.WizardCardOllertonTex0'

}
