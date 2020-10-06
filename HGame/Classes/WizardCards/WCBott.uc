//================================================================================
// WCBott.
//================================================================================

class WCBott extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Bertie Bott";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=69

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardBottBigTexture'
	textureBig=Texture'HGame.Icons.WizCardBottBigTexture'

    strDescriptionId="WizCard_0063"

	//you have to do this for every gold card... -AdamJD
	//
	textureLayers(0)=Texture'HGame.Icons.WizCardBertieBigTextureLayer0'
    textureLayers(1)=Texture'HGame.Icons.WizCardBertieBigTextureLayer1'
    textureLayers(2)=Texture'HGame.Icons.WizCardBertieBigTextureLayer2'

    // textureLayers(0)=Texture'Icons.WizCardBertieBigTextureLayer0'
    // textureLayers(1)=Texture'Icons.WizCardBertieBigTextureLayer1'
    // textureLayers(2)=Texture'Icons.WizCardBertieBigTextureLayer2'

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardBottTex0'
	Skin=Texture'HGame.Skins.WizardCardBottTex0'
}
