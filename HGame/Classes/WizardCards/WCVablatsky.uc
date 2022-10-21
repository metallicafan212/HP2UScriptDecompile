//================================================================================
// WCVablatsky.
//================================================================================

class WCVablatsky extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardVablatskyBigTexture.PNG	GROUP=Icons	Name=WizCardVablatskyBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardVablatskyTex0.PNG	GROUP=Skins	Name=WizardCardVablatskyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Cassandra Vablatsky";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=37

    textureBig=Texture'HGame.Icons.WizCardVablatskyBigTexture'

    strDescriptionId="WizCard_0033"

    Skin=Texture'HGame.Skins.WizardCardVablatskyTex0'

}
