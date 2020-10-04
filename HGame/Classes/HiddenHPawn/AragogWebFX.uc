//================================================================================
// AragogWebFX.
//================================================================================

class AragogWebFX extends HiddenHPawn;

var(VisualFX) ParticleFX fxHitParticleEffect;
var(VisualFX) Class<ParticleFX> fxHitParticleEffectClass;
var(VisualFX) ParticleFX fxReactParticleEffect;
var(VisualFX) Class<ParticleFX> fxReactParticleEffectClass;

function Trigger (Actor Other, Pawn EventInstigator)
{
	GotoState('stateTriggered');
}

auto state stateIdle
{
}

state stateTriggered
{
	begin:
		fxHitParticleEffect = Spawn(fxHitParticleEffectClass,,,Location);
		fxReactParticleEffect = Spawn(fxReactParticleEffectClass,,,Location);
		Sleep(0.2);
		fxHitParticleEffect.Shutdown();
		fxReactParticleEffect.Shutdown();
		bHidden = True;
}

defaultproperties
{
    fxReactParticleEffectClass=Class'HPParticle.WebDustAragog'

    Style=STY_Translucent

    Mesh=SkeletalMesh'HPModels.skAragogWebMesh'

}