//================================================================================
// WCSawbridge.
//================================================================================

class WCSawbridge extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardSawbridgeBigTexture.PNG	GROUP=Icons	Name=WizCardSawbridgeBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardSawbridgeTex0.PNG	GROUP=Skins	Name=WizardCardSawbridgeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Almerick Sawbridge";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=26

    textureBig=Texture'HGame.Icons.WizCardSawbridgeBigTexture'

    strDescriptionId="WizCard_0022"

    Skin=Texture'HGame.Skins.WizardCardSawbridgeTex0'

}
