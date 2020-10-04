//================================================================================
// ActorChaser.
//================================================================================

class ActorChaser extends HiddenHPawn;

var() bool bActive;

state stateIdle
{
	begin:
		Acceleration 	= vect(0.00,0.00,0.00);
		Velocity 		= vect(0.00,0.00,0.00);
}

auto state stateChase
{
	function Tick (float dtime)
	{
		local float f;
  
		Super.Tick(dtime);
		Acceleration = Normal(Owner.Location - Location) * AccelRate;
		Acceleration +=  -Velocity * 0.5;
		Velocity += Acceleration * dtime;
		f = VSize(Velocity);
		if ( f > AirSpeed )
		{
			Velocity *= AirSpeed / f;
		}
		SetLocation(Location + Velocity * dtime);
	}
  
}

defaultproperties
{
    bActive=True

    AirSpeed=90.00

    AccelRate=150.00

}