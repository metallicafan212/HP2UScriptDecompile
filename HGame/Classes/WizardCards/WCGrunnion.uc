//================================================================================
// WCGrunnion.
//================================================================================

class WCGrunnion extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardGrunnionBigTexture.PNG	GROUP=Icons	Name=WizCardGrunnionBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardGrunnionTex0.PNG	GROUP=Skins	Name=WizardCardGrunnionTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Alberic Grunnion";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=97

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE130"

    textureBig=Texture'HGame.Icons.WizCardGrunnionBigTexture'

    strDescriptionId="WizCard_0013"

    Skin=Texture'HGame.Skins.WizardCardGrunnionTex0'

}
