//================================================================================
// ThrownPoisonCloud.
//================================================================================

class ThrownPoisonCloud extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var float fLifetime;
var bool bCanBeThrown;
var float timeSafe;
var bool bCanBeTouched;

function PreBeginPlay()
{
	Super.PreBeginPlay();
	SetCollision(False,False,False);
}

function PostBeginPlay()
{
	local HPawn Pawn;
	local Vector vTargetDir;

	SetTimer(fLifetime,False);
	foreach AllActors(Class'HPawn',Pawn)
	{
		if ( (Pawn == PlayerHarry) && (bCanBeTouched) )
		{
			bCanBeTouched = False;
			if ( !baseHUD(PlayerHarry.myHUD).bCutSceneMode )
			{
				if ( BOOL_DEBUG_AI )
				{
					PlayerHarry.ClientMessage(" Take Damage  to Harry Instigated By : " $ string(self));
				}
				Pawn.TakeDamage(1,Pawn(Owner),Location,Velocity * 1,'PoisonCloud');
			}
		}
		if ( bCanBeThrown )
		{
			if ( !baseHUD(PlayerHarry.myHUD).bCutSceneMode )
			{
				vTargetDir = Location - Pawn.Location;
				if ( VSize(vTargetDir) < CollisionRadius * 4 + Pawn.CollisionRadius )
				{
					if ( BOOL_DEBUG_AI )
					{
						PlayerHarry.ClientMessage(string(self) $ " Hit " $ string(Pawn));
					}
					Pawn.HitByThrownObject(1,Pawn,Location,Velocity * 1,'PoisonCloud');
				}
			}
		}
	}
	PlaySound(Sound'spell_hit',SLOT_Interact,1.0,False,2000.0,1.0);
}

function Timer()
{
	Destroy();
}

defaultproperties
{
    bTouch=True

    fLifetime=1.50

    bCanBeThrown=True

    bCanBeTouched=True

    attachedParticleClass(0)=Class'HPParticle.Hork04'

    DrawType=DT_None

    CollisionRadius=25.00

    CollisionHeight=32.00

    bCollideWorld=True

}