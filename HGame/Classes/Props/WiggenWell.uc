//================================================================================
// WiggenWell.
//================================================================================

class WiggenWell extends HProp;

var float fPickupFlyTime;
var bool bTiming;
var float fTimeout;

function Spawned()
{
	SetPhysics(PHYS_Falling);
	bTiming = False;
}

function Touch (Actor Other)
{
	Super.Touch(Other);
}

auto state wwellbottlo
{
	function BeginState()
	{
		bTiming = False;
		fTimeout = 5.0;
	}
  
	function Tick (float DeltaTime)
	{
		local Rotator NewRotation;
  
		NewRotation = Rotation;
		NewRotation.Yaw += (30000 * DeltaTime);
		NewRotation.Yaw = NewRotation.Yaw & 65535;
		SetRotation(NewRotation);
		if ( bTiming )
		{
			fTimeout -= DeltaTime;
		}
	}
  
	function HitWall (Vector HitNormal, Actor Wall)
	{
		Velocity *= 0.5;
		Velocity = MirrorVectorByNormal(Velocity,HitNormal);
		bTiming = True;
		if ( bTiming && (fTimeout >=0) )
		{
			if ( Abs(Velocity.Z) > 10 )
			{
				PlaySound(Sound'bean_bounce',,Abs(Velocity.Z) / 100,,);
			}
		}
	}
	begin:
	loop:
		Sleep(1.0);
		goto ('Loop');
}

defaultproperties
{
    soundPickup=Sound'HPSounds.menu_sfx.add_item_to_HUD'

    bPickupOnTouch=True

    //PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupPotions'

    classStatusItem=Class'StatusItemWiggenwell'

    //Physics=1
	Physics=PHYS_Walking

    CollisionRadius=13.00

    CollisionHeight=8.00

    bBlockActors=False

    bBlockPlayers=False

    bProjTarget=False

    bBlockCamera=False

    bBounce=True
}