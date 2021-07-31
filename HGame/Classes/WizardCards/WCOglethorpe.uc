//================================================================================
// WCOglethorpe.
//================================================================================

class WCOglethorpe extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardOglethorpeBigTexture.PNG	GROUP=Icons	Name=WizCardOglethorpeBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardOglethorpeTex0.PNG	GROUP=Skins	Name=WizardCardOglethorpeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Dunbar Oglethorpe";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=45

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardOglethorpeBigTexture'

    strDescriptionId="WizCard_0083"

    Skin=Texture'HGame.Skins.WizardCardOglethorpeTex0'

}
