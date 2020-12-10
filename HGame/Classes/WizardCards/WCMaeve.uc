//================================================================================
// WCMaeve.
//================================================================================

class WCMaeve extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardMaeveBigTexture.PNG	GROUP=Icons	Name=WizCardMaeveBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardMaeveTex0.PNG	GROUP=Skins	Name=WizardCardMaeveTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Queen Maeve";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=71

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardMaeveBigTexture'

    strDescriptionId="WizCard_0065"

    Skin=Texture'HGame.Skins.WizardCardMaeveTex0'

}
