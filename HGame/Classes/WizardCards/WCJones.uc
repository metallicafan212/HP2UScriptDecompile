//================================================================================
// WCJones.
//================================================================================

class WCJones extends SilverCards;

//texture imports -AdamJD
#exec Texture Import File=Textures\Icons\WizCardJonesBigTexture.PNG	GROUP=Icons	Name=WizCardJonesBigTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914
#exec Texture Import File=Textures\Skins\WizardCardJonesTex0.PNG	GROUP=Skins	Name=WizardCardJonesTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

function PostBeginPlay ()
{
  WizardName = "Gwenog Jones";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=39

    bVendorsCanSell=True

    strVendorOwnedAfterGState="GSTATE180"

    textureBig=Texture'HGame.Icons.WizCardJonesBigTexture'

    strDescriptionId="WizCard_0059"

    Skin=Texture'HGame.Skins.WizardCardJonesTex0'

}
