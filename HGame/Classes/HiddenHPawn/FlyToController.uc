//================================================================================
// FlyToController.
//================================================================================

class FlyToController extends HiddenHPawn;

var bool bEnabled;
var HPawn H;

function PostBeginPlay ()
{
	Super.PostBeginPlay();
	if ( Owner != None )
	{
		Owner.TickParent = self;
	}
}

function EnableController ()
{
	bEnabled = True;
	H = HPawn(Owner);
	GotoState('DoingTheFlyTo');
}

function DisableController ()
{
	bEnabled = False;
	GotoState('stateIdle');
}

auto state DoingTheFlyTo
{
	event Tick (float dtime)
	{
		local float f;
		local Vector vDest;
		local bool bGotToEnd;
  
		if (  !bEnabled )
		{
			return;
		}
		if ( H == None )
		{
			return;
		}
		if ( H.fFlyToTime < H.fFlyToTimeSpan )
		{
			H.fFlyToTime += dtime;
			if ( H.fFlyToTime > H.fFlyToTimeSpan )
			{
				bGotToEnd = True;
				H.fFlyToTime = H.fFlyToTimeSpan;
			}
		}
		vDest = GetVDest();
		if ( H.fFlyToTimeSpan == 0 )
		{
			H.SetLocation(vDest);
		} 
		else 
		{
			H.SetLocation(H.vFlyToStart + (vDest - H.vFlyToStart) * EaseFunction(H.fFlyToTime / H.fFlyToTimeSpan,H.eFlyMoveType));
		}
		if ( H.fFlyToTime == H.fFlyToTimeSpan )
		{
			if ( bGotToEnd )
			{
				H.OnFlyToDone();
			}
			if (  !H.bFlyToStayLockedToActor )
			{
				bEnabled = False;
			}
		}
	}
  
}

function Vector GetVDest ()
{
	local Vector vDest;

	if ( H.aFlyToActor != None )
	{
		vDest = H.aFlyToActor.Location;
		if ( H.bFlyToFixedToDestActor )
		{
			vDest += H.vFlyToDestOffset;
		} 
		else 
		{
			vDest += H.vFlyToDestOffset >> H.aFlyToActor.Rotation;
		}
	} 
	else 
	{
		vDest = H.vFlyToDest;
	}
	return vDest;
}

defaultproperties
{
    bHidden=False

    DrawType=DT_None

}