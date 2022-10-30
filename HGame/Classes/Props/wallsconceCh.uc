//================================================================================
// wallsconceCh.
//================================================================================

class wallsconceCh extends HCandlesLamps;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skwallsconceChMesh'

	//fix the torch and particle draw order issue if no owner is set (to be compatible with the new engine) -AdamJD  
	bDrawColPFXFirst=True
}
