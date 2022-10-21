//================================================================================
// WCPeakes.
//================================================================================

class WCPeakes extends BronzeCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPeakesBigTexture.PNG	GROUP=Icons	Name=WizCardPeakesBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardPeakesTex0.PNG	GROUP=Skins	Name=WizardCardPeakesTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Glanmore Peakes";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=6

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE065"

    textureBig=Texture'HGame.Icons.WizCardPeakesBigTexture'

    strDescriptionId="WizCard_0044"

    Skin=Texture'HGame.Skins.WizardCardPeakesTex0'

}
