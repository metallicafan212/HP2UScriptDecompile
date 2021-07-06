//================================================================================
// WCPlunkett.
//================================================================================

class WCPlunkett extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardPlunkettBigTexture.PNG	GROUP=Icons	Name=WizCardPlunkettBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardPlunkettTex0.PNG	GROUP=Skins	Name=WizardCardPlunkettTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Mirabella Plunkett";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=27

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardPlunkettBigTexture'

    strDescriptionId="WizCard_0023"

    Skin=Texture'HGame.Skins.WizardCardPlunkettTex0'

}
