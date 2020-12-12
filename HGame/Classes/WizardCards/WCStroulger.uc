//================================================================================
// WCStroulger.
//================================================================================

class WCStroulger extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardStroulgerBigTexture.PNG	GROUP=Icons	Name=WizCardStroulgerBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardStroulgerTex0.PNG	GROUP=Skins	Name=WizardCardStroulgerTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Edgar Stroulger";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=47

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE110"

    textureBig=Texture'HGame.Icons.WizCardStroulgerBigTexture'

    strDescriptionId="WizCard_0085"

    Skin=Texture'HGame.Skins.WizardCardStroulgerTex0'

}
