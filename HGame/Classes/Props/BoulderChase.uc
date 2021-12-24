//================================================================================
// BoulderChase.
//================================================================================

class BoulderChase extends HProp;

var() float FinalGroundSpeed;
var int TriggerCount;

function Trigger (Actor Other, Pawn EventInstigator)
{
	TriggerCount++;
	switch (TriggerCount)
	{
		case 1:
			PlaySound(Sound'Adv11b_blockslide_slide',,,,,,,True);
			GotoState('patrol');
			break;
		case 2:
			GroundRunSpeed = FinalGroundSpeed;
			fPatrolAnimRate *= (GroundRunSpeed / GroundSpeed);
			GroundSpeed = GroundRunSpeed;
			break;
    
	}
}

function PawnAtPatrolPoint (PatrolPoint pP)
{
	if ( pP.NextPatrol_ObjectName == 'None' )
	{
		PlaySound(Sound'Adv11b_blockslide_crash');
		GotoState('stateIdle');
		Velocity = vect(0.00,0.00,0.00);
		Acceleration = vect(0.00,0.00,0.00);
		AnimRate = 0.0;
		SetPhysics(PHYS_None);
		bCollideWorld = False;
		SetCollisionSize(CollisionRadius,300.0);
		SetCollision(True,True,True);
	}
}

state patrol
{
	function Tick (float dtime)
	{
		Super.Tick(dtime);
		if ( Rand(20) == 0 )
		{
			Spawn(Class'DustCloud01_tiny',,,Location + Vec(RandRange(-10.0,10.0),RandRange(-40.0,40.0),-100.0));
		}
	}
}

function Touch (Actor Other)
{
	if ( (Other == PlayerHarry) && IsInState('patrol') )
	{
		PlayerHarry.TakeDamage(10000,None,Location,vect(0.00,0.00,0.00),'RolledOver');
	}
}

function Bump (Actor Other)
{
	if ( Other.IsA('DiffindoVines') )
	{
		Other.Trigger(self,self);
	}
}

defaultproperties
{
    FinalGroundSpeed=170.00

    IdleAnimName=Stop

    WalkAnimName=Roll

    RunAnimName=Roll

    Physics=PHYS_Walking

    Mesh=SkeletalMesh'HPModels.skboulderMesh'

    CollisionRadius=44.00

    CollisionHeight=44.00

    Mass=1000.00

}