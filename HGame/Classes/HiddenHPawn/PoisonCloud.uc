//================================================================================
// PoisonCloud.
//================================================================================

class PoisonCloud extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var float fLifetime;
var bool bCanBeThrown;
var float timeSafe;
var bool bCanBeTouched;
var float iDamage;
var float DamageInterval;
var float waitTime;
var float collideRadius;

function PostBeginPlay()
{
	local HPawn Pawn;

	SetTimer(fLifetime,False);
}

function Timer()
{
	Destroy();
}

function Tick (float DeltaTime)
{
	Super.Tick(DeltaTime);
	waitTime += DeltaTime;
	if ( waitTime > DamageInterval )
	{
		waitTime = 0.0;
		bCanBeTouched = True;
	}
	if ( VSize(Location - PlayerHarry.Location) <= PlayerHarry.CollisionRadius + CollisionRadius )
	{
		if ( bCanBeTouched )
		{
			bCanBeTouched = False;
			if ( !baseHUD(PlayerHarry.myHUD).bCutSceneMode )
			{
				PlayerHarry.TakeDamage(iDamage,Pawn(Owner),Location,Velocity * 1,'PoisonCloud');
			}
		}
	}
}

function Touch (Actor Other)
{
	local HPawn HPawnHit;

	if ( (Other == PlayerHarry) && (bCanBeTouched) )
	{
		//KW left this empty? -AdamJD
	}
	else
	{
		if ( Other.IsA('HPawn') &&  !Other.IsA('PoisonCloud') &&  !Other.IsA('ThrownPoisonCloud') &&  !Other.IsA('HorklumpsHead') &&  !Other.IsA('HorklumpsStem') && (bCanBeThrown) )
		{
			if ( !baseHUD(PlayerHarry.myHUD).bCutSceneMode )
			{
				HPawnHit = HPawn(Other);
				if ( BOOL_DEBUG_AI )
				{
					PlayerHarry.ClientMessage(string(self) $ " Hit something : " $ string(HPawnHit));
				}
				HPawnHit.HitByThrownObject(1,HPawnHit,Location,Velocity * 1,'PoisonCloud');
			}
		}
	}
	PlaySound(Sound'spell_hit',SLOT_Interact,1.0,False,2000.0,1.0);
}

function Bump (Actor Other)
{
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("I have been bumped ");
	}
	Touch(Other);
}

function playCloudSound()
{
	local Sound cloudSound;
	local int randNum;

	randNum = Rand(6);
	switch (randNum)
	{
		case 0:
			cloudSound = Sound'ss_COS_venomland_01E';
			break;
		case 1:
			cloudSound = Sound'ss_COS_venomland_02E';
			break;
		case 2:
			cloudSound = Sound'ss_COS_venomland_03E';
			break;
		case 3:
			cloudSound = Sound'ss_COS_venomland_04E';
			break;
		case 4:
			cloudSound = Sound'ss_COS_venomland_05E';
			break;
		case 5:
			cloudSound = Sound'ss_COS_venomland_06E';
			break;
		default:
			cloudSound = Sound'ss_COS_venomland_01E';
			break;
	}
	PlaySound(cloudSound,SLOT_None,RandRange(0.62,1.0),,3000.0,RandRange(0.5,1.62),,False);
}

auto state StartHere
{
	begin:
		SetCollisionSize(collideRadius,Default.CollisionHeight);
		playCloudSound();
}

defaultproperties
{
    bTouch=True

    fLifetime=1.50

    bCanBeTouched=True

    iDamage=1.00

    DamageInterval=0.50

    attachedParticleClass(0)=Class'HPParticle.Hork01'

    DrawType=DT_None

    CollisionRadius=35.00

    CollisionHeight=32.00

    bCollideActors=True

    bCollideWorld=True

}