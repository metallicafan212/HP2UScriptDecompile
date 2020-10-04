//================================================================================
// FireballGrenadeCenter.
//================================================================================

class FireballGrenadeCenter extends HiddenHPawn;

var bool bTouch;
var float fLifetime;
var(VisualFX) ParticleFX fxGrenadeParticleEffect;
var float iDamage;

function PostBeginPlay ()
{
	SetTimer(fLifetime,False);
	fxGrenadeParticleEffect = Spawn(Class'Crabfireball');
}

function Timer ()
{
	fxGrenadeParticleEffect.Shutdown();
	Destroy();
}

function Touch (Actor Other)
{
	if ( Pawn(Other) == Instigator )
	{
		return;
	}
	if ( (Other == PlayerHarry) && (bTouch) )
	{
		Other.TakeDamage(iDamage,None,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
		SetTimer(0.2,False);
		bTouch = False;
	}
	PlaySound(Sound'spell_hit',SLOT_Interact,1.0,False,2000.0,1.0);
}

function Bump (Actor Other)
{
	Touch(Other);
}

auto state stateBegin
{
}

defaultproperties
{
    bTouch=True

    fLifetime=2.50

    DrawType=DT_None

    CollisionRadius=10.00

    CollisionHeight=10.00

    bCollideActors=True

    bCollideWorld=True

}