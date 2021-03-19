//================================================================================
// Bludger_Halo.
//================================================================================

class Bludger_Halo extends Halo;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    Texture=IceTexture'HPParticle.hp_fx.General.Bludger_Halo'

    DrawScale=0.25
}
