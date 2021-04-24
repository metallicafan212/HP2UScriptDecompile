//================================================================================
// RewardBronze.
//================================================================================

class RewardBronze extends Reward01;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    Textures(0)=Texture'HPParticle.hp_fx.Particles.Reward_Bronze'
}
