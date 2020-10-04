//================================================================================
// AragogWebAnchor.
//================================================================================

class AragogWebAnchor extends HiddenHPawn;

var Aragog Spider;
var() int iLocation;
var(VisualFX) ParticleFX fxHitParticleEffect;
var(VisualFX) Class<ParticleFX> fxHitParticleEffectClass;
var(VisualFX) ParticleFX fxReactParticleEffect;
var(VisualFX) Class<ParticleFX> fxReactParticleEffectClass;
var(VisualFX) ParticleFX fxHitMeParticleEffect;
var(VisualFX) Class<ParticleFX> fxHitMeParticleEffectClass;
var Sound HitSound;

function PostBeginPlay ()
{
	Super.PostBeginPlay();
	foreach AllActors(Class'Aragog',Spider)
	{
		break;
	}
}

function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
{
	eVulnerableToSpell = SPELL_None;
	Spider.AnchorHitBySpell(iLocation);
	GotoState('HitBySpell');
	return True;
}

state HitBySpell
{
	begin:
		HitSound = Sound'ss_ara_incendiohit_0005';
		PlaySound(HitSound,SLOT_None,RandRange(0.69999999,1.0),,150000.0,RandRange(0.81,1.0),,False);
		fxHitParticleEffect = Spawn(fxHitParticleEffectClass,,,Location);
		fxReactParticleEffect = Spawn(fxReactParticleEffectClass,,,Location);
		Sleep(0.1);
		fxHitParticleEffect.Shutdown();
		fxReactParticleEffect.Shutdown();
		killAttachedParticleFX(0.0);
		bHidden = True;
}

defaultproperties
{
    fxHitParticleEffectClass=Class'HPParticle.WebFxBase'

    fxReactParticleEffectClass=Class'HPParticle.WebDustBase'

    attachedParticleClass=Class'HPParticle.Diffindo_WebFx'

    bHidden=False

    eVulnerableToSpell=SPELL_Diffindo

    DrawType=DT_Mesh

    Mesh=SkeletalMesh'HPModels.skAragogWebBaseMesh'

    CollisionRadius=40.00

    CollisionHeight=110.00

    bCollideActors=True

    bCollideWorld=True

    bBlockActors=True

    bBlockPlayers=True

}