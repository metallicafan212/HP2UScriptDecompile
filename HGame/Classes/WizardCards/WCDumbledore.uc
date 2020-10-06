//================================================================================
// WCDumbledore.
//================================================================================

class WCDumbledore extends Goldcards;

function PostBeginPlay ()
{
  WizardName = "Albus Dumbledore";
  Super.PostBeginPlay();
}

defaultproperties
{
    Id=101

	//you have to do this for every card... -AdamJD
	//
    // textureBig=Texture'Icons.WizCardDumbledoreBigTexture'
	textureBig=Texture'HGame.Icons.WizCardDumbledoreBigTexture'

    strDescriptionId="WizCard_0100"
	
	//you have to do this for every gold card... -AdamJD
	//
	textureLayers(0)=Texture'HGame.Icons.WizCardAlbusBigTextureLayer0'
    textureLayers(1)=Texture'HGame.Icons.WizCardAlbusBigTextureLayer1'
    textureLayers(2)=Texture'HGame.Icons.WizCardAlbusBigTextureLayer2'

    // textureLayers(0)=Texture'Icons.WizCardAlbusBigTextureLayer0'
    // textureLayers(1)=Texture'Icons.WizCardAlbusBigTextureLayer1'
    // textureLayers(2)=Texture'Icons.WizCardAlbusBigTextureLayer2'

	//you have to do this for every card... -AdamJD
	//
    // Skin=Texture'Skins.WizardCardDumbledoreTex0'
	Skin=Texture'HGame.Skins.WizardCardDumbledoreTex0'
}
