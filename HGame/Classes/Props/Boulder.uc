//================================================================================
// Boulder.
//================================================================================

class Boulder extends HProp;

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
	GotoState('patrol');
	return True;
}

function Trigger (Actor Other, Pawn EventInstigator)
{
	HandleSpellFlipendo();
}

function _PostPawnAtPatrolPoint (PatrolPoint CurrentP, PatrolPoint NextP)
{
	if ( CurrentP.PauseTime > 0 )
	{
		LoopAnim(IdleAnimName);
		GotoState('stateIdle');
	} 
	else 
	{
		Super._PostPawnAtPatrolPoint(CurrentP,NextP);
	}
}

defaultproperties
{
    IdleAnimName=Stop

    WalkAnimName=Roll

    RunAnimName=Roll

    Physics=PHYS_Walking

    Mesh=SkeletalMesh'HPModels.skboulderMesh'

    CollisionRadius=44.00

    CollisionHeight=44.00

}