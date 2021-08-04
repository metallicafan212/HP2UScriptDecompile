//================================================================================
// FireballLarge.
//================================================================================

class FireballLarge extends HiddenHPawn;

var bool bTouch;
var float fLifetime;
var(VisualFX) ParticleFX fxGrenadeParticleEffect;
var float GrenadeRadius;
var float GrenadeExplosionGravity;
var float iDamage;
var float smallDamage;

function PostBeginPlay()
{
	SetTimer(fLifetime,False);
	fxGrenadeParticleEffect = Spawn(Class'Crabfire3');
}

function ShootFireballs()
{
	local int I;
	local Crabfire Fireball;
	local spellFireSmall smallFire;
	local FireballGrenadeCenter centerFire;
	local int NumFireballs;
	local Rotator rotate_fireball;
	local Vector fireball_locn;
	local Vector harrys_head;
	local Vector currentLoc;
	local Rotator currentRot;
	local float grenadeDamage;
	local float ratio;

	harrys_head 			= PlayerHarry.Location;
	harrys_head.Z 	   	   += PlayerHarry.CollisionHeight / 2;
	NumFireballs 			= 10;
	rotate_fireball 		= rotator(harrys_head - Location);
	rotate_fireball.Roll 	= 0;
	rotate_fireball.Pitch  += (65536 * 10) / 4;
	if ( VSize(PlayerHarry.Location - Location) < GrenadeRadius )
	{
		PlayerHarry.ShakeView(0.31,200.0,200.0);
		ratio 			= VSize(PlayerHarry.Location - Location) / GrenadeRadius;
		grenadeDamage 	= iDamage - (iDamage * ratio);
		PlayerHarry.TakeDamage(grenadeDamage,None,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
	}
	for(i = 0; i < NumFireballs; i++)
	{
		rotate_fireball.Yaw 				= (65536 / NumFireballs) * I + Rand(10000);
		fireball_locn 						= Location + vect(0.00,0.00,5.00);
		smallFire 							= Spawn(Class'spellFireSmall',Owner,,fireball_locn,rotate_fireball);
		smallFire.iDamage 					= smallDamage;
		smallFire.GrenadeExplosionGravity 	= GrenadeExplosionGravity;
	}
	
	currentLoc = OldLocation;
	currentRot = Rotation;
	fxGrenadeParticleEffect.Shutdown();
	Destroy();
	
	for(i = 0; i < NumFireballs * 2; i++)
	{
		// Metallicafan212:	There probably was some code here at some point, but it got commented out
	}
	centerFire 			= Spawn(Class'FireballGrenadeCenter',Owner,,currentLoc,currentRot);
	centerFire.iDamage 	= iDamage;
}

function Timer()
{
	ShootFireballs();
}

function Touch (Actor Other)
{
	if ( Pawn(Other) == Instigator )
	{
		return;
	}
	if ( (Other == PlayerHarry) && (bTouch == True) )
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