//================================================================================
// WCKegg.
//================================================================================

class WCKegg extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardKeggBigTexture.PNG	GROUP=Icons	Name=WizCardKeggBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardKeggTex0.PNG	GROUP=Skins	Name=WizardCardKeggTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Roland Kegg";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=84

    textureBig=Texture'HGame.Icons.WizCardKeggBigTexture'

    strDescriptionId="WizCard_0090"

    Skin=Texture'HGame.Skins.WizardCardKeggTex0'

}
