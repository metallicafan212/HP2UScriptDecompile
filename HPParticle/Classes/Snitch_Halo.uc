//================================================================================
// Snitch_Halo.
//================================================================================

class Snitch_Halo extends Halo;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    Texture=IceTexture'HPParticle.hp_fx.General.Snitch_Halo'

    DrawScale=0.13
}
