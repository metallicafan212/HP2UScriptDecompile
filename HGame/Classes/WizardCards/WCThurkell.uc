//================================================================================
// WCThurkell.
//================================================================================

class WCThurkell extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardThurkellBigTexture.PNG	GROUP=Icons	Name=WizCardThurkellBigTexture COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2
#exec Texture Import File=Textures\Skins\WizardCardThurkellTex0.PNG	GROUP=Skins	Name=WizardCardThurkellTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay()
{
  WizardName = "Thaddeus Thurkell";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=87

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE080"

    textureBig=Texture'HGame.Icons.WizCardThurkellBigTexture'

    strDescriptionId="WizCard_0001"

    Skin=Texture'HGame.Skins.WizardCardThurkellTex0'

}
