//================================================================================
// WCTremlett.
//================================================================================

class WCTremlett extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardTremlettBigTexture.PNG	GROUP=Icons	Name=WizCardTremlettBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardTremlettTex0.PNG	GROUP=Skins	Name=WizardCardTremlettTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Donaghan Tremlett";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=34

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE020"

    textureBig=Texture'HGame.Icons.WizCardTremlettBigTexture'

    strDescriptionId="WizCard_0030"

    Skin=Texture'HGame.Skins.WizardCardTremlettTex0'

}
