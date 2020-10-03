//================================================================================
// SpongifySheet.
//================================================================================

class SpongifySheet extends HProp;

auto state stateIdle extends stateIdle
{
	begin:
		LoopAnim(AnimSequence);
}

defaultproperties
{
    AnimSequence=Idle

    Style=STY_Translucent

    Mesh=SkeletalMesh'HPModels.skSpongifyRugMesh'

    AmbientGlow=254

    MultiSkins=WetTexture'HPParticle.hp_fx.General.SpongifyRugWet'

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

}