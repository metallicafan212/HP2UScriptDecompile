//================================================================================
// WCGregory.
//================================================================================

class WCGregory extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardGregoryBigTexture.PNG	GROUP=Icons	Name=WizCardGregoryBigTexture COMPRESSION=3 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardGregoryTex0.PNG	GROUP=Skins	Name=WizardCardGregoryTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Gregory the Smarmy";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=59

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE050"

    textureBig=Texture'HGame.Icons.WizCardGregoryBigTexture'

    strDescriptionId="WizCard_0095"

    Skin=Texture'HGame.Skins.WizardCardGregoryTex0'

}
