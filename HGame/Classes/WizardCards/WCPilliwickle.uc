//================================================================================
// WCPilliwickle.
//================================================================================

class WCPilliwickle extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPilliwickleBigTexture.PNG	GROUP=Icons	Name=WizCardPilliwickleBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardPilliwickleTex0.PNG	GROUP=Skins	Name=WizardCardPilliwickleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Justus Pilliwickle";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=67

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE120"

    textureBig=Texture'HGame.Icons.WizCardPilliwickleBigTexture'

    strDescriptionId="WizCard_0061"

    Skin=Texture'HGame.Skins.WizardCardPilliwickleTex0'

}
